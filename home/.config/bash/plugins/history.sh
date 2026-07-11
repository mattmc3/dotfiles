# shellcheck shell=bash

shopt -s histappend       # Append to history, don't overwrite it.
HISTTIMEFORMAT='%F %T '   # Use standard ISO 8601 timestamp.
HISTSIZE=10000            # Remember the last x commands in memory during session
HISTFILESIZE=100000       # Start truncating history file after x lines
HISTCONTROL=ignoreboth    # ignoreboth is shorthand for ignorespace and ignoredups
HISTFILE="${BASH_DATA_HOME:-$HOME/.local/share/bash}/history"
