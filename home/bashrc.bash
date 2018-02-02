# Bash specific settings
# Some ideas from sensible.bash: https://github.com/mrzool/bash-sensible

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export DOTFILES=${DOTFILES:-$HOME/.dotfiles}

# export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/bin:/usr/local/sbin"
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

### history ###
# Use standard ISO 8601 timestamp
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
HISTTIMEFORMAT='%F %T '

PROMPT_COMMAND="history -a;history -c;history -r;$PROMPT_COMMAND"
HISTSIZE=10000          # remember the last x commands in memory during session
HISTFILESIZE=10000      # start truncating history file after x lines
HISTCONTROL=ignoreboth  # ignoreboth is shorthand for ignorespace and ignoredups


### options ###
# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
set -o noclobber

# Update window size after every command
shopt -s checkwinsize

# Append to the history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

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
CDPATH=".:~:~/Projects"

# This allows you to bookmark your favorite places across the file system
# Define a variable containing a path and you will be able to cd into it regardless of the directory you're in
shopt -s cdable_vars


# Source bash-it
if [[ -d "${HOME}/.bash_it" ]]; then
    source "$DOTFILES/includes/bash_it.bash"
fi

# source my run command customizations
[[ -f "$DOTFILES/includes/env.sh" ]]     && . "$DOTFILES/includes/env.sh"
[[ -f "$DOTFILES/includes/aliases.sh" ]] && . "$DOTFILES/includes/aliases.sh"
[[ -f "$DOTFILES/includes/funcs.sh" ]]   && . "$DOTFILES/includes/funcs.sh"
[[ -f ~/.bashrc_local ]] && . ~/.bashrc_local

### bash only vars ###
# dedupe path
export PATH=$(echo "$PATH" | awk -F: '{for (i=1;i<=NF;i++) { if ( !x[$i]++ ) printf("%s:",$i); }}')


### prompt ###

# Automatically trim long paths in the prompt (requires Bash 4.x)
PROMPT_DIRTRIM=3

# PS1="[\u@\h:\w]\n$ "
# export CLICOLOR=1
# export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd
#export LSCOLORS=ExFxBxDxCxegedabagacad


# completions for bash
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
