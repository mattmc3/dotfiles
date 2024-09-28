# shellcheck shell=bash

function clone {
  git cloner "$@"
}

function func/exists() {
  declare -F -- "$1" >/dev/null 2>&1
}

# A basic calculator.
function test_exitcode() {
  [[ "$#" -ne 0 ]] && return "$1" || return 0
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
