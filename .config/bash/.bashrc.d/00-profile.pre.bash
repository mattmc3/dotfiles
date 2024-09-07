if [ "${BASHPROFRC:-0}" -eq 1 ]; then
  PS4='+ $(gdate "+%s.%N")\011 '
  exec 3>&2 2>~/.config/bash/.bashrc.$$.log
  set -x
fi
