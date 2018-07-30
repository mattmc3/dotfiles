#!/usr/bin/env bash

function main() {
    backupdir="${1:-$PWD}"

    pips=(pip2 pip3)
    for pip in "${pips[@]}" ; do
        if type $pip > /dev/null 2>&1 ; then
            echo "backing up python $pip package list..."
            $pip freeze > "$backupdir/${pip}-requirements.txt"
            echo "created ${pip}-requirements.txt"
        else
            echo "skipping $pip..."
        fi
    done
}
main $@
