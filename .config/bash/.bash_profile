#!/usr/bin/env bash
# shellcheck shell=bash source=/dev/null

[[ -z "${BASH_PROFILE_LOADED:-}" ]] || return 0
export BASH_PROFILE_LOADED=1

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
mkdir -p "$XDG_CONFIG_HOME" "$XDG_CACHE_HOME" "$XDG_DATA_HOME" "$XDG_STATE_HOME"

export BASH_HOME="${BASH_HOME:-$XDG_CONFIG_HOME/bash}"
export DOTFILES="${DOTFILES:-$HOME/.dotfiles}"

for _dir in \
  "$HOME/bin" \
  "$HOME/sbin" \
  "/opt/homebrew/bin" \
  "/opt/homebrew/sbin" \
  "/usr/local/bin" \
  "/usr/local/sbin"
do
  [[ -d "$_dir" && ":$PATH:" != *":$_dir:"* ]] && PATH="$_dir:$PATH"
done
unset _dir
export PATH

export BROWSER="${BROWSER:-open}"
export EDITOR="${EDITOR:-nvim}"
export VISUAL="${VISUAL:-code}"
export PAGER="${PAGER:-less}"
export LANG="${LANG:-en_US.UTF-8}"
export TZ="${TZ:-America/New_York}"
export LESS="${LESS:--g -i -M -R -S -w -z-4}"
export SHELL_SESSIONS_DISABLE="${SHELL_SESSIONS_DISABLE:-1}"

# Reduce key delay.
export KEYTIMEOUT="${KEYTIMEOUT:-1}"


if [[ -z "${LESSOPEN:-}" ]]; then
  if command -v lesspipe >/dev/null 2>&1; then
    export LESSOPEN="| /usr/bin/env lesspipe %s 2>&-"
  elif command -v lesspipe.sh >/dev/null 2>&1; then
    export LESSOPEN="| /usr/bin/env lesspipe.sh %s 2>&-"
  fi
fi

case $- in
  *i*)
    if [[ -z "${BASHRC_LOADED:-}" && -r "$BASH_HOME/.bashrc" ]]; then
      . "$BASH_HOME/.bashrc"
    fi
    ;;
esac
