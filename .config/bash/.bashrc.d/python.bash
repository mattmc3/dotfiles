#!/usr/bin/env bash
##? venv - Manage Python venvs.

WORKON_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/venvs"
function workon() {
  if [[ "$#" -eq 0 ]]; then
    echo >&2 "workon: Expecting name of Python venv"
    return 1
  fi
  [[ -d "$WORKON_HOME" ]] || mkdir -p "$WORKON_HOME"
  if [[ ! -d "$WORKON_HOME/$1" ]]; then
    python3 -m venv "$WORKON_HOME/$1" || return 1
  fi
  source "$WORKON_HOME/$1/bin/activate"
}
