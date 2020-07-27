# Phony helps when you have directories with the same name as a make command
.PHONY: help submodules \
	pkgimport pkgexport \
	bash rmbash \
	bin rmbin \
	doom rmdoom \
	fish rmfish fishfmt \
	git rmgit \
	npm rmnpm \
	nvim rmnvim \
	python rmpython \
	readline rmreadline \
	spacemacs rmspacemacs \
	screen rmscreen \
	stow rmstow \
	tmux rmtmux \
	vim rmvim \
	vscode rmvscode \
	tmux rmtmux
.DEFAULT_GOAL := help

submodules:
	git submodule update --recursive --remote

pkgexport:
	pkgmgr export azuredatastudio > ./local/packages/$$(hostname)/azuredatastudio-extensions.txt
	pkgmgr export brew > ./local/packages/$$(hostname)/Brewfile
	pkgmgr export gem > ./local/packages/$$(hostname)/gemfile.txt
	pkgmgr export macosapps > ./local/packages/$$(hostname)/macosapps.txt
	pkgmgr export npm > ./local/packages/$$(hostname)/npm.txt
	pkgmgr export pip2 > ./local/packages/$$(hostname)/pip2-requirements.txt
	pkgmgr export pip3 > ./local/packages/$$(hostname)/pip3-requirements.txt
	pkgmgr export code > ./local/packages/$$(hostname)/vscode-extensions.txt

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

spacemacs:
	stow -v --dotfiles spacemacs

rmspacemacs:
	stow -v -D --dotfiles spacemacs

stow:
	stow -v stow

rmstow:
	stow -v -D stow

tmux:
	stow -v tmux

rmtmux:
	stow -v -D tmux

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
