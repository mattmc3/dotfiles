#!/usr/bin/env bash

function main() {
    local thisdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    backupdir="${1:-$PWD}"

    if type code > /dev/null 2>&1 ; then
        echo "backing up visual-studio-code extentions..."
        code --list-extensions > "$backupdir/vscode-extensions.txt"
        echo "Created $backupdir/vscode-extensions.txt"
    else
        echo "vscode not found!" 1>&2
        exit 1
    fi
}
main $@
