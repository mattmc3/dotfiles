# shellcheck shell=bash

# Colorize man pages.
export LESS_TERMCAP_md=$'\E[01;34m'     # start bold
export LESS_TERMCAP_mb=$'\E[01;34m'     # start blink
export LESS_TERMCAP_so=$'\E[00;47;30m'  # start standout: white bg, black fg
export LESS_TERMCAP_us=$'\E[04;35m'     # start underline: underline magenta
export LESS_TERMCAP_se=$'\E[0m'         # end standout
export LESS_TERMCAP_ue=$'\E[0m'         # end underline
export LESS_TERMCAP_me=$'\E[0m'         # end bold/blink

# Set LS_COLORS using dircolors
if [[ -z "$LS_COLORS" ]]; then
  if type dircolors >/dev/null 2>&1; then
    cached_eval dircolors --sh
    #eval "$(dircolors --sh)"
  elif type gdircolors >/dev/null 2>&1; then
    cached_eval gdircolors --sh
    #eval "$(gdircolors --sh)"
  fi
fi

# Fallback, even for BSD systems
export LS_COLORS="${LS_COLORS:-di=34:ln=35:so=32:pi=33:ex=31:bd=1;36:cd=1;33:su=30;41:sg=30;46:tw=30;42:ow=30;43}"

# For BSD systems, set LSCOLORS instead.
if ! type dircolors >/dev/null 2>&1; then
  export CLICOLOR=1
  export LSCOLORS="exfxcxdxbxGxDxabagacad"
fi
