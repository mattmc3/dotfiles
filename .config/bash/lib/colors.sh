#!/usr/bin/env bash
#
# Provides for easier use of 256 colors and effects.
#

# Return if requirements are not found.
if [[ "$TERM" == 'dumb' ]]; then
  return 1
fi

# Colorize man pages.
export LESS_TERMCAP_md=$'\E[01;34m'     # start bold
export LESS_TERMCAP_mb=$'\E[01;34m'     # start blink
export LESS_TERMCAP_so=$'\E[00;47;30m'  # start standout: white bg, black fg
export LESS_TERMCAP_us=$'\E[04;35m'     # start underline: underline magenta
export LESS_TERMCAP_se=$'\E[0m'         # end standout
export LESS_TERMCAP_ue=$'\E[0m'         # end underline
export LESS_TERMCAP_me=$'\E[0m'         # end bold/blink

# Set foreground, background, and effects variables.
typeset -gAx FG BG FX
function colorinit() {
  FG=(); BG=(); FX=();

  FX=(
        [reset]=$'\E[00m'
         [bold]=$'\E[01m'       [no-bold]=$'\E[22m'
          [dim]=$'\E[02m'        [no-dim]=$'\E[22m'
       [italic]=$'\E[03m'     [no-italic]=$'\E[23m'
    [underline]=$'\E[04m'  [no-underline]=$'\E[24m'
        [blink]=$'\E[05m'      [no-blink]=$'\E[25m'
      [reverse]=$'\E[07m'    [no-reverse]=$'\E[27m'
  )

  local color_id
  for color_id in {0..255}; do
    FG[$color_id]=$'\E[38;5;'$color_id'm'
    BG[$color_id]=$'\E[48;5;'$color_id'm'
  done
}
colorinit

function colormap() {
  local i bg fg reset
  reset=$'\E[00m'
  for i in {0..255}; do
    fg=$'\E[38;5;'$i'm'
    bg=$'\E[48;5;'$i'm'
    printf "%s  %s" "$bg" "$reset"
    printf "${fg}%03d${reset} " "$i"
    (( i <= 15 && (i + 1)  % 8 == 0 )) && echo
    (( i > 15  && (i - 15) % 6 == 0 )) && echo
  done
}

if type dircolors >/dev/null 2>&1; then
  eval "$(dircolors --sh)"
else
  if type gdircolors >/dev/null 2>&1; then
    eval "$(gdircolors --sh)"
  else
    export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=1;36:cd=1;33:su=30;41:sg=30;46:tw=30;42:ow=30;43}"
  fi

  # For BSD systems, set LSCOLORS.
  export CLICOLOR=1
  export LSCOLORS="exfxcxdxbxGxDxabagacad"
fi
