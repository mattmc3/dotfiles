#!/usr/bin/env bash
# shellcheck shell=bash disable=SC2001,SC2002

BASH_THEME="starship"
BASH_HOME=~/.config/bash

plugins=(
  __init__
  xdg
  homebrew
  ble
  repos
  atuin
  azure
  colors
  completions
  directory
  dotfiles
  dotnet
  editor
  environment
  fzf
  git
  gpg
  history
  iwd
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
