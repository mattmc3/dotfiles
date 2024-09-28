# shellcheck shell=bash

# Clean up '$PATH'.
# PATH="$(
#   printf %s "$PATH" |
#   awk -vRS=: -vORS= '!a[$0]++ {if (NR>1) printf(":"); printf("%s", $0) }'
# )"

# Attach ble.sh last.
[[ ${BLE_VERSION-} ]] && ble-attach

# End profiling.
if [ "${PROFRC:-0}" -eq 1 ]; then
  set +x
  exec 2>&3 3>&-
fi
