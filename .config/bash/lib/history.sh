#
# History
#

HISTTIMEFORMAT='%F %T '   # use standard ISO 8601 timestamp
HISTSIZE=10000            # remember the last x commands in memory during session
HISTFILESIZE=100000       # start truncating history file after x lines
HISTCONTROL=ignoreboth    # ignoreboth is shorthand for ignorespace and ignoredups
HISTFILE=$XDG_DATA_HOME/bash/history
[[ -f $HISTFILE ]] || mkdir -p $(dirname $HISTFILE)
#PROMPT_COMMAND="history -a;history -c;history -r;$PROMPT_COMMAND"
