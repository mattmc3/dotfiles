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

### history ###
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

# cdpath will let you treat subdirs of this list as directly avalailable from
# whatever directory you are in
setopt auto_cd
cdpath=(
    $HOME/Projects
    $HOME/Documents
)

# Antigen <3
ANTIGEN_ROOT=~/.config/antigen
export ADOTDIR=$ANTIGEN_ROOT/plugins
[[ ! -d $ANTIGEN_ROOT/lib ]] &&
    mkdir -p $ANTIGEN_ROOT/lib &&
    git clone https://github.com/zsh-users/antigen.git $ANTIGEN_ROOT/lib

. $ANTIGEN_ROOT/lib/antigen.zsh

antigen use oh-my-zsh
export ZSH=$ANTIGEN_ROOT/plugins/bundles/robbyrussell/oh-my-zsh
# themes I like: refined, wezm, juanghurtado, avit, kardan, juanghurtado, steeef
antigen theme avit

antigen bundles <<EOBUNDLES
zsh-users/zsh-autosuggestions
zsh-users/zsh-syntax-highlighting
zsh-users/zsh-history-substring-search
zsh-users/zsh-completions

chucknorris
django
extract
gitignore
golang
history
osx
vi-mode
web-search
z

mattmc3/zsh-tailf
mattmc3/zsh-git-gdot

colored-man-pages
EOBUNDLES

antigen apply

# Vi mode ----------------------------------------------------------------------
bindkey -v
export KEYTIMEOUT=1  # remove lag
# make cursor indicate mode
zle-keymap-select () {
    if [ "$TERM" = "xterm-256color" ]; then
        if [ $KEYMAP = vicmd ]; then
            # the command mode for vi
            echo -ne "\e[4 q"
        else
            # the insert mode for vi
            echo -ne "\e[2 q"
        fi
    fi
}


# `ls` after `cd`
# https://stackoverflow.com/questions/3964068/zsh-automatically-run-ls-after-every-cd
function chpwd() {
    emulate -L zsh
    ls -F
}

### OS specific ###
if [[ "$OSTYPE" == darwin* ]]; then
    # macos uses keychain with ssh -K
    ssh-add -K ~/.ssh/id_rsa &> /dev/null
    # iterm ain't no linux thang

    if [ "$TERM" = "xterm-256color" ] && [ -z "$INSIDE_EMACS" ]; then
        [ -f ~/.iterm2_shell_integration.zsh ] && source ~/.iterm2_shell_integration.zsh
    fi
else
    ssh-add ~/.ssh/id_rsa &> /dev/null
fi

# source my run command customizations
[[ -f "$DOTFILES/includes/env.sh" ]]     && . "$DOTFILES/includes/env.sh"
[[ -f "$DOTFILES/includes/aliases.sh" ]] && . "$DOTFILES/includes/aliases.sh"
[[ -f "$DOTFILES/includes/funcs.sh" ]]   && . "$DOTFILES/includes/funcs.sh"
[[ -f ~/.zshrc_local ]] && . ~/.zshrc_local

### completions ###
# python: tab complete for workon dir (virtualenv)
compdef '_files -W "$WORKON_HOME"' workon &> /dev/null
