# shellcheck shell=bash

[[ -d "${HOMEBREW_PREFIX:-/opt/homebrew}" ]] || return 1

for _ruby_dir in \
  "${HOMEBREW_PREFIX:-/opt/homebrew}/opt/ruby/bin" \
  "${HOMEBREW_PREFIX:-/opt/homebrew}"/lib/ruby/gems/*/bin \
  "$HOME"/.gem/ruby/*/bin
do
  [[ -d "$_ruby_dir" && ":$PATH:" != *":$_ruby_dir:"* ]] && export PATH="$_ruby_dir:$PATH"
done
unset _ruby_dir
