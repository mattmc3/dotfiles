if [ "${BASHPROFRC:-0}" -eq 1 ]; then
  set +x
  exec 2>&3 3>&-
fi
