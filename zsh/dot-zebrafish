#!/usr/bin/env zsh

# zebrafish.zsh
# > A powerful starter .zshrc
# Project Home: https://github.com/mattmc3/zebrafish
ZEBRAFISH_VERSION="2.0.0"

# Load zprof first thing in case we want to profile performance.
[[ ${ZF_PROF:-0} -eq 0 ]] || zmodload zsh/zprof
alias zf-prof="ZF_PROF=1 zsh"

function zebrafish_environment {
  # XDG base dir support.
  export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-~/.config}
  export XDG_CACHE_HOME=${XDG_CACHE_HOME:-~/.cache}
  export XDG_DATA_HOME=${XDG_DATA_HOME:-~/.local/share}
  export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-~/.xdg}

  # Editors
  export EDITOR=${EDITOR:-vim}
  export VISUAL=${VISUAL:-nano}
  export PAGER=${PAGER:-less}

  # Less
  export LESS=${LESS:-'-g -i -M -R -S -w -z-4'}

  # Browser
  if [[ "$OSTYPE" == darwin* ]]; then
    export BROWSER=${BROWSER:-open}
  fi

  # Regional settings
  export LANG=${LANG:-en_US.UTF-8}

  # use `< file` to quickly view the contents of any file.
  export READNULLCMD=${READNULLCMD:-$PAGER}

  # Remove lag
  export KEYTIMEOUT=1
}

function zebrafish_history {
  setopt APPEND_HISTORY          # Append to history file.
  setopt EXTENDED_HISTORY        # Write the history file in the ':start:elapsed;command' format.
  setopt NO_HIST_BEEP            # Don't beep when attempting to access a missing history entry.
  setopt HIST_EXPIRE_DUPS_FIRST  # Expire a duplicate event first when trimming history.
  setopt HIST_FIND_NO_DUPS       # Don't display a previously found event.
  setopt HIST_IGNORE_ALL_DUPS    # Delete an old recorded event if a new event is a duplicate.
  setopt HIST_IGNORE_DUPS        # Don't record an event that was just recorded again.
  setopt HIST_IGNORE_SPACE       # Don't record an event starting with a space.
  setopt HIST_NO_STORE           # Don't store history commands.
  setopt HIST_REDUCE_BLANKS      # Remove extra blanks from commands added to the history list.
  setopt HIST_SAVE_NO_DUPS       # Don't write a duplicate event to the history file.
  setopt HIST_VERIFY             # Don't execute immediately upon history expansion.
  setopt INC_APPEND_HISTORY      # Write to the history file immediately, not when the shell exits.
  setopt NO_SHARE_HISTORY        # Don't share history between all sessions.

  # $HISTFILE belongs in the data home, not with zsh configs
  HISTFILE=${XDG_DATA_HOME:=$HOME/.local/share}/zsh/history
  [[ -f $HISTFILE ]] || { mkdir -p $HISTFILE:h && touch $HISTFILE }

  # you can set $SAVEHIST and $HISTSIZE to anything greater than the ZSH defaults
  # (1000 and 2000 respectively), but if not we make them way bigger.
  [[ $SAVEHIST -gt 1000 ]] || SAVEHIST=20000
  [[ $HISTSIZE -gt 2000 ]] || HISTSIZE=100000

  alias hist='fc -li'
}

function zebrafish_directory {
  setopt AUTO_CD              # If a command isn't valid, but is a directory, cd to that dir.
  setopt AUTO_PUSHD           # Make cd push the old directory onto the dirstack.
  setopt PUSHD_IGNORE_DUPS    # Don’t push multiple copies of the same directory onto the dirstack.
  setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
  setopt PUSHD_MINUS          # Exchanges meanings of +/- when navigating the dirstack.
  setopt PUSHD_TO_HOME        # Push to home directory when no argument is given.
  setopt CDABLE_VARS          # Change directory to a path stored in a variable.
  setopt MULTIOS              # Write to multiple descriptors.
  setopt EXTENDED_GLOB        # Use extended globbing syntax.
  setopt NO_CLOBBER           # Do not overwrite files with >. Use >| to bypass.

  alias -- -='cd -'
  alias dirh='dirs -v'

  # set dirstack aliases (eg: "-2"="cd -2")
  local index; for index ({1..9}) alias "$index"="cd +${index}"

  # set backref aliases (eg: "..3"="../../..")
  local dotdots=".."
  for index ({1..9}); do
    alias -g "..$index"="$dotdots"
    dotdots+='/..'
  done
}

