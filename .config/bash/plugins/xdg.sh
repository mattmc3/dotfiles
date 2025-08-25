#
# XDG base dirs - don't pollute home
#

#
# Variables
#

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-$HOME/.xdg}
export XDG_PROJECTS_DIR=${XDG_PROJECTS_DIR:-$HOME/Projects}
mkdir -p "$XDG_CONFIG_HOME" "$XDG_CACHE_HOME" "$XDG_DATA_HOME" \
         "$XDG_STATE_HOME" "$XDG_RUNTIME_DIR" "$XDG_PROJECTS_DIR"

#
# Shell utils
#

# less
export LESSKEY="${LESSKEY:-$XDG_CONFIG_HOME/less/lesskey}"
export LESSHISTFILE="${LESSHISTFILE:-$XDG_CACHE_HOME/less/history}"

# readline
export INPUTRC="${INPUTRC:-$XDG_CONFIG_HOME/readline/inputrc}"

# screen
export SCREENRC="${SCREENRC:-$XDG_CONFIG_HOME/screen/screenrc}"

# tmux
export TMUX_CONFIG="${TMUX_CONFIG:-$XDG_CONFIG_HOME/tmux/tmux.conf}"
if ! alias tmux 2>/dev/null; then
  alias tmux='tmux -f "$TMUX_CONFIG"'
fi

# wget
export WGETRC="${WGETRC:-$XDG_CONFIG_HOME/wget/wgetrc}"
if ! alias wget 2>/dev/null; then
  alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget/wget-hsts"'
fi
mkdir -p "$XDG_CONFIG_HOME/wget" "$XDG_CACHE_HOME/wget"

#
# Dev tools
#

# jupyter
export JUPYTER_CONFIG_DIR="${JUPYTER_CONFIG_DIR:-$XDG_CONFIG_HOME/jupyter}"

# node
if [[ :$PATH: != *:/opt/homebrew/share/npm/bin:* ]]; then
  export PATH="/opt/homebrew/share/npm/bin:$PATH"
fi
export NPM_CONFIG_USERCONFIG="${NPM_CONFIG_USERCONFIG:-$XDG_CONFIG_HOME/npm/npmrc}"
export NODE_REPL_HISTORY="${NODE_REPL_HISTORY:-$XDG_DATA_HOME/nodejs/repl_history}"

# nuget
export NUGET_PACKAGES="${NUGET_PACKAGES:-$XDG_CACHE_HOME/NuGetPackages}"

# postgres
export PSQLRC="${PSQLRC:-$XDG_CONFIG_HOME/pg/psqlrc}"
export PSQL_HISTORY="${PSQL_HISTORY:-$XDG_CACHE_HOME/pg/psql_history}"
export PGPASSFILE="${PGPASSFILE:-$XDG_CONFIG_HOME/pg/pgpass}"
export PGSERVICEFILE="${PGSERVICEFILE:-$XDG_CONFIG_HOME/pg/pg_service.conf}"

# ruby bundler
export BUNDLE_USER_CONFIG="${BUNDLE_USER_CONFIG:-$XDG_CONFIG_HOME/bundle}"
export BUNDLE_USER_CACHE="${BUNDLE_USER_CACHE:-$XDG_CACHE_HOME/bundle}"
export BUNDLE_USER_PLUGIN="${BUNDLE_USER_PLUGIN:-$XDG_DATA_HOME/bundle}"

# ruby gems
export GEM_HOME="${GEM_HOME:-$XDG_DATA_HOME/gem}"
export GEM_SPEC_CACHE="${GEM_SPEC_CACHE:-$XDG_CACHE_HOME/gem}"

# rust
export CARGO_HOME="${CARGO_HOME:-$XDG_DATA_HOME/cargo}"
export RUSTUP_HOME="${RUSTUP_HOME:-$XDG_DATA_HOME/rustup}"
