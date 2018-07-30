#!/usr/bin/env bash

function main() {
    backupdir="${1:-$PWD}"

    if type apm > /dev/null 2>&1 ; then
        echo "backing up list of atom packages..."
        apm list --installed --bare | grep -v 'node_modules' > "${backupdir}/apm-packages.txt"
        echo "created ${backupdir}/apm-packages.txt"
    else
        echo "atom not found!" 1>&2
        exit 1
    fi
}
main $@
