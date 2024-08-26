# shellcheck shell=bash

#
# Environment
#

export TZ="America/New_York"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vi'
else
  export EDITOR="vim"
fi
export VISUAL='code'
export PAGER='less'
