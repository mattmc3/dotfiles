### zsh specific settings ###

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export DOTFILES=${DOTFILES:-$HOME/.dotfiles}

# Set path
typeset -gxU path PATH
path=(
    $HOME/bin
    /usr/local/{sbin,bin}
    /usr/local/share/npm/bin
    /usr/{sbin,bin}
    /{sbin,bin}
    .
    $path
)

# history
SAVEHIST=10000 # Number of entries
HISTSIZE=10000
HISTFILE=~/.zsh_history # File
setopt APPEND_HISTORY # Don't erase history
setopt EXTENDED_HISTORY # Add additional data to history like timestamp
setopt INC_APPEND_HISTORY # Add immediately
setopt HIST_FIND_NO_DUPS # Don't show duplicates in search
setopt HIST_IGNORE_SPACE # Don't preserve spaces. You may want to turn it off
setopt NO_HIST_BEEP # Don't beep
setopt SHARE_HISTORY # Share history between session/terminals

# zsh only aliases
alias cd..='cd ..'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
alias s="source $HOME/.zshrc"

# cdpath will let you treat subdirs of this list as directly avalailable from
# whatever directory you are in
setopt auto_cd
cdpath=(
    $HOME/Projects
    $HOME/Documents
)

# Source oh-my-zsh
if [[ -d "${HOME}/.oh-my-zsh" ]]; then
    source "${XDG_CONFIG_HOME}/runcom/oh-my-zsh.zsh"
fi

# `ls` after `cd`
# https://stackoverflow.com/questions/3964068/zsh-automatically-run-ls-after-every-cd
function chpwd() {
    emulate -L zsh
    ls -F
}

# source my run command customizations
test -e "${HOME}/.myrc" && source "${HOME}/.myrc"
