# exports
export DOTFILES=${DOTFILES:-$HOME/.dotfiles}
CURRENT_SHELL=`ps -p $$ -ocomm= | sed -E -e 's/^.*[\/\-]//'`
CURRENT_USERNAME=`id -un`
export TZ=America/New_York

export TERM=xterm-256color
export PATH=$PATH:$HOME/bin # Add ~/bin to PATH

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    # https://help.github.com/articles/associating-text-editors-with-git/
    export EDITOR="subl -wn"
fi

export VISUAL=$EDITOR
export LPASS_AGENT_TIMEOUT=0
export MONO_GAC_PREFIX="/usr/local"

# Jupyter can use the BROWSER variable
#export BROWSER=/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome
#export BROWSER=/Applications/Firefox.app/Contents/MacOS/firefox

export HOMEBREW_CASK_OPTS="--appdir=/Applications"


### golang ###
export GLOBALGOPATH=$HOME/.go
export GOPATH=$GLOBALGOPATH
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export PATH=$PATH:$GOPATH/bin # Add GOPATH/bin to PATH for scripting


### python ###
export WORKON_HOME=~/.virtualenvs


### todo.txt ###
export TODO="t"
