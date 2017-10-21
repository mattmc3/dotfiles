#!/usr/bin/env bash

DOTFILES="${DOTFILES:-$HOME/dotfiles}"
script_dir="$DOTFILES/scripts"

# order matters
backup_modules=(
    dotfiles
    atom
    brew
    cron
    macos
    node.js
    python
    ruby
    vscode
)

for m in "${backup_modules[@]}" ; do
    if [ -f "$script_dir/$m/backup.sh" ] ; then
        . "$script_dir/$m/backup.sh"
    fi
done
