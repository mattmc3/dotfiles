#!/usr/bin/env bash

function main() {
    backupdir="${1:-$PWD}"

    if type apm > /dev/null 2>&1 ; then
        echo "backing up atom package list..."
        apm list --installed --bare | grep -v 'node_modules' > "${backupdir}/apm-list.txt"
        echo "created ${backupdir}/apm-list.txt"
    else
        echo "atom not found!" 1>&2
        exit 1
    fi
}
main $@
