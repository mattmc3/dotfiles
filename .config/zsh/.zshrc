#!/bin/zsh
[ -d ${ZDOTDIR:-$HOME}/.antidote ] ||
  git clone --depth 1 https://github.com/mattmc3/antidote ${ZDOTDIR:-$HOME}/.antidote
source ${ZDOTDIR:-$HOME}/.antidote/antidote.zsh
antidote load ${ZDOTDIR:-$HOME}/.zplugins
