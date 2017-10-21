#!/usr/bin/env bash

DOTFILES="${DOTFILES:-$HOME/dotfiles}"
settings_home="$DOTFILES/settings/home"
script_dir="$DOTFILES/scripts"

# rsync from home
rsync -acv --include-from="$script_dir/filter.lst" $HOME/ "$settings_home/"

# secrets
function pgp-encrypt-file() {
    if [[ -f "$1" ]]; then
        echo "encrypting $1"
        test -e "$1.asc" && rm "$1.asc"
        gpg --recipient "$PERS_EMAIL" --recipient "$WORK_EMAIL" --armor=ascii --batch --encrypt "$1" &> /dev/null
        rm "$1"
    else
        echo "$1 not found. skipping encryption..."
    fi
}

IFS=$'\n'
encrypt_files=($(cat "$script_dir/encrypt.lst" | grep "^[^#\;]"))
unset IFS

for f in "${encrypt_files[@]}" ; do
    pgp-encrypt-file "$settings_home/$f"
done
