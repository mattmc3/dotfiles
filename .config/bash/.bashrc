#!/usr/bin/env bash
# shellcheck shell=bash disable=SC2001,SC2002

BASH_THEME="hydro"

declare -a plugins=(
  __init__
  ble
  homebrew
  repos
  aliases
  atuin
  colors
  completions
  directory
  editor
  environment
  functions
  history
  macos
  magic-enter
  prompt
  python
  utils
  wezterm
  zoxide
  zzz
)

for plugin in "${plugins[@]}"; do
  if [ -r "$HOME/.config/bash/plugins/${plugin}.sh" ]; then
    source "$HOME/.config/bash/plugins/${plugin}.sh"
  else
    echo >&2 "Plugin not found: '$plugin'."
  fi
done

unset plugin