function zebrafish_editor {
  [[ "$TERM" != 'dumb' ]] || return 1

  setopt NO_FLOW_CONTROL    # Allow the usage of ^Q/^S in the context of zsh.

  # Treat these characters as part of a word.
  WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

  # Use human-friendly identifiers.
  zmodload zsh/terminfo
  typeset -gA key_info

  key_info=(
    # Modifiers
    'Control'      '\C-'
    'Escape'       '\e'
    'Meta'         '\M-'

    # Basic keys
    'Backspace'    "^?"
    'Delete'       "^[[3~"
    'F1'           "$terminfo[kf1]"
    'F2'           "$terminfo[kf2]"
    'F3'           "$terminfo[kf3]"
    'F4'           "$terminfo[kf4]"
    'F5'           "$terminfo[kf5]"
    'F6'           "$terminfo[kf6]"
    'F7'           "$terminfo[kf7]"
    'F8'           "$terminfo[kf8]"
    'F9'           "$terminfo[kf9]"
    'F10'          "$terminfo[kf10]"
    'F11'          "$terminfo[kf11]"
    'F12'          "$terminfo[kf12]"
    'Insert'       "$terminfo[kich1]"
    'Home'         "$terminfo[khome]"
    'PageUp'       "$terminfo[kpp]"
    'End'          "$terminfo[kend]"
    'PageDown'     "$terminfo[knp]"
    'Up'           "$terminfo[kcuu1]"
    'Left'         "$terminfo[kcub1]"
    'Down'         "$terminfo[kcud1]"
    'Right'        "$terminfo[kcuf1]"
    'BackTab'      "$terminfo[kcbt]"
  )

  # Mod plus another key
  key_info+=(
    'AltLeft'         "${key_info[Escape]}${key_info[Left]} \e[1;3D"
    'AltRight'        "${key_info[Escape]}${key_info[Right]} \e[1;3C"
    'ControlLeft'     '\e[1;5D \e[5D \e\e[D \eOd'
    'ControlRight'    '\e[1;5C \e[5C \e\e[C \eOc'
    'ControlPageUp'   '\e[5;5~'
    'ControlPageDown' '\e[6;5~'
  )

  # Enables terminal application mode
  function zle-line-init {
    # The terminal must be in application mode when ZLE is active for $terminfo
    # values to be valid.
    if (( $+terminfo[smkx] )); then
      # Enable terminal application mode.
      echoti smkx
    fi
  }
  zle -N zle-line-init

  # Disables terminal application mode
  function zle-line-finish {
    # The terminal must be in application mode when ZLE is active for $terminfo
    # values to be valid.
    if (( $+terminfo[rmkx] )); then
      # Disable terminal application mode.
      echoti rmkx
    fi
  }
  zle -N zle-line-finish

  # Resets the prompt when the keymap changes
  function zle-keymap-select {
    zle update-cursor-style

    zle reset-prompt
    zle -R
  }
  zle -N zle-keymap-select

  # Expand .... to ../..
  function expand-dot-to-parent-directory-path {
    if [[ $LBUFFER = *.. ]]; then
      LBUFFER+='/..'
    else
      LBUFFER+='.'
    fi
  }
  zle -N expand-dot-to-parent-directory-path

  # Set ctrl-z as bg/fg toggle
  function symmetric-ctrl-z {
    if [[ $#BUFFER -eq 0 ]]; then
      BUFFER=" fg"
      zle accept-line -w
    else
      zle push-input -w
      zle clear-screen -w
    fi
  }
  zle -N symmetric-ctrl-z

  # Reset to default key bindings
  bindkey -d

  # Global keybinds
  local -A global_keybinds
  global_keybinds=(
    "$key_info[Home]"      beginning-of-line
    "$key_info[End]"       end-of-line
    "$key_info[Delete]"    delete-char
    "$key_info[Backspace]" backward-delete-char
    "$key_info[Control]W"  backward-kill-word
    '.'                    expand-dot-to-parent-directory-path
  )

  # Special case for ControlLeft and ControlRight because they have multiple
  # possible binds.
  for key in "${(s: :)key_info[ControlLeft]}" "${(s: :)key_info[AltLeft]}"; do
    bindkey -M emacs "$key" emacs-backward-word
  done
  for key in "${(s: :)key_info[ControlRight]}" "${(s: :)key_info[AltRight]}"; do
    bindkey -M emacs "$key" emacs-forward-word
  done

  # Apply key binds to the emacs keymap
  for key bind in ${(kv)global_keybinds}; do
    bindkey -M emacs "$key" "$bind"
  done

  # Do not expand .... to ../.. during incremental search.
  bindkey -M isearch . self-insert 2> /dev/null

  # C-z bg/fg toggle
  bindkey '^Z' symmetric-ctrl-z

  # Emacs keybindings
  bindkey -e
}

function zebrafish_color {
  local prefix cache

  # Cache results of running dircolors for 20 hours, so it should almost
  # always regenerate the first time a shell is opened each day.
  for prefix in '' g; do
    if (( $+commands[${prefix}dircolors] )); then
      local dircolors_cache=${XDG_CACHE_HOME:=$HOME/.cache}/zebrafish/${prefix}dircolors.zsh
      mkdir -p ${dircolors_cache:h}
      local cache=($dircolors_cache(Nmh-20))

      (( $#cache )) || ${prefix}dircolors --sh >| $dircolors_cache
      source "${dircolors_cache}"
      alias ${prefix}ls="${aliases[${prefix}ls]:-${prefix}ls} --group-directories-first --color=auto"
    fi
  done

  if [[ "$OSTYPE" == darwin* ]]; then
    export CLICOLOR=1
    alias ls="${aliases[ls]:-ls} -G"
  fi

  export LS_COLORS=${LS_COLORS:-'di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'}
  export LSCOLORS=${LSCOLORS:-exfxcxdxbxGxDxabagacad}
  alias grep="${aliases[grep]:-grep} --color=auto"

  # Show man pages in color.
  export LESS_TERMCAP_mb=$'\e[01;34m'      # mb:=start blink-mode (bold,blue)
  export LESS_TERMCAP_md=$'\e[01;34m'      # md:=start bold-mode (bold,blue)
  export LESS_TERMCAP_so=$'\e[00;47;30m'   # so:=start standout-mode (white bg, black fg)
  export LESS_TERMCAP_us=$'\e[04;35m'      # us:=start underline-mode (underline magenta)
  export LESS_TERMCAP_se=$'\e[0m'          # se:=end standout-mode
  export LESS_TERMCAP_ue=$'\e[0m'          # ue:=end underline-mode
  export LESS_TERMCAP_me=$'\e[0m'          # me:=end modes
}

function zebrafish_utility {
  # General options.
  setopt EXTENDED_GLOB         # Use more awesome globbing features.
  setopt GLOB_DOTS             # Include dotfiles when globbing.
  setopt COMBINING_CHARS       # Combine 0-len chars with the base character (eg: accents).
  setopt INTERACTIVE_COMMENTS  # Enable comments in interactive shell.
  setopt RC_QUOTES             # Allow 'Hitchhikers''s Guide' instead of 'Hitchhikers'\''s Guide'.
  setopt NO_RM_STAR_SILENT     # Ask for confirmation for `rm *' or `rm path/*'
  setopt NO_MAIL_WARNING       # Don't print a warning message if a mail file has been accessed.
  setopt NO_BEEP               # Don't Beep on error in line editor.

  # Job options.
  setopt LONG_LIST_JOBS        # List jobs in the long format by default.
  setopt AUTO_RESUME           # Attempt to resume existing job before creating a new process.
  setopt NOTIFY                # Report status of background jobs immediately.
  setopt NO_BG_NICE            # Don't run all background jobs at a lower priority.
  setopt NO_HUP                # Don't kill jobs on shell exit.
  setopt NO_CHECK_JOBS         # Don't report on jobs when shell exit.

  # Use built-in paste magic.
  autoload -Uz bracketed-paste-url-magic
  zle -N bracketed-paste bracketed-paste-url-magic
  autoload -Uz url-quote-magic
  zle -N self-insert url-quote-magic

  # Load more specific 'run-help' function from $fpath.
  (( $+aliases[run-help] )) && unalias run-help && autoload -Uz run-help
  alias help=run-help
}

function zebrafish_completion {
  # Completion options.
  setopt COMPLETE_IN_WORD     # Complete from both ends of a word.
  setopt ALWAYS_TO_END        # Move cursor to the end of a completed word.
  setopt PATH_DIRS            # Perform path search even on command names with slashes.
  setopt AUTO_MENU            # Show completion menu on a successive tab press.
  setopt AUTO_LIST            # Automatically list choices on ambiguous completion.
  setopt AUTO_PARAM_SLASH     # If completed parameter is a directory, add a trailing slash.
  setopt EXTENDED_GLOB        # Needed for file modification glob modifiers with compinit.
  setopt NO_MENU_COMPLETE     # Do not autoselect the first completion entry.
  setopt NO_FLOW_CONTROL      # Disable start/stop characters in shell editor.

  # Allow custom completions directory.
  fpath=(${ZDOTDIR:-${XDG_CONFIG_HOME:=$HOME/.config}}/completions(/N) $fpath)

  # Zsh compdump file.
  : ${ZSH_COMPDUMP:=${XDG_CACHE_HOME:=$HOME/.cache}/zsh/zcompdump}
  [[ -d $ZSH_COMPDUMP:h ]] || mkdir -p $ZSH_COMPDUMP:h

  # Load and initialize the completion system ignoring insecure directories with a
  # cache time of 20 hours, so it should almost always regenerate the first time a
  # shell is opened each day.
  autoload -Uz compinit
  local comp_files=($ZSH_COMPDUMP(Nmh-20))
  if (( $#comp_files )); then
    compinit -i -C -d "$ZSH_COMPDUMP"
  else
    compinit -i -d "$ZSH_COMPDUMP"
    # Ensure $ZSH_COMPDUMP is younger than the cache time even if it isn't regenerated.
    touch "$ZSH_COMPDUMP"
  fi

  # Compile zcompdump, if modified, in background to increase startup speed.
  {
    if [[ -s "$ZSH_COMPDUMP" && (! -s "${ZSH_COMPDUMP}.zwc" || "$ZSH_COMPDUMP" -nt "${ZSH_COMPDUMP}.zwc") ]]; then
      zcompile "$ZSH_COMPDUMP"
    fi
  } &!
}

function zebrafish_compstyle {
  # Defaults.
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
  zstyle ':completion:*:default' list-prompt '%S%M matches%s'

  # Case-insensitive (all), partial-word, and then substring completion.
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

  # Group matches and describe.
  zstyle ':completion:*:*:*:*:*' menu select
  zstyle ':completion:*:matches' group 'yes'
  zstyle ':completion:*:options' description 'yes'
  zstyle ':completion:*:options' auto-description '%d'
  zstyle ':completion:*:corrections' format ' %F{red}-- %d (errors: %e) --%f'
  zstyle ':completion:*:descriptions' format ' %F{purple}-- %d --%f'
  zstyle ':completion:*:messages' format ' %F{green} -- %d --%f'
  zstyle ':completion:*:warnings' format ' %F{yellow}-- no matches found --%f'
  zstyle ':completion:*' format ' %F{blue}-- %d --%f'
  zstyle ':completion:*' group-name ''
  zstyle ':completion:*' verbose yes

  # Fuzzy match mistyped completions.
  zstyle ':completion:*' completer _complete _match _approximate
  zstyle ':completion:*:match:*' original only
  zstyle ':completion:*:approximate:*' max-errors 1 numeric

  # Increase the number of errors based on the length of the typed word. But make
  # sure to cap (at 7) the max-errors to avoid hanging.
  zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)'

  # Don't complete unavailable commands.
  zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'

  # Array completion element sorting.
  zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

  # Directories
  zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
  zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
  zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
  zstyle ':completion:*' squeeze-slashes true
  zstyle ':completion:*' special-dirs ..

  # History
  zstyle ':completion:*:history-words' stop yes
  zstyle ':completion:*:history-words' remove-all-dups yes
  zstyle ':completion:*:history-words' list false
  zstyle ':completion:*:history-words' menu yes

  # Environment Variables
  zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}

  # Ignore multiple entries.
  zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
  zstyle ':completion:*:rm:*' file-patterns '*:all-files'

  # Kill
  zstyle ':completion:*:*:*:*:processes' command 'ps -u $LOGNAME -o pid,user,command -w'
  zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
  zstyle ':completion:*:*:kill:*' menu yes select
  zstyle ':completion:*:*:kill:*' force-list always
  zstyle ':completion:*:*:kill:*' insert-ids single

  # complete manual by their section
  zstyle ':completion:*:manuals'    separate-sections true
  zstyle ':completion:*:manuals.*'  insert-sections   true
  zstyle ':completion:*:man:*'      menu yes select
}

function zebrafish_prompt {
  # Zsh prompt options.
  setopt PROMPT_SUBST    # expand parameters in prompt variables
  autoload -Uz promptinit && promptinit
}

# Zsh config dir.
_zhome=${ZDOTDIR:-${XDG_CONFIG_HOME:=$HOME/.config}/zsh}

# Autoload functions directory.
_zfuncdir=$_zhome/functions
if [[ -d $_zfuncdir ]]; then
  fpath=($_zfuncdir $fpath)
  autoload -Uz $fpath[1]/*(.:t)
fi

# TODO: plugins
zebrafish_environment
zebrafish_history
zebrafish_directory
zebrafish_editor
zebrafish_color
zebrafish_utility
zebrafish_completion
zebrafish_compstyle
zebrafish_prompt

# Source anything in conf.d.
for _rcfile in $_zhome/conf.d/*.zsh(N); do
  source $_rcfile
done

# Cleanup.
unset _zhome _zfuncdir _rcfile

# Done profiling.
[[ ${ZF_PROF:-0} -eq 0 ]] || { unset ZF_PROF && zprof }
true
