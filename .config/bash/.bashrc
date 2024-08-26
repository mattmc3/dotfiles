#!/usr/bin/env bash

# Init ble.sh first.
BLE_HOME="${XDG_DATA_HOME:=$HOME/.local/share}/blesh"
[[ $- == *i* ]] && source $BLE_HOME/ble.sh --noattach

export BASH_HOME=${XDG_CONFIG_HOME:=$HOME/.config}/bash
libs=(
  __init__
  environment
  options
  history
  completion
  colors
  functions
  prompt
  clipboard
  macos
  utility
  aliases
  zzz
)
for lib in ${libs[@]}; do
  source "$BASH_HOME/lib/${lib}.sh"
done
unset lib

# Attach ble.sh last.
[[ ${BLE_VERSION-} ]] && ble-attach
