#!/usr/bin/env bash

#
# Path
#

export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

for brewcmd in /opt/homebrew/bin/brew /usr/local/bin/brew; do
  if [[ -e "$brewcmd" ]]; then
    eval "$("$brewcmd" shellenv)"
    break
  fi
done

export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

#
# Environment
#

export TZ="America/New_York"
CDPATH="."

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vi'
else
  export EDITOR="vim"
fi
export VISUAL='code'
export PAGER='less'
