# shellcheck shell=bash

: "${REPO_HOME:=${XDG_CACHE_HOME:-$HOME/.cache}/bash/repos}"
declare -a repos=()

# Read the file line-by-line, skipping comments and empty lines.
repos_txt="$BASH_HOME/repos.txt"
while IFS= read -r line; do
  line="${line%#*}"

  # Trim leading/trailing whitespace and check if the line is not empty and not a comment.
  if [[ -n "$line" && ! "$line" =~ ^# ]]; then
    repos+=("$line")  # Add the line to the array.
  fi
done < "$repos_txt"

# Clone missing repos.
for repo in "${repos[@]}"; do
  [[ -d "$REPO_HOME/$repo" ]] && continue
  echo "Cloning ${repo}..."
  git clone --quiet --depth 1 --recurse-submodules --shallow-submodules \
    "https://github.com/$repo" "$REPO_HOME/$repo" &
done
wait

# Clean up.
unset line repo repos_txt
