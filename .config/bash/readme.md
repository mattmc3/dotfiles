# bashrc

## XDG base directories

Bash does not have a built-in way to use proper XDG base directory locations for
its files, so you're forced to clutter up your $HOME. But, you can minimize the
content of those $HOME files and put your real config in a different location by
creating stubs for the Bash runcoms. For example, create the following stub in
'~/.bashrc' to allow this file to live in '~/.config/bash/.bashrc'. It also allows
you to try out other configs by changing a $BASH_HOME variable, like Zsh's $ZDOTDIR.

```bash
# contents of ~/.bashrc
export BASH_HOME="${BASH_HOME:-${XDG_CONFIG_HOME:-$HOME/.config}/bash}"
[ -r "${BASH_HOME:-?}"/.bashrc ] && . "$BASH_HOME"/.bashrc

# contents of ~/.bash_profile
[ -r "${BASH_HOME:-?}"/.bash_profile ] && . "$BASH_HOME"/.bash_profile
```

## ble.sh

This config can leverage ble.sh if you have it installed. Ble.sh makes Bash a much
nicer shell to use interactively. It's optional, but recommended. See here for more
info: https://github.com/akinomyoga/ble.sh.

You can install ble.sh by running the following commands:

```bash
BLE_REPO_HOME="${XDG_CACHE_HOME:-$HOME/.cache}/repos/akinomyoga/ble.sh"
git clone --depth 1 --recurse-submodules --shallow-submodules https://github.com/akinomyoga/ble.sh "$BLE_REPO_HOME"
make -C "$BLE_REPO_HOME" install PREFIX=~/.local
```
