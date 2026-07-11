#!/bin/sh
# Optionally, #!/usr/bin/env dash

##? contains - test if a word is present in a list

# This is a pure POSIX implementation of Fish's contains utility
# Fish-like contains (https://fishshell.com/docs/current/cmds/contains.html)
contains() {(
  while getopts "i" opt; do
    case "$opt" in
      i) o_index=1 ;;
      *) return 1  ;;
    esac
  done
  shift $(( OPTIND - 1 ))

  if [ "$#" -eq 0 ]; then
    echo >&2 "contains: key not specified"
    return 1
  fi

  key="$1"; shift
  index=0
  for val in "$@"; do
    index=$(( index + 1 ))
    if [ "$val" = "$key" ]; then
      [ -n "$o_index" ] && echo $index
      return 0
    fi
  done
  return 1
)}
contains "$@"
