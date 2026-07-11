#!/usr/bin/env bash
export BASH_HOME="${BASH_HOME:-${XDG_CONFIG_HOME:-$HOME/.config}/bash}"
[[ -r "$BASH_HOME/.bashrc" ]] && . "$BASH_HOME/.bashrc"
