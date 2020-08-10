# Copyright (c) 2020 mattmc3
# MIT license
# .zebrafish.zsh
# version: 0.5.0
# homepage: https://github.com/mattmc3/zebrafish
#
# A solid base zsh configuration achieved with only one small, simple include.
#
# single file install:
#   curl -s -o ${ZDOTDIR:-$HOME}/.zebrafish.zsh https://raw.githubusercontent.com/mattmc3/zebrafish/master/zebrafish.zsh
#   echo '. ${ZDOTDIR:-$HOME}/.zebrafish.zsh' >> ${ZDOTDIR:-$HOME}/.zshrc
#
# To see the configuration options, run this after sourcing this file:
# `zstyle -L ':zebrafish*'`


# Init
# ------------------------------------------------------------------------------
_features=
_zebrafish_path=
_zshrcd_path=
_zfuncs_path=
_zf_init() {
  local d zfuncs_dirname zshrcd_dirname

  # if not defined, define the defaults
  if zstyle -T ':zebrafish:features' 'enable'; then
    zstyle ':zebrafish:features' 'enable' \
      'completions' \
      'history' \
      'environment' \
      'key-bindings' \
      'zshopts' \
      'plugins' \
      'prompt' \
      'xdg-base-dirs' \
      'zfunctions' \
      'zshrc.d'
  fi

  # set zebrafish path
  if zstyle -T ':zebrafish:core' 'path'; then
    if [[ -n "$ZDOTDIR" ]]; then
      zstyle ':zebrafish:core' 'path' "$ZDOTDIR"
    else
      zstyle ':zebrafish:core' 'path' "${XDG_CONFIG_DIR:-$HOME/.config}/zebrafish"
    fi
  fi
  zstyle -g _zebrafish_path ':zebrafish:core' 'path'

  # set defaults
  if zstyle -T ':zebrafish:features:zshrc.d' 'dirname'; then
    zstyle ':zebrafish:features:zshrc.d' 'dirname' "zshrc.d"
  fi
  if zstyle -T ':zebrafish:features:zfunctions' 'dirname'; then
    zstyle ':zebrafish:features:zfunctions' 'dirname' "zfunctions"
  fi
  if zstyle -T ':zebrafish:features:prompt' 'name'; then
    zstyle ':zebrafish:features:prompt' 'name' 'bigfade'
  fi

  # make all the necessary dirs
  zstyle -g zfuncs_dirname ':zebrafish:features:zfunctions' 'dirname'
  _zfuncs_path="${_zebrafish_path}/${zfuncs_dirname}"
  [[ -d "$_zfuncs_path" ]] || mkdir -p "$_zfuncs_path"

  zstyle -g zshrcd_dirname ':zebrafish:features:zshrc.d' 'dirname'
  _zshrcd_path="${_zebrafish_path}/${zshrcd_dirname}"
  [[ -d "$_zshrcd_path" ]] || mkdir -p "$_zshrcd_path"

  # get the list of features
  zstyle -g _features ':zebrafish:features' 'enable'
}
_zf_init


