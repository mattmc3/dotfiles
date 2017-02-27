#!/usr/bin/env zsh
# https://github.com/Eriner/zim

ZDOTDIR=${ZDOTDIR:-${HOME}}

git clone --recursive https://github.com/Eriner/zim.git ${ZDOTDIR:-${HOME}}/.zim

setopt EXTENDED_GLOB
for template_file ( ${ZDOTDIR:-${HOME}}/.zim/templates/* ); do
    user_file="${ZDOTDIR:-${HOME}}/.${template_file:t}"
    touch ${user_file}
    ( print -rn "$(<${template_file})$(<${user_file})" >! ${user_file} ) 2>/dev/null
done

source ${ZDOTDIR:-${HOME}}/.zlogin
