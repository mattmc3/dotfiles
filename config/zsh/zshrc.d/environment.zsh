export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi
export VISUAL='code'

# set other stuff
export TZ="America/New_York"
export LANG="en_US.UTF-8"
export LANGUAGE="en"
export LC_ALL="en_US.UTF-8"

export CLICOLOR="1"
#export LSCOLORS="ExfxcxdxbxGxDxabagacad"
export LSCOLORS=GxFxCxDxBxegedabagaced
export PAGER="less"

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

# path
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