# ZSH Options
# ------------------------------------------------------------------------------
if (($_features[(Ie)zshopts])); then
  # http://zsh.sourceforge.net/Doc/Release/Options.html

  # Changing Directories
  # http://zsh.sourceforge.net/Doc/Release/Options.html#Changing-Directories
  setopt auto_cd                 # if a command isn't valid, but is a directory, cd to that dir
  setopt auto_pushd              # make cd push the old directory onto the directory stack
  setopt pushd_ignore_dups       # don’t push multiple copies of the same directory onto the directory stack
  setopt pushd_minus             # exchanges the meanings of ‘+’ and ‘-’ when specifying a directory in the stack

  # Completions
  # http://zsh.sourceforge.net/Doc/Release/Options.html#Completion-2
  setopt always_to_end           # move cursor to the end of a completed word
  setopt auto_list               # automatically list choices on ambiguous completion
  setopt auto_menu               # show completion menu on a successive tab press
  setopt auto_param_slash        # if completed parameter is a directory, add a trailing slash
  setopt complete_in_word        # complete from both ends of a word
  unsetopt menu_complete         # don't autoselect the first completion entry

  # Expansion and Globbing
  # http://zsh.sourceforge.net/Doc/Release/Options.html#Expansion-and-Globbing
  setopt extended_glob           # use more awesome globbing features
  setopt glob_dots               # include dotfiles when globbing

  # History
  # set in history feature

  # Initialization
  # http://zsh.sourceforge.net/Doc/Release/Options.html#Initialisation

  # Input/Output
  # http://zsh.sourceforge.net/Doc/Release/Options.html#Input_002fOutput
  unsetopt clobber               # must use >| to truncate existing files
  unsetopt correct               # don't try to correct the spelling of commands
  unsetopt correct_all           # don't try to correct the spelling of all arguments in a line
  unsetopt flow_control          # disable start/stop characters in shell editor
  setopt interactive_comments    # enable comments in interactive shell
  unsetopt mail_warning          # don't print a warning message if a mail file has been accessed
  setopt path_dirs               # perform path search even on command names with slashes
  setopt rc_quotes               # allow 'Henry''s Garage' instead of 'Henry'\''s Garage'
  unsetopt rm_star_silent        # ask for confirmation for `rm *' or `rm path/*'

  # Job Control
  # http://zsh.sourceforge.net/Doc/Release/Options.html#Job-Control
  setopt auto_resume            # attempt to resume existing job before creating a new process
  unsetopt bg_nice              # don't run all background jobs at a lower priority
  unsetopt check_jobs           # don't report on jobs when shell exit
  unsetopt hup                  # don't kill jobs on shell exit
  setopt long_list_jobs         # list jobs in the long format by default
  setopt notify                 # report status of background jobs immediately

  # Prompting
  # http://zsh.sourceforge.net/Doc/Release/Options.html#Prompting
  setopt prompt_subst           # expand parameters in prompt variables

  # Scripts and Functions
  # http://zsh.sourceforge.net/Doc/Release/Options.html#Scripts-and-Functions

  # Shell Emulation
  # http://zsh.sourceforge.net/Doc/Release/Options.html#Shell-Emulation

  # Shell State
  # http://zsh.sourceforge.net/Doc/Release/Options.html#Shell-State

  # Zle
  # http://zsh.sourceforge.net/Doc/Release/Options.html#Zle
  unsetopt beep                 # be quiet!
  setopt combining_chars        # combine zero-length punctuation characters (accents) with the base character
  setopt emacs                  # use emacs keybindings in the shell
fi


# Feature: XDG
# ------------------------------------------------------------------------------
_zf_xdg() {
  export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
  export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
  export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
  export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-$HOME/.xdg}"
}
if (($_features[(Ie)xdg-base-dirs])); then
  _zf_xdg
fi


# Feature: Environment
# ------------------------------------------------------------------------------
_zf_env() {
  export CLICOLOR="${CLICOLOR:-1}"
  export LSCOLORS="${LSCOLORS:-ExfxcxdxbxGxDxabagacad}"

  export PAGER="${PAGER:-less}"
  export EDITOR="${EDITOR:-vim}"
  export VISUAL="${VISUAL:-vim}"
}
if (($_features[(Ie)environment])); then
  _zf_env
fi


# Feature: History
# ------------------------------------------------------------------------------
if (($_features[(Ie)history])); then
  # http://zsh.sourceforge.net/Doc/Release/Options.html#History
  setopt append_history          # append to history file
  setopt extended_history        # write the history file in the ':start:elapsed;command' format
  unsetopt hist_beep             # don't beep when attempting to access a missing history entry
  setopt hist_expire_dups_first  # expire a duplicate event first when trimming history
  setopt hist_find_no_dups       # don't display a previously found event
  setopt hist_ignore_all_dups    # delete an old recorded event if a new event is a duplicate
  setopt hist_ignore_dups        # don't record an event that was just recorded again
  setopt hist_ignore_space       # don't record an event starting with a space
  setopt hist_no_store           # don't store history commands
  setopt hist_reduce_blanks      # remove superfluous blanks from each command line being added to the history list
  setopt hist_save_no_dups       # don't write a duplicate event to the history file
  setopt hist_verify             # don't execute immediately upon history expansion
  setopt inc_append_history      # write to the history file immediately, not when the shell exits
  unsetopt share_history         # don't share history between all sessions

  if [[ -z "$SAVEHIST" ]] || [[ $SAVEHIST -le 1000 ]]; then
    SAVEHIST=5000
  fi
  if [[ -z "$HISTSIZE" ]] || [[ $HISTSIZE -le 2000 ]]; then
    HISTSIZE=10000
  fi
  if [[ -d $XDG_DATA_HOME ]]; then
    HISTFILE="$XDG_DATA_HOME/zsh/history"
    [[ -d "$XDG_DATA_HOME"/zsh ]] || mkdir -p "$XDG_DATA_HOME"/zsh
    if [[ ! -f "${ZDOTDIR:-$HOME}/.zsh_history" ]]; then
      ln -sf "$HISTFILE" "${ZDOTDIR:-$HOME}/.zsh_history"
    fi
  else
    HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history"
  fi
fi


