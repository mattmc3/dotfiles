# shellcheck shell=bash source=/dev/null

# Use XDG base dirs.
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
mkdir -p "$XDG_CONFIG_HOME" "$XDG_CACHE_HOME" "$XDG_DATA_HOME" "$XDG_STATE_HOME"

# Support alternative BASH_HOME locations.
BASH_HOME="$XDG_CONFIG_HOME"/bash
BASH_DATA_HOME="$XDG_DATA_HOME"/bash
BASH_CACHE_HOME="$XDG_CACHE_HOME"/bash
REPO_HOME="$BASH_CACHE_HOME"/repos
mkdir -p "$BASH_HOME" "$BASH_DATA_HOME" "$BASH_CACHE_HOME" "$REPO_HOME"

# Setup profiling if needed.
if [ "${PROFRC:-0}" -eq 1 ]; then
  PS4='+ $(gdate "+%s.%N")\011 '
  exec 3>&2 2>"$BASH_HOME"/.bashrc.$$.log
  set -x
fi

# Declare a post_init array for post init operations.
# shellcheck disable=SC2034
declare -a post_init=()

# Cache the results of a command used for eval init.
cached_eval() {
  local cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/bash/cached_eval"
  local cache_file="$cache_dir/$1.sh"

  mkdir -p "$cache_dir"

  # Delete cache file if older than 20 hours (1200 minutes)
  find "$cache_dir" -type f -name "$1.sh" -mmin +1200 -delete 2>/dev/null

  if [[ ! -f $cache_file ]]; then
    "$@" > "$cache_file" || {
      echo "cached_eval: command failed: $*" >&2
      return 1
    }
  fi

  source "$cache_file"
}

# shellcheck disable=SC2139,SC2001
##? Extend an existing alias
extend_alias() {
  local name="$1"
  local extra_args="$2"
  local alias_def
  alias_def=$(alias "$name" 2>/dev/null)
  if [[ -n "$alias_def" ]]; then
    # Extract current alias value
    local current_cmd
    current_cmd=$(echo "$alias_def" | sed "s/alias $name='\(.*\)'/\1/")
    alias "$name"="${current_cmd} ${extra_args}"
  else
    alias "$name"="$name ${extra_args}"
  fi
}
