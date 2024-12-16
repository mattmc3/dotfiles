# shellcheck shell=bash source=/dev/null

BLE_HOME="${BLE_HOME:-${XDG_DATA_HOME:-$HOME/.local/share}/blesh}"
REPO_HOME="${REPO_HOME:-${XDG_CACHE_HOME:-$HOME/.cache}/bash/repos}"

if [[ ! -d "$BLE_HOME" ]]; then
  export PATH="/opt/homebrew/bin:$PATH"
  make -C "$REPO_HOME/akinomyoga/ble.sh" install PREFIX=~/.local
fi

# Initialize ble.sh for interactive shells. Do this near the beginning of .bashrc.
BLE_HOME="$XDG_DATA_HOME/blesh"
if [[ -d "$BLE_HOME" ]] && [[ "${PROFRC:-0}" -ne 1 ]]; then
  [[ $- == *i* ]] && source "$BLE_HOME/ble.sh" --noattach
else
  unset BLE_HOME
fi
