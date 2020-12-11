#
# Executes commands at login pre-zshrc.
#

export DOTFILES=$HOME/.config/dotfiles

#
# Terminal colors
#

export CLICOLOR="1"
#export LSCOLORS="ExfxcxdxbxGxDxabagacad"
export LSCOLORS=GxFxCxDxBxegedabagaced

#
# Browser
#

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

#
# Editors
#

export EDITOR='vim'
export VISUAL='code'
export PAGER='less'

#
# Language
#

export TZ="America/New_York"
export LANG="en_US.UTF-8"
export LANGUAGE="en"
export LC_ALL="en_US.UTF-8"

#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the list of directories that cd searches.
# cdpath=(
#   $cdpath
# )

# Set the list of directories that Zsh searches for programs.
path=(
  $HOME/bin
  /opt/homebrew/bin
  /usr/local/{sbin,bin}
  /usr/{sbin,bin}
  /{sbin,bin}
  $HOME/.emacs.d/bin
  /usr/local/share/npm/bin
  /usr/local/opt/go/libexec/bin
  $HOME/Projects/golang/bin
  /usr/local/opt/ruby/bin
)

# ensure path arrays do not contain duplicates
typeset -gU cdpath fpath mailpath path

#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi
