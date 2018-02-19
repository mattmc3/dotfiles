#!/usr/bin/env bash

backupdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pkgctrl="${HOME}/Library/Application Support/Sublime Text 3/Packages/User"
settings_file="Package Control.sublime-settings"

if [[ -f "$pkgctrl/$settings_file" ]] ; then
    echo "backing up Sublime Text extensions..."
    cp -f "$pkgctrl/$settings_file" "$backupdir/$settings_file"
else
    echo "Sublime Text not found... skipping..."
fi
