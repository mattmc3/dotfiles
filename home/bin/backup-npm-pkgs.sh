#!/usr/bin/env bash

function main() {
    backupdir="${1:-$PWD}"

    if type npm > /dev/null 2>&1 ; then
        echo "backing up node.js global package list..."
        npm ls -g --depth=0 > "$backupdir/npm-list.txt"
        echo "Created $backupdir/npm-list.txt"
    else
        echo "npm not found!" 1>&2
        exit 1
    fi
}
main $@
