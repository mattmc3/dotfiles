# shellcheck shell=bash

gi() {
  local IFS=,
  curl -fLw $'\n' "https://www.toptal.com/developers/gitignore/api/${*}"
}

_gi_complete() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  local prefix partial
  if [[ $cur == *","* ]]; then
    prefix="${cur%,*}"
    partial="${cur##*,}"
  else
    prefix=""
    partial="$cur"
  fi
  local list
  list=$(curl -sfL https://www.toptal.com/developers/gitignore/api/list) || return
  COMPREPLY=()
  local IFS=$',\n\r'
  for item in $list; do
    [[ $item == "$partial"* ]] || continue
    if [[ -n $prefix ]]; then
      COMPREPLY+=("${prefix},${item}")
    else
      COMPREPLY+=("$item")
    fi
  done
}

complete -F _gi_complete -o nospace gi
