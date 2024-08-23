#
# Options
#

# http://www.gnu.org/software/bash/manual/bashref.html#Pattern-Matching
set -o noclobber                 # Prevent file overwrite on stdout redirection; use `>|` to force
shopt -s histappend              # append to history, don't overwrite it
shopt -s checkwinsize            # Update window size after every command
shopt -s cmdhist                 # Save multi-line commands as one command
shopt -s extglob 2> /dev/null    # Turn on extended globbing
shopt -s globstar 2> /dev/null   # Turn on recursive globbing (enables ** to recurse all directories)
shopt -s nocaseglob              # Case-insensitive globbing (used in pathname expansion)
shopt -s autocd 2> /dev/null     # Prepend cd to directory names automatically
shopt -s dirspell 2> /dev/null   # Correct spelling errors during tab-completion
shopt -s cdspell 2> /dev/null    # Correct spelling errors in arguments supplied to cd
shopt -s cdable_vars             # CD across the filesystem as if you're in that dir
# set -o vi                        # Set vi editing mode
