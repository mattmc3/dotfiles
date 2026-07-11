#!/usr/bin/env bash
export BASH_HOME="${BASH_HOME:-${XDG_CONFIG_HOME:-$HOME/.config}/bash}"
if [[ -r "$BASH_HOME/.bash_profile" ]]; then
  . "$BASH_HOME/.bash_profile"
elif [[ -r "$BASH_HOME/.bashrc" ]]; then
  . "$BASH_HOME/.bashrc"
fi