# Feature: Key Bindings
# ------------------------------------------------------------------------------
_zf_key-bindings() {
  # https://github.com/fish-shell/fish-shell/blob/master/share/functions/fish_default_key_bindings.fish
  # http://fishshell.com/docs/current/index.html#editor
  # https://github.com/changs/slimzsh/blob/master/keys.zsh
  export KEYTIMEOUT=${KEYTIMEOUT:-1}  # remove lag
  bindkey -e
  bindkey '\ew' kill-region
  bindkey -s '\el' "ls\n"
  bindkey '^r' history-incremental-search-backward
  bindkey "^[[5~" up-line-or-history
  bindkey "^[[6~" down-line-or-history
  bindkey '^[[A' up-line-or-search
  bindkey '^[[B' down-line-or-search
  bindkey "^[[H" beginning-of-line
  bindkey "^[[1~" beginning-of-line
  bindkey "^[OH" beginning-of-line
  bindkey "^[[F" end-of-line
  bindkey "^[[4~" end-of-line
  bindkey "^[OF" end-of-line
  bindkey ' ' magic-space
  bindkey "^F" forward-word
  bindkey "^B" backward-word
  bindkey '^[[Z' reverse-menu-complete
  bindkey '^?' backward-delete-char
  bindkey "^[[3~" delete-char
  bindkey "^[3;5~" delete-char
  bindkey "\e[3~" delete-char
  bindkey -s '^X^Z' '%-^M'
  bindkey '^[e' expand-cmd-path
  bindkey '^[^I' reverse-menu-complete
  bindkey '^X^N' accept-and-infer-next-history
  bindkey '^W' kill-region
  bindkey '^I' complete-word
  # Fix weird sequence that rxvt produces
  bindkey -s '^[[Z' '\t'
}
if (($_features[(Ie)key-bindings])); then
  _zf_key-bindings
fi


# Feature: Completions
# ------------------------------------------------------------------------------
_zf_completions() {
  # https://github.com/sorin-ionescu/prezto/blob/master/modules/completion/init.zsh#L31-L41
  # http://zsh.sourceforge.net/Doc/Release/Completion-System.html#Use-of-compinit
  # https://gist.github.com/ctechols/ca1035271ad134841284#gistcomment-2894219
  setopt extendedglob local_options
  autoload -Uz compinit
  local zcd=${ZDOTDIR:-$HOME}/.zcompdump
  local zcdc="$zcd.zwc"
  # Compile the completion dump to increase startup speed if dump is newer or
  # missing. Do in background for next time to not affect the current session
  if [[ -f "$zcd"(#qN.m+1) ]]; then
    compinit -i -d "$zcd"
    { rm -f "$zcdc" && zcompile "$zcd" } &!
  else
    compinit -i -C -d "$zcd"
    { [[ ! -f "$zcdc" || "$zcd" -nt "$zcdc" ]] && rm -f "$zcdc" && zcompile "$zcd" } &!
  fi
}
if (($_features[(Ie)completions])); then
  _zf_completions
fi


# Feature: Plugins
# ------------------------------------------------------------------------------
_zf_plugins() {
}
if (($_features[(Ie)plugins])); then
  _zf_plugins
fi


# Feature: zfunctions
# ------------------------------------------------------------------------------
# auto load any function in the functions location
_zf_zfuncs() {
  local zfunc

  fpath=("$_zfunc_path" $fpath)
  for zfunc in "$_zfunc_path"/*(N); do
    autoload -U "$zfunc"
  done
}
if (($_features[(Ie)zfunctions])); then
  _zf_zfuncs
fi


# Feature: zshrc.d
# ------------------------------------------------------------------------------
_zf_zshrcd() {
  local zfile

  for zfile in "$_zshrcd_path"/*.{sh,zsh}(N); do
    # ignore files that begin with a tilde
    case $zfile:t in ~*) continue;; esac
    source "$zfile"
  done
}
if (($_features[(Ie)zshrc.d])); then
  _zf_zshrcd
fi


# Feature: Prompt
# ------------------------------------------------------------------------------
_zf_prompt() {
  local _promptname
  zstyle -g _promptname ':zebrafish:features:prompt' 'name'
  autoload -U promptinit
  promptinit
  [[ -n "$_promptname" ]] && prompt "$_promptname"
}
if (($_features[(Ie)prompt])); then
  _zf_prompt
fi


# Cleanup
# ------------------------------------------------------------------------------
unset _features
unset _zebrafish_path
unset _zshrcd_path
unset _zfuncs_path
unfunction _zf_init
unfunction _zf_xdg
unfunction _zf_env
unfunction _zf_key-bindings
unfunction _zf_completions
unfunction _zf_plugins
unfunction _zf_zfuncs
unfunction _zf_zshrcd
unfunction _zf_prompt
