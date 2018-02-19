#!/usr/bin/env bash

backupdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if type brew > /dev/null 2>&1 ; then
    echo "restoring apps from Brewfile..."
    (cd "$backupdir" && brew bundle)
fi
