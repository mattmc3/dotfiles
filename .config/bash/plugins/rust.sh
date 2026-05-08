# shellcheck shell=bash

_cargo_bin="${CARGO_HOME:-${XDG_DATA_HOME:-$HOME/.local/share}/cargo}/bin"
if [[ -d "$_cargo_bin" && ":$PATH:" != *":$_cargo_bin:"* ]]; then
  export PATH="$PATH:$_cargo_bin"
fi
unset _cargo_bin
