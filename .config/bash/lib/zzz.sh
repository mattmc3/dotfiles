#
# Local
#

[ -s ~/.bashrc.local ] && . ~/.bashrc.local

#
# Post
#

# Add this line at the end of .bashrc:
[[ ${BLE_VERSION-} ]] && ble-attach

# Uncomment to profile:
# if [[ ${BLE_VERSION-} ]]; then
#   ble/debug/profiler/start profile
#   ble-attach
#   ble/debug/profiler/stop
# fi
