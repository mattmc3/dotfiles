# exports
export DOTFILES=${DOTFILES:-$HOME/.dotfiles}
export PATH=$PATH:$HOME/bin # Add ~/bin to PATH

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    # https://help.github.com/articles/associating-text-editors-with-git/
    #export EDITOR="atom --wait"
    export EDITOR="subl -wn"
    #export EDITOR="subl_wait.sh"
fi

export LPASS_AGENT_TIMEOUT=0
export MONO_GAC_PREFIX="/usr/local"
export BROWSER=/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome

export HOMEBREW_CASK_OPTS="--appdir=/Applications"
