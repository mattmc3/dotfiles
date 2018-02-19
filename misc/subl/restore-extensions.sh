#!/usr/bin/env bash

backupdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pkgctrl="${HOME}/Library/Application Support/Sublime Text 3/Packages/User"
settings_file="Package Control.sublime-settings"

if type subl > /dev/null 2>&1 ; then
    echo "restoring Sublime Text extensions..."
    mkdir -p "$pkgctrl"
    cp -f "$backupdir/$settings_file" "$pkgctrl/$settings_file"
else
    echo "Sublime Text not found... skipping..."
fi
