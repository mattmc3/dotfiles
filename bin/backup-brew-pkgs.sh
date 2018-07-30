#!/usr/bin/env bash

function main() {
    backupdir="${1:-$PWD}"

    if type brew > /dev/null 2>&1 ; then
        echo "backing up Brewfile..."
        (cd "$backupdir" && brew bundle dump --force)
        echo "created Brewfile"
    else
        echo "brew not found!" 1>&2
        exit 1
    fi
}
main $@
