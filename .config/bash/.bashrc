#!/usr/bin/env bash
# shellcheck shell=bash disable=SC2001,SC2002

BASH_THEME="hydro"
BASH_HOME=~/.config/bash

plugins=(
  __init__
  ble
  homebrew
  repos
  atuin
  colors
  completions
  directory
  editor
  environment
  history
  macos
  magic-enter
  prompt
  python
  utils
  wezterm
  zoxide
  confd
  zzz
)

for _plugin in "${plugins[@]}"; do
  if [ -r "$BASH_HOME/plugins/${_plugin}.sh" ]; then
    source "$BASH_HOME/plugins/${_plugin}.sh"
  else
    echo >&2 "Plugin not found: '$_plugin'."
  fi
done

unset _plugin
