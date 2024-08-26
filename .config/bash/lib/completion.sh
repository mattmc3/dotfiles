# shellcheck shell=bash source=/dev/null

#
# Completion
#

HOMEBREW_PREFIX=${HOMEBREW_PREFIX:-/opt/homebrew}
[[ -r "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh" ]] && . "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh"

# . /opt/homebrew/Cellar/bash-completion@2/2.14.0/share/bash-completion/bash_completion
