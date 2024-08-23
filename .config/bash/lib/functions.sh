#!/usr/bin/env bash
#
# Functions
#

# Only add things here we cannot live without. Otherwise, use ~/bin.

# 'up 3' is a shortcut to cd 3 directories up
# you can't cd from an external script, thus it lives here
up() {
  if [[ "$#" -eq 0 ]] ; then
    cd ..
  else
    local cdstr=""
    for i in {1..$1}; do
      cdstr="../$cdstr"
    done
    cd $cdstr
  fi
}
