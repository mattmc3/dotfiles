#!/usr/bin/env bash

function main() {
    backupdir="${1:-$PWD}"

    if type gem > /dev/null 2>&1 ; then
        echo "backing up ruby gem list..."
        gem list --local > "$backupdir/gemlist.txt"
        echo "created gemlist.txt"
    else
        echo "gem not found!" 1>&2
        exit 1
    fi
}
main $@
