#!/usr/bin/env bash

DOTFILES="${DOTFILES:-$HOME/dotfiles}"
settings_home="$DOTFILES/settings/home"

function pgp-decrypt-file() {
    if [[ -f "$1" ]]; then
        echo "decrypting $1"
        gpg --batch --yes --decrypt-file "$1"
    else
        echo "$1 not found. skipping decryption..."
    fi
}

IFS=$'\n'
encrypted_files=($(cat "$script_dir/encrypt.lst" | grep "^[^#\;]"))
unset IFS

for f in "${encrypted_files[@]}" ; do
    pgp-decrypt-file "$settings_home/$f.asc"
done

# restore dotfiles
# TODO prompt for confirmation
echo "rsync restoring..."
rsync -avI --exclude=".DS_Store" --exclude="*.asc" "$settings_home/" "$HOME/"

# remove decrypted files
for f in "${encrypted_files[@]}" ; do
    if [ -f "$settings_home/$f" ] ; then
        echo "cleaning secret file from backup: $f"
        rm "$settings_home/$f"
    fi
done
