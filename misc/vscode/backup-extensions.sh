#!/usr/bin/env bash

backupdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if type code > /dev/null 2>&1 ; then
    mkdir -p "$backupdir"
    echo "backing up visual-studio-code extentions..."
    code --list-extensions > "$backupdir/vscode-extensions.txt"
else
    echo "skipping visual-studio-code..."
fi
