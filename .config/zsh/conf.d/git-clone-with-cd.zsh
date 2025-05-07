# Enhance git clone so that it will cd into the newly cloned directory
autoload -Uz add-zsh-hook
typeset -g last_cloned_dir

# Preexec: Detect 'git clone' command and set last_cloned_dir so we can cd into it
_git_clone_preexec() {
  if [[ "$1" == git\ clone* ]]; then
    local last_arg="${1##* }"
    if [[ "$last_arg" =~ ^(https?|git@|ssh://|git://) ]]; then
      last_cloned_dir=$(basename "$last_arg" .git)
    else
      last_cloned_dir="$last_arg"
    fi
  fi
}

# Precmd: Runs before prompt is shown, and we can cd into our last_cloned_dir
_git_clone_precmd() {
  if [[ -n "$last_cloned_dir" ]]; then
    if [[ -d "$last_cloned_dir" ]]; then
      echo "→ cd from $PWD to $last_cloned_dir"
      cd "$last_cloned_dir"
    fi
    # Reset
    last_cloned_dir=
  fi
}

add-zsh-hook preexec _git_clone_preexec
add-zsh-hook precmd _git_clone_precmd
