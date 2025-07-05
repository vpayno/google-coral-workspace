# google-coral-workspace

[![actionlint](https://github.com/vpayno/google-coral-workspace/actions/workflows/gh-actions.yaml/badge.svg?branch=main)](https://github.com/vpayno/google-coral-workspace/actions/workflows/gh-actions.yaml)
[![devcontainer](https://github.com/vpayno/google-coral-workspace/actions/workflows/devcontainer.yaml/badge.svg?branch=main)](https://github.com/vpayno/google-coral-workspace/actions/workflows/devcontainer.yaml)
[![git](https://github.com/vpayno/google-coral-workspace/actions/workflows/git.yaml/badge.svg?branch=main)](https://github.com/vpayno/google-coral-workspace/actions/workflows/git.yaml)
[![json](https://github.com/vpayno/google-coral-workspace/actions/workflows/json.yaml/badge.svg?branch=main)](https://github.com/vpayno/google-coral-workspace/actions/workflows/json.yaml)
[![markdown](https://github.com/vpayno/google-coral-workspace/actions/workflows/markdown.yaml/badge.svg?branch=main)](https://github.com/vpayno/google-coral-workspace/actions/workflows/markdown.yaml)
[![shell](https://github.com/vpayno/google-coral-workspace/actions/workflows/shell.yaml/badge.svg?branch=main)](https://github.com/vpayno/google-coral-workspace/actions/workflows/shell.yaml)
[![spellcheck](https://github.com/vpayno/google-coral-workspace/actions/workflows/spellcheck.yaml/badge.svg?branch=main)](https://github.com/vpayno/google-coral-workspace/actions/workflows/spellcheck.yaml)
[![woke](https://github.com/vpayno/google-coral-workspace/actions/workflows/woke.yaml/badge.svg?branch=main)](https://github.com/vpayno/google-coral-workspace/actions/workflows/woke.yaml)
[![yaml](https://github.com/vpayno/google-coral-workspace/actions/workflows/yaml.yaml/badge.svg?branch=main)](https://github.com/vpayno/google-coral-workspace/actions/workflows/yaml.yaml)

Personal workspace for learning all things Google Coral TPU related.

## RunMe Playbook

This and other read-me files in this repo are RunMe Playbooks.

Use this playbook step/task to update the [RunMe](https://runme.dev) CLI.

If you don't have RunMe installed, you'll need to copy/paste the command. :)

```bash { background=false category=runme closeTerminalOnSuccess=true excludeFromRunAll=true interactive=true interpreter=bash name=setup-runme-install promptEnv=true terminalRows=10 }
go install github.com/stateful/runme/v3@v3
```

Setup command auto-completion:

```bash { background=false category=runme closeTerminalOnSuccess=true excludeFromRunAll=true interactive=true interpreter=bash name=setup-runme-autocompletion promptEnv=true terminalRows=10 }
if [[ -d ~/.bash_libs.d ]]; then
    runme completion bash > ~/.bash_libs.d/19.00-completion-runme.sh
    printf "Don't forget to run: %s\n" "source ~/.bash_libs.d/19.00-completion-runme.sh"
else
    runme completion bash >> ~/.bash_completion_runmme.sh
    printf "%s\n" "source ~/.bash_completion_runmme.sh" >> ~/.bashrc
    printf "Don't forget to run: %s\n" "source ~/.bashrc"
fi
```

## nix develop

Adding `nix develop` shell with Python 3.9 and `mdt`.

```text
$ nix develop

$ which mdt python3.9
/nix/store/fgdnnjzhq2i72ps9s7hazyyl57i9038n-mendel-development-tool-1.5.2/bin/mdt
/nix/store/zq6k7mxqh5xmyhy8y37cyn1p0h38b8k3-python3-3.9.2-env/bin/python3.9

$ mdt version
MDT version 1.5.2
```
