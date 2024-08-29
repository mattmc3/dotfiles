BLE_HOME="${BLE_HOME:-${XDG_DATA_HOME:-$HOME/.local/share}/blesh}"

if [[ ! -d "$BLE_HOME" ]]; then
  export PATH="/opt/homebrew/bin:$PATH"
  make -C "$REPO_HOME/akinomyoga/ble.sh" install PREFIX=~/.local
fi
