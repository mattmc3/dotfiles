#!/usr/bin/env bash

backupdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if type brew > /dev/null 2>&1 ; then
    mkdir -p "${backupdir}"
    echo "backing up Brewfile..."
    (cd "$backupdir" && brew bundle dump --force)
else
    echo "homebrew not found... skipping..."
fi
