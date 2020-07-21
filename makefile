# makefile
.PHONY: help submodules \
	bash rmbash \
	bin rmbin \
	doom rmdoom \
	fish rmfish fishfmt \
	git rmgit \
	npm rmnpm \
	nvim rmnvim \
	python rmpython \
	readline rmreadline \
	screen rmscreen \
	stow rmstow \
	tmux rmtmux \
	vim rmvim \
	vscode rmvscode \
	tmux rmtmux
.DEFAULT_GOAL := help

bash:
	stow -v --dotfiles bash

rmbash:
	stow -v -D --dotfiles bash

bin:
	stow -v bin

rmbin:
	stow -v -D bin

doom:
	stow -v --target=$$HOME/.config doom

rmdoom:
	stow -v -D --target=$$HOME/.config doom

fish:
	stow -v fish

rmfish:
	stow -v -D fish

fishfmt:
	find . \( -type f -or -type l \) -name '*.fish' ! -name 'fisher.fish' ! -path './fisher/*' ! -path './aliases/*' -exec fish_indent -w {} \;

git:
	stow -v git

rmgit:
	stow -v -D git

npm:
	stow -v npm

rmnpm:
	stow -v -D npm

nvim:
	stow -v --target=$$HOME/.config nvim

rmnvim:
	stow -v -D --target=$$HOME/.config nvim

python:
	stow -v python

rmpython:
	stow -v -D python

readline:
	stow -v readline

rmreadline:
	stow -v -D readline

screen:
	stow -v screen

rmscreen:
	stow -v -D screen

stow:
	stow -v stow

rmstow:
	stow -v -D stow

tmux:
	stow -v tmux

rmtmux:
	stow -v -D tmux

submodules:
	git submodule update --recursive --remote

vim:
	stow -v --dotfiles vim

rmvim:
	stow -v -D --dotfiles vim

vscode:
	stow -v --dir=local --target="$$HOME/Library/Application Support/Code/User" vscode

rmvscode:
	stow -v -D --dir=local --target="$$HOME/Library/Application Support/Code/User" vscode

help:
	@echo "help"
	@echo "    shows this message"
	@echo ""
	@echo "fishfmt"
	@echo "    Run fish_indent against all fish files. "
