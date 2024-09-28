# shellcheck shell=bash source=/dev/null

# Completions.
if [ -r "${HOMEBREW_PREFIX:-?}/etc/profile.d/bash_completion.sh" ]; then
  . "${HOMEBREW_PREFIX:-?}/etc/profile.d/bash_completion.sh"
elif [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

[[ -n "$BLE_VERSION" ]] || return 1

function settings-for-completion {
  ble/function#advice around ble/complete/auto-complete.idle '
    if ble/string#match "${_ble_edit_str:_ble_edit_ind}" "^[[:space:]]|^$"; then
      ble/function#advice/do
    else
      ble/util/idle.wait-user-input
    fi
  '
}
blehook/eval-after-load complete settings-for-completion
