# Bash specific settings
# Some ideas from sensible.bash: https://github.com/mrzool/bash-sensible

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export DOTFILES=${DOTFILES:-$HOME/.dotfiles}

# export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/bin:/usr/local/sbin"
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# Source bash-it
if [[ -d "${HOME}/.bash_it" ]]; then
    source "${XDG_CONFIG_HOME}/runcom/bash_it.bash"
fi

### bash only aliases ###
alias s="source ~/.bashrc"  # quick sourcing

# source my run command customizations
[[ -f ~/.config/runcom/variables ]] && . ~/.config/runcom/variables
[[ -f ~/.config/runcom/aliases ]] && . ~/.config/runcom/aliases
[[ -f ~/.config/runcom/functions ]] && . ~/.config/runcom/functions
[[ -f ~/.config/runcom/options.bash ]] && . ~/.config/runcom/options.bash
[[ -f ~/.config/runcom/history.bash ]] && . ~/.config/runcom/history.bash
[[ -f ~/.config/runcom/completions.bash ]] && . ~/.config/runcom/completions.bash
[[ -f ~/.bashrc_local ]] && . ~/.bashrc_local

### bash only vars ###
# dedupe path
export PATH=$(echo "$PATH" | awk -F: '{for (i=1;i<=NF;i++) { if ( !x[$i]++ ) printf("%s:",$i); }}')
