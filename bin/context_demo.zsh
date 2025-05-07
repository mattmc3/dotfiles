#!/bin/zsh

function show_context() {
  echo "Inside function: ZSH_EVAL_CONTEXT = $ZSH_EVAL_CONTEXT"
}

echo "At toplevel: ZSH_EVAL_CONTEXT = $ZSH_EVAL_CONTEXT"

show_context

eval 'echo "Inside eval: ZSH_EVAL_CONTEXT = $ZSH_EVAL_CONTEXT"'

trap 'echo "Inside trap: ZSH_EVAL_CONTEXT = $ZSH_EVAL_CONTEXT"' EXIT
