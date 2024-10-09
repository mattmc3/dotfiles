# shellcheck shell=bash

[ -d /opt/homebrew/bin ] || return 1

# Add common directories.
if [[ :$PATH: != *:/usr/bin:* ]]; then
  export PATH="/usr/bin:/usr/sbin:$PATH"
fi
if [[ :$PATH: != *:/usr/local/bin:* ]]; then
  export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
fi

# Set up homebrew if the user didn't already in a .pre.bash file.
if [[ -z "${HOMEBREW_PREFIX:-}" ]]; then
  for brewcmd in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    [[ -x "$brewcmd" ]] || continue
    eval "$("$brewcmd" shellenv)"
    break
  done
fi

if [[ :$PATH: != *:/opt/homebrew/bin:* ]]; then
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
fi

# Add user directories.
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Show the root installs with all deps.
brews() {
  local bluify_deps='
    BEGIN { blue = "\033[34m"; reset = "\033[0m" }
          { leaf = $1; $1 = ""; printf "%s%s%s%s\n", leaf, blue, $0, reset}
  '
  brew leaves | xargs brew deps --installed --for-each | awk "$bluify_deps"
}
