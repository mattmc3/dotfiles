# Bash specific settings

export DOTFILES=${DOTFILES:-$HOME/.dotfiles}
# export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/bin:/usr/local/sbin"
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# Source bash-it
if [[ -d "${HOME}/.bash_it" ]]; then
    source "$HOME/.config/shell/bash_it.bash"
fi

# history help
shopt -s histappend
PROMPT_COMMAND="history -a;history -c;history -r;$PROMPT_COMMAND"
HISTSIZE=10000          # remember the last x commands
HISTFILESIZE=10000      # start truncating commands after x lines
HISTCONTROL=ignoreboth  # ignoreboth is shorthand for ignorespace and ignoredups

# bash only aliases
alias s="source $HOME/.bashrc"

# iterm2
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# dedupe path
export PATH=$(echo "$PATH" | awk -F: '{for (i=1;i<=NF;i++) { if ( !x[$i]++ ) printf("%s:",$i); }}')

# common sourcing
. "$HOME/.config/shell/main.sh"

# source bash modules
find "$HOME/.config/shell/modules" -name "*.sh" -o -name "*.bash" | while read file; do
    . $file
done
