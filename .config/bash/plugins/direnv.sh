# shellcheck shell=bash

# Enable direnv: https://direnv.net/docs/hook.html
if type direnv >/dev/null 2>&1; then
  cached_eval direnv hook bash
  #eval "$(direnv hook bash)"
fi
