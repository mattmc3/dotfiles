# zsh specific settings

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

# Source oh-my-zsh
if [[ -d "${HOME}/.oh-my-zsh" ]]; then
    source "$HOME/.config/shell/oh-my-zsh.zsh"
fi

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
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
alias s="source $HOME/.zshrc"

# iterm2_shell_integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Common sourcing
. "$HOME/.config/shell/main.sh"

# source zsh modules
find "$HOME/.config/shell/modules" -name "*.sh" -o -name "*.zsh" | while read file; do
    . $file
done
