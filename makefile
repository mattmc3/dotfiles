# makefile
.PHONY: help submodules \
	bash rmbash \
	bin rmbin \
	doom rmdoom \
	fish rmfish fishfmt \
	git rmgit \
	python rmpython \
	stow rmstow \
	vscode rmvscode
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

python:
	stow -v python

rmpython:
	stow -v -D python

stow:
	stow -v stow

rmstow:
	stow -v -D stow

submodules:
	git submodule update --recursive --remote

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
