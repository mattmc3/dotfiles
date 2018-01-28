### zsh specific settings ###
# https://github.com/zsh-users/antigen/wiki/In-the-wild

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

# add the zsh calculator
autoload -Uz zcalc

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

# Antigen <3
[[ ! -d ~/.lib/antigen ]] &&
    mkdir -p ~/.lib && git clone https://github.com/zsh-users/antigen.git ~/.lib/antigen

. ~/.lib/antigen/antigen.zsh

antigen use oh-my-zsh
# stuff I like: refined, wezm, juanghurtado, avit, kardan
antigen theme juanghurtado

antigen bundles <<EOBUNDLES
zsh-users/zsh-autosuggestions
zsh-users/zsh-syntax-highlighting
zsh-users/zsh-history-substring-search
zsh-users/zsh-completions

mattmc3/zsh-extract
mattmc3/zsh-tailf
mattmc3/zsh-git-gdot

colored-man-pages
EOBUNDLES

antigen apply


# `ls` after `cd`
# https://stackoverflow.com/questions/3964068/zsh-automatically-run-ls-after-every-cd
function chpwd() {
    emulate -L zsh
    ls -F
}

### iTerm2 ###
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

### ssh ###
ssh-add ~/.ssh/id_rsa &> /dev/null

### z ###
[[ -f /usr/local/etc/profile.d/z.sh ]] && . /usr/local/etc/profile.d/z.sh


# source my run command customizations
[[ -f ~/.config/runcom/variables ]] && . ~/.config/runcom/variables
[[ -f ~/.config/runcom/aliases ]] && . ~/.config/runcom/aliases
[[ -f ~/.config/runcom/functions ]] && . ~/.config/runcom/functions
[[ -f ~/.config/runcom/completions.zsh ]] && . ~/.config/runcom/completions.zsh
[[ -f ~/.zshrc_local ]] && . ~/.zshrc_local

return 0
