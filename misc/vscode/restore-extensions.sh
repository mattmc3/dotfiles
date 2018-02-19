#!/usr/bin/env bash

backupdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if type code > /dev/null 2>&1 ; then
    echo "restoring vscode packages"
    cat "$backupdir/vscode-extensions.txt" | xargs -L 1 code --install-extension
fi
