# flake.nix
{
  description = "Google Coral Workspace with Python 3.9";

  inputs = {
    nixpkgs-2311.url = "github:nixos/nixpkgs?ref=nixos-23.11"; # we need python 3.9

    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    treefmt-conf = {
      url = "github:vpayno/nix-treefmt-conf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pip2nix = {
      url = "github:nix-community/pip2nix";
    };
  };

  outputs =
    {
      self,
      nixpkgs-2311,
      nixpkgs,
      flake-utils,
      treefmt-conf,
      pip2nix,
      ...
    }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
    in
    flake-utils.lib.eachSystem systems (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

        pkgs-2311 = import nixpkgs-2311 {
          inherit system;
          overlays = [
            pythonOverlay
          ];
        };

        coralPkgs = with pkgs; [
          edgetpu-compiler
          # gasket
        ];

        coralDev = with pkgs; [
          libedgetpu
        ];

        mdtPythonDeps = with pkgs-2311.python39Packages; [
          cffi
          bcrypt
          cryptography
          ifaddr
          paramiko
          pycparser
          pynacl
          zeroconf
        ];

        # https://pypi.org/project/mendel-development-tool/
        # https://coral.googlesource.com/mdt
        mendel-development-tool = pkgs-2311.python39Packages.buildPythonApplication rec {
          pname = "mendel-development-tool";
          version = "1.5.2";
          name = "${pname}-${version}";
          # src = pkgs-2311.python39Packages.fetchPypi {
          #   inherit pname version;
          #   hash = "sha256-FrOUa2BEj6u73YEixOmvUITy6LDD/m6nnn33Mu1kyLE=";
          # };
          src = pkgs-2311.fetchgit {
            url = "https://coral.googlesource.com/mdt.git";
            rev = "fe0ff3d8aa50e983cb6609c7f4dd701319ce67";
            hash = "sha256-P+7UW24DCzqROxVTs89vBEX0z7uCWZWsgy0qgzm1aBE=";
          };
          doCheck = false;
          propagatedBuildInputs = mdtPythonDeps;
        };

        pythonOverlay = self: super: {
          inherit mendel-development-tool;
        };

        # virtual env alternative
        pythonSet = pkgs-2311.python39.withPackages (
          ps:
          with ps;
          [
            ipython
          ]
          ++ mdtPythonDeps
          ++ [
            mendel-development-tool
          ]
        );
      in
      {
        formatter = treefmt-conf.formatter.${system};

        packages = {
          python39 = pythonSet;
          inherit mendel-development-tool;
          pip2nix = pip2nix.packages.${system}.pip2nix.python39;
        };

        devShells = {
          default = pkgs.mkShell {
            packages =
              with pkgs;
              [
                coreutils-full
                glow
                moreutils
                runme
              ]
              ++ [
                self.packages.${system}.pip2nix
                pythonSet
                mendel-development-tool
              ]
              ++ coralPkgs;

            nativeBuildInputs = coralDev;

            shellHook = ''
              unset PYTHONPATH;

              ${pkgs.lib.getExe pkgs.cowsay} "Welcome to Google Coral Python 3.9 .#default devShell!";
              printf "\n"
            '';
          };
        };
      }
    );
}
