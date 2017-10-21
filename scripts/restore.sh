#!/usr/bin/env bash

DOTFILES="${DOTFILES:-$HOME/dotfiles}"
script_dir="$DOTFILES/scripts"

# order matters
restore_modules=(
    dotfiles
    atom
    brew
    node.js
    python
    ruby
    vscode
)

for m in "${restore_modules[@]}" ; do
    if [ -f "$script_dir/$m/restore.sh" ] ; then
        . "$script_dir/$m/restore.sh"
    fi
done
