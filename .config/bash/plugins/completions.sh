# shellcheck shell=bash source=/dev/null

# Completions.
if [ -r "${HOMEBREW_PREFIX:-?}/etc/profile.d/bash_completion.sh" ]; then
  . "${HOMEBREW_PREFIX:-?}/etc/profile.d/bash_completion.sh"
elif [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi
