#!/usr/bin/env bash

DOTFILES="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

uninstall_dotfile() {
    if [ -L "$1" ] ; then
        echo "removing link for $1"
        local target=$(readlink $1)
        rm -rf "$1"
        cp -r "$target" "$1"
    fi
}

# runcom files
uninstall_dotfile $HOME/.bashrc
uninstall_dotfile $HOME/.bash_profile
uninstall_dotfile $HOME/.zshrc
uninstall_dotfile $HOME/.inputrc

# source uninstall.sh in modules
find $DOTFILES/modules -name "uninstall.sh" | while read file; do
    . $file
done

echo "dotfiles uninstalled!"
