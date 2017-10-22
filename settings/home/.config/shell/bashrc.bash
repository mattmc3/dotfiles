# Bash specific settings
# Some ideas from sensible.bash: https://github.com/mrzool/bash-sensible

export DOTFILES=${DOTFILES:-$HOME/.dotfiles}
# export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/bin:/usr/local/sbin"
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# Source bash-it
if [[ -d "${HOME}/.bash_it" ]]; then
    source "$HOME/.config/shell/bash_it.bash"
fi


## GENERAL OPTIONS ##

# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
set -o noclobber

# Update window size after every command
shopt -s checkwinsize


## HISTORY ##

# Append to the history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# Use standard ISO 8601 timestamp
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
HISTTIMEFORMAT='%F %T '

PROMPT_COMMAND="history -a;history -c;history -r;$PROMPT_COMMAND"
HISTSIZE=500000         # remember the last x commands
HISTFILESIZE=100000     # start truncating commands after x lines
HISTCONTROL=ignoreboth  # ignoreboth is shorthand for ignorespace and ignoredups


## PROMPT ##

# Automatically trim long paths in the prompt (requires Bash 4.x)
PROMPT_DIRTRIM=3

# PS1="[\u@\h:\w]\n$ "
# export CLICOLOR=1
# export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd
#export LSCOLORS=ExFxBxDxCxegedabagacad


## BETTER DIRECTORY NAVIGATION ##

# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2> /dev/null
# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;
# Prepend cd to directory names automatically
shopt -s autocd 2> /dev/null
# Correct spelling errors during tab-completion
shopt -s dirspell 2> /dev/null
# Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2> /dev/null

# This defines where cd looks for targets
# Add the directories you want to have fast access to, separated by colon
# Ex: CDPATH=".:~:~/projects" will look for targets in the current working directory, in home and in the ~/projects folder
CDPATH="."

# This allows you to bookmark your favorite places across the file system
# Define a variable containing a path and you will be able to cd into it regardless of the directory you're in
shopt -s cdable_vars

export dotfiles="$HOME/dotfiles"
export projects="$HOME/Projects"
export github="$HOME/Projects/github.com/mattmc3"
export bitbucket="$HOME/Projects/bitbucket.org/mattmc3"


## MISC ##

# bash only aliases
# quick sourcing
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

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# source /usr/local/etc/bash_completion.d/password-store
