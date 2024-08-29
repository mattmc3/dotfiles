BLE_REPO_HOME="${XDG_CACHE_HOME:-$HOME/.cache}/repos/akinomyoga/ble.sh"
BLE_HOME="${BLE_HOME:-${XDG_DATA_HOME:-$HOME/.local/share}/blesh}"

if [[ ! -d "$BLE_REPO_HOME" ]]; then
  git clone --recurse-submodules --depth 1 --shallow-submodules \
    https://github.com/akinomyoga/ble.sh "$BLE_REPO_HOME"

  [[ -d "$BLE_HOME" ]] && rm -rf -- "$BLE_HOME"
  export PATH="/opt/homebrew/bin:$PATH"
  make -C "$BLE_REPO_HOME" install PREFIX=~/.local
fi
