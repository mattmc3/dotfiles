#!/usr/bin/env bash

backupdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if type apm > /dev/null 2>&1 ; then
    mkdir -p "${backupdir}"
    echo "backing up atom package list..."
    apm list --installed --bare | grep -v 'node_modules' > "${backupdir}/apm-list.txt"
else
    echo "atom not found... skipping..."
fi
