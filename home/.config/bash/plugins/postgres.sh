# shellcheck shell=bash

for _pg_dir in "${HOMEBREW_PREFIX:-/opt/homebrew}"/opt/postgresql@*/bin; do
  [[ -d "$_pg_dir" && ":$PATH:" != *":$_pg_dir:"* ]] && export PATH="$_pg_dir:$PATH"
done
unset _pg_dir
