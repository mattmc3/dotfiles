#!/bin/zsh
#
# .zprofile - execute login commands pre-zshrc
#

export DOTFILES=~/.config/dotfiles

#region XDG
#

# XDG base dirs
export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.local/share
export XDG_STATE_HOME=~/.local/state

# XDG user dirs
export XDG_RUNTIME_DIR=~/.xdg
export XDG_PROJECTS_DIR=~/Projects

# Fish-like zsh dirs
export __zsh_config_dir=$XDG_CONFIG_HOME/zsh
export __zsh_user_data_dir=$XDG_DATA_HOME/zsh
export __zsh_cache_dir=$XDG_CACHE_HOME/zsh

# ensure dirs exist
for _zdir in XDG_{CONFIG,CACHE,DATA,STATE}_HOME \
             XDG_{RUNTIME,PROJECTS}_DIR \
             __zsh_{config,cache,user_data}_dir
do
  [[ -e ${(P)_zdir} ]] || echo mkdir -p ${(P)_zdir}
done

#
#endregion

#region homebrew
#
if [[ -e $HOME/brew/bin/brew ]]; then
  export HOMEBREW_PREFIX="$HOME/brew";
elif [[ -e /opt/homebrew/bin/brew ]]; then
  export HOMEBREW_PREFIX="/opt/homebrew";
elif [[ -e /usr/local/bin/brew ]]; then
  export HOMEBREW_PREFIX="/usr/local";
fi

if [[ -n "$HOMEBREW_PREFIX" ]]; then
  export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar";
  export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX";
  export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin${PATH+:$PATH}";
  export MANPATH="$HOMEBREW_PREFIX/share/man${MANPATH+:$MANPATH}:";
  export INFOPATH="$HOMEBREW_PREFIX/share/info:${INFOPATH:-}";
fi
#
#endregion

#region Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU fpath path cdpath

# Set the list of directories that cd searches.
cdpath=(
  $XDG_PROJECTS_DIR(N/)
  $XDG_PROJECTS_DIR/mattmc3(N/)
  $cdpath
)

# Set the list of directories that Zsh searches for programs.
path=(
  # core
  $HOME/{,s}bin(N)
  $HOME/brew/{,s}bin(N)
  /opt/{homebrew,local}/{,s}bin(N)
  /usr/local/{,s}bin(N)

  # emacs
  $HOME/.emacs.d/bin(N)
  $XDG_CONFIG_HOME/emacs/bin(N)

  # apps
  /{usr/local,opt/homebrew}/opt/curl/bin(N)
  /{usr/local,opt/homebrew}/opt/go/libexec/bin(N)
  /{usr/local,opt/homebrew}/share/npm/bin(N)
  /{usr/local,opt/homebrew}/opt/ruby/bin(N)
  /{usr/local,opt/homebrew}/lib/ruby/gems/*/bin(N)
  $HOME/.gem/ruby/*/bin(N)

  # path
  $path
)

#
#endregion

#region Editors
#
export EDITOR=vim
export VISUAL=code
export PAGER=less
[[ "$OSTYPE" == darwin* ]] && export BROWSER='open'
#
#endregion

#region Less
#
# Set the default Less options.
# Mouse-wheel scrolling can be disabled with -X (disable screen clearing).
# Add -X to disable it.
if [[ -z "$LESS" ]]; then
  export LESS='-g -i -M -R -S -w -z-4'
fi

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if [[ -z "$LESSOPEN" ]] && (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi
#
#endregion

#region Misc
#

# Regional settings
export LANG='en_US.UTF-8'

# Misc
export KEYTIMEOUT=1

# Make Apple Terminal behave.
export SHELL_SESSIONS_DISABLE=1

# Use `< file` to quickly view the contents of any file.
[[ -z "$READNULLCMD" ]] || READNULLCMD=$PAGER

#
#endregion

# vi: ft=zsh
