# flake.nix
{
  description = "Google Coral Workspace";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    treefmt-conf = {
      url = "github:vpayno/nix-treefmt-conf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      treefmt-conf,
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
          system = "x86_64-linux";
        };

        pythonSet = pkgs.python3.withPackages (
          ps: with ps; [
            ipython
          ]
        );
      in
      {
        formatter = treefmt-conf.formatter.${system};

        devShells = {
          default = pkgs.mkShell {

            buildInputs = with pkgs; [
              glow
              pythonSet
              runme
            ];
          };
        };
      }
    );
}
