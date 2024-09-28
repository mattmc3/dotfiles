# shellcheck shell=bash disable=SC2155

[[ -n "$BLE_VERSION" ]] || return 1

function ble/widget/blerc/fancy-ctrl-z {
  local running_jobs="$(jobs | wc -l | xargs)"
  if [[ ! $_ble_edit_str ]] && [[ "$running_jobs" -gt 0 ]]; then
    ble/widget/insert-string "fg"
    ble/widget/accept-line
  else
    ble/widget/insert-string "echo :: $_ble_edit_str :: $running_jobs"
    ble/widget/accept-line
    #ble/widget/vi-editing-mode  # default
  fi
}
ble-bind -m emacs -f C-z blerc/fancy-ctrl-z
