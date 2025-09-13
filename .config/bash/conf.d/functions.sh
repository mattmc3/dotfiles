# shellcheck shell=bash disable=SC2155,SC2001

die() { warn "${@:2}"; exit "$1"; }
warn() { printf '%s: %s\n' "${0##*/}" "$*" >&2; }

function func/exists() {
  declare -F -- "$1" >/dev/null 2>&1
}

# Return whatever value was passed.
function retval() {
  [[ "$1" -gt 0 ]] && return "$1" || return 0
}

# A basic calculator.
function calc() {
  bc -l <<< "$@"
}

# Check strings for boolean values.
function is_true() {
  case "${1,,}" in
    (t|y|true|yes|on|1) return 0 ;;
    (*) return 1 ;;
  esac
}

# Print 256 terminal color codes.
function colormap() {
  local i bg fg reset
  reset=$'\E[00m'
  for i in {0..255}; do
    fg=$'\E[38;5;'$i'm'
    bg=$'\E[48;5;'$i'm'
    printf "%s  %s" "$bg" "$reset"
    printf "${fg}%03d${reset} " "$i"
    (( i <= 15 && (i + 1)  % 8 == 0 )) && echo
    (( i > 15  && (i - 15) % 6 == 0 )) && echo
  done
}

# cd upward X directories.
function up() {
  local lvls cdstr
  lvls="${1:-1}"
  cdstr=".."
  while (( --lvls > 0 )); do
    cdstr+="/.."
  done
  cd "$cdstr" || return
}

# Extract all the things.
function extract() {
  case "$1" in
    *.tar.bz2)  tar xjf "$1"  ;;
    *.tar.gz)   tar xzf "$1"  ;;
    *.bz2)      bunzip2 "$1"  ;;
    *.gz)       gunzip "$1"   ;;
    *.tar.xz)   tar xJf "$1"  ;;
    *.xz)       unxz "$1"     ;;
    *.zip)      unzip "$1"    ;;
    *.7z)       7z x "$1"     ;;
    *)          echo "'$1' cannot be extracted via extract()" ;;
  esac
}

# Join strings with a delimiter.
function str/join() {
  local sep ret arg
  [[ $# -ne 0 ]] || return 1
  [[ $# -ne 1 ]] || return 0
  sep="$1"; shift
  ret="$1"; shift
  for arg; do ret+="${sep}${arg}"; done
  echo "$ret"
}

# Split strings on a delimiter.
function str/split() {
  local sep str
  [[ $# -ne 0 ]] || return 1
  sep=$(echo "$1" | sed 's/[]\/\\$*.^|[]/\\&/g')
  shift
  for str; do
    echo "$str" | sed "s/${sep}/\n/g"
  done
}

# Trims whitespace from start and end of string.
function str/trim() {
  local arg
  for arg; do
    arg="${arg#"${arg%%[![:space:]]*}"}"
    arg="${arg%"${arg##*[![:space:]]}"}"
    echo "$arg"
  done
}

# Convert to UPPERCASE string.
function str/upper() {
  local arg
  for arg; do
    echo "$arg" | tr '[:lower:]' '[:upper:]'
  done
}

# Convert to lowercase string.
function str/lower() {
  local arg
  for arg; do
    echo "$arg" | tr '[:upper:]' '[:lower:]'
  done
}

# Sum an array.
function arr/sum() {
  local i tot=0
  for i; do (( tot+=i )); done
  echo "$tot"
}

# Check if an element is in an array.
function arr/contains() {
  local arg find="$1"; shift
  for arg; do
    [[ "$find" == "$arg" ]] && return 0
  done
  return 1
}

# Get the index of an element is in an array.
function arr/index_of() {
  local arg find="$1" i=0; shift
  for arg; do
    if [[ "$find" == "$arg" ]]; then
      echo "$i"
      return
    fi
    ((i++))
  done
  return 1
}

function prj() {
  local selection="$(~/bin/prj "$*")"
  [ -z "$selection" ] && return
  cd "${selection}" && pwd
}

# shellcheck disable=SC2154
function plugins/list() {
  local plugin_file
  for plugin_file in "${BASH_HOME:-$HOME/.config/bash}"/plugins/*.sh; do
    plugin="$(basename "$plugin_file")"
    plugin="${plugin%.sh}"
    if arr/contains "$plugin" "${plugins[@]}"; then
      printf '%-25s %s\n' "$plugin" on
    else
      printf '%-25s %s\n' "$plugin" off
    fi
  done
}

##? Normalize a path string without requiring it to exist.
function path/normalize() {
  local p=$1
  local IFS=/ part out=

  # if relative, prepend $PWD
  if [[ $p != /* ]]; then
    p="$PWD/$p"
  fi

  for part in $p; do
    case $part in
      ""|.) continue        ;;  # skip empty or "."
      ..)  out=${out%/*}    ;;  # pop last element
      *)   out="$out/$part" ;;
    esac
  done

  # Ensure at least "/"
  [[ -z "$out" ]] && out="/"
  printf '%s\n' "$out"
}

##? Cross-shell method of manipulating paths.
function path() {
  local opt p
  local -a actions=()

  OPTIND=1
  while getopts "ahret" opt; do
    actions+=("$opt")
  done
  shift $((OPTIND-1))

  # If path argument was passed, use it; else read from stdin
  if [[ $# -gt 0 ]]; then
    p=$1
  elif [[ ! -t 0 ]]; then
    IFS= read -r p || return 1
  else
    echo "Usage: path [-a] [-h] [-r] [-e] [-t] path" >&2
    return 1
  fi

  # Apply in given order
  for opt in "${actions[@]}"; do
    case $opt in
      a) p=$(path/normalize "$p") ;;
      h) p=$(dirname -- "$p") ;;
      r)
        local dir base
        dir=$(dirname -- "$p")
        base=$(basename -- "$p")
        if [[ $base == *.* ]]; then
          base=${base%.*}
        fi
        p="$dir/$base"
        ;;
      e)
        local base=$(basename -- "$p")
        if [[ $base == *.* ]]; then
          p=${base##*.}
        else
          p=""
        fi
        ;;
    t) p=$(basename -- "$p") ;;
    esac
  done

  printf '%s\n' "$p"
}
