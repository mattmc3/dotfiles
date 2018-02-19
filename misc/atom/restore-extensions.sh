#!/usr/bin/env bash

backupdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# atom
if type apm > /dev/null 2>&1 ; then
    echo "restoring atom packages"

    lines=`cat "$backupdir/apm-list.txt"`
    for line in $lines ; do
        # the apm export has version numbers that packages-file does not need
        atom_pkg=`echo $line | awk -F'@' '{ print $1 }'`
        if [[ ! -d "$HOME/.atom/packages/$atom_pkg" ]]; then
            apm install $atom_pkg --compatible
        else
            echo "$atom_pkg package already installed"
        fi
    done
fi
