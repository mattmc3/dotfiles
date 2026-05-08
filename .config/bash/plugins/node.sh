# shellcheck shell=bash

for _node_dir in /opt/homebrew/share/npm/bin /usr/local/share/npm/bin; do
  [[ -d "$_node_dir" && ":$PATH:" != *":$_node_dir:"* ]] && export PATH="$_node_dir:$PATH"
done
unset _node_dir
