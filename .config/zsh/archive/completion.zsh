#
# completion: Options and config related to completions.
#

# Add Fish-like custom completions directory.
fpath=($__zsh_config_dir/completions(/N) $fpath)

# 16.2.2 Completion
setopt always_to_end     # Move cursor to the end of a completed word.
setopt auto_list         # Automatically list choices on ambiguous completion.
setopt auto_menu         # Show completion menu on a successive tab press.
setopt auto_param_slash  # If completed parameter is a directory, add a trailing slash.
setopt complete_in_word  # Complete from both ends of a word.
setopt NO_menu_complete  # Do not autoselect the first completion entry.

# Initialize completions.
function mycompinit {
  : ${ZSH_COMPDUMP:=$__zsh_cache_dir/compdump}
  [[ -d $ZSH_COMPDUMP:h ]] || mkdir -p $ZSH_COMPDUMP:h

  # Force cache reset flag
  [[ "$1" == "-f" ]] && [[ -f "$ZSH_COMPDUMP" ]] && rm -rf -- $ZSH_COMPDUMP

  # Compfix flag
  local -a compinit_flags=(-d "$ZSH_COMPDUMP")
  if zstyle -t ':zephyr:plugin:completion' 'disable-compfix'; then
    # Allow insecure directories in fpath
    compinit_flags=(-u $compinit_flags)
  else
    # Remove insecure directories from fpath
    compinit_flags=(-i $compinit_flags)
  fi

  # Initialize completions
  autoload -Uz compinit
  if zstyle -t ':zephyr:plugin:completion' 'use-cache'; then
    # Load and initialize the completion system ignoring insecure directories with a
    # cache time of 20 hours, so it should almost always regenerate the first time a
    # shell is opened each day.
    local compdump_cache=($ZSH_COMPDUMP(Nmh-20))
    if (( $#compdump_cache )); then
      compinit -C $compinit_flags
    else
      compinit $compinit_flags
      # Ensure $ZSH_COMPDUMP is younger than the cache time even if it isn't regenerated.
      touch "$ZSH_COMPDUMP"
    fi
  else
    compinit $compinit_flags
  fi
}
