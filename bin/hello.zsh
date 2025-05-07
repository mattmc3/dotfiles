#!/bin/zsh

function hello() {
  echo "hello ${1:-world}"
}

# Only run if NOT sourced
if [[ $ZSH_EVAL_CONTEXT != *:file ]]; then
  hello "$@"
fi
echo $ZSH_EVAL_CONTEXT
