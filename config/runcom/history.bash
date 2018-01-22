# Use standard ISO 8601 timestamp
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
HISTTIMEFORMAT='%F %T '

PROMPT_COMMAND="history -a;history -c;history -r;$PROMPT_COMMAND"
HISTSIZE=10000          # remember the last x commands in memory during session
HISTFILESIZE=10000      # start truncating history file after x lines
HISTCONTROL=ignoreboth  # ignoreboth is shorthand for ignorespace and ignoredups
