#!/usr/bin/env bash
# shellcheck shell=bash disable=SC2001,SC2002

case $- in
  *i*) ;;
  *) return 0 ;;
esac

[[ -z "${BASHRC_LOADED:-}" ]] || return 0
BASHRC_LOADED=1

BASH_THEME="${BASH_THEME:-starship}"
BASH_HOME="${BASH_HOME:-${XDG_CONFIG_HOME:-$HOME/.config}/bash}"

if [[ -z "${BASH_PROFILE_LOADED:-}" && -r "$BASH_HOME/.bash_profile" ]]; then
  . "$BASH_HOME/.bash_profile"
fi

plugins=(
  __init__
  xdg
  homebrew
  repos
  ble
  atuin
  azure
  colors
  completions
  directory
  direnv
  dotfiles
  dotnet
  editor
  fzf
  git
  gitignore
  golang
  gpg
  history
  iwd
  java
  jupyter
  macos
  magic-enter
  nim
  node
  postgres
  prompt
  python
  ruby
  rust
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
