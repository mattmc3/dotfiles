#!/usr/bin/env bash

export BASH_HOME=${XDG_CONFIG_HOME:=$HOME/.config}/bash
libs=(
  __init__
  ble
  environment
  options
  history
  colors
  functions
  prompt
  utility
  aliases
  zzz
)
for lib in ${libs[@]}; do
  source "$BASH_HOME/lib/${lib}.sh"
done
unset lib
