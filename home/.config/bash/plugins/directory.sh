# shellcheck shell=bash

# Config for dirstack, globbing, special dirs, and general file system nav.
# CDPATH="."
set -o noclobber                   # Prevent file overwrite on stdout redirection; use `>|` to force
set -o pipefail                    # Return the rightmost non-zero code for piped commands if any fail
shopt -s checkwinsize 2> /dev/null # Update window size after every command
shopt -s cmdhist 2> /dev/null      # Save multi-line commands as one command
shopt -s extglob 2> /dev/null      # Turn on extended globbing
shopt -s globstar 2> /dev/null     # Turn on recursive globbing (enables ** to recurse all directories)
shopt -s nocaseglob 2> /dev/null   # Case-insensitive globbing (used in pathname expansion)
shopt -s autocd 2> /dev/null       # Prepend cd to directory names automatically
shopt -s dirspell 2> /dev/null     # Correct spelling errors during tab-completion
# shopt -s cdspell 2> /dev/null      # Correct spelling errors in arguments supplied to cd
# shopt -s cdable_vars 2> /dev/null  # CD across the filesystem as if you're in that dir
