.DEFAULT_GOAL := help

.PHONY: all
all: stow bash bin doom fish git npm nvim python readline screen tmux todotxt vim vscode zsh

.PHONY: rm-all
rm-all: rm-bash rm-bin rm-doom rm-fish rm-git rm-npm rm-nvim rm-python rm-readline rm-screen rm-tmux rm-todotxt rm-vim rm-vscode rm-zsh rm-stow

.PHONY: submodules
submodules:
	git submodule update --recursive --remote
	git submodule foreach git checkout main
	git submodule foreach git pull origin main

.PHONY: pkgexport
pkgexport:
	pkgmgr export azuredatastudio > ./local/packages/$$(hostname)/azuredatastudio-extensions.txt
	pkgmgr export brew > ./local/packages/$$(hostname)/Brewfile
	pkgmgr export gem > ./local/packages/$$(hostname)/gemfile.txt
	pkgmgr export macosapps > ./local/packages/$$(hostname)/macosapps.txt
	pkgmgr export npm > ./local/packages/$$(hostname)/npm.txt
	pkgmgr export pip2 > ./local/packages/$$(hostname)/pip2-requirements.txt
	pkgmgr export pip3 > ./local/packages/$$(hostname)/pip3-requirements.txt
	pkgmgr export code > ./local/packages/$$(hostname)/vscode-extensions.txt

.PHONY: bash
bash:
	stow -v --dotfiles bash

.PHONY: rm-bash
rm-bash:
	stow -v -D --dotfiles bash

.PHONY: bin
bin:
	stow -v bin

.PHONY: rm-bin
rm-bin:
	stow -v -D bin

.PHONY: doom
doom:
	stow -v --target=$$HOME/.config doom

.PHONY: rm-doom
rm-doom:
	stow -v -D --target=$$HOME/.config doom

.PHONY: fish
fish:
	stow -v --target=$$HOME/.config fish

.PHONY: rm-fish
rm-fish:
	stow -v -D --target=$$HOME/.config fish

.PHONY: fishfmt
fishfmt:
	find . \( -type f -or -type l \) -name '*.fish' ! -name 'fisher.fish' ! -path './fisher/*' ! -path './aliases/*' -exec fish_indent -w {} \;

.PHONY: git
git:
	stow -v git

.PHONY: rm-git
rm-git:
	stow -v -D git

.PHONY: karabiner
karabiner:
	stow -v --target=$$HOME/.config karabiner

.PHONY: rm-karabiner
rm-karabiner:
	stow -v -D --target=$$HOME/.config karabiner

.PHONY: npm
npm:
	stow -v npm

.PHONY: rm-npm
rm-npm:
	stow -v -D npm

.PHONY: nvim
nvim:
	stow -v --target=$$HOME/.config nvim

.PHONY: rm-nvim
rm-nvim:
	stow -v -D --target=$$HOME/.config nvim

.PHONY: powershell
powershell:
	stow -v --target=$$HOME/.config powershell

.PHONY: rm-powershell
rm-powershell:
	stow -v -D --target=$$HOME/.config powershell

.PHONY: python
python:
	stow -v python

.PHONY: rm-python
rm-python:
	stow -v -D python

.PHONY: readline
readline:
	stow -v readline

.PHONY: rm-readline
rm-readline:
	stow -v -D readline

.PHONY: screen
screen:
	stow -v screen

.PHONY: rm-screen
rm-screen:
	stow -v -D screen

.PHONY: spacemacs
spacemacs:
	stow -v --dotfiles spacemacs

.PHONY: rm-spacemacs
rm-spacemacs:
	stow -v -D --dotfiles spacemacs

.PHONY: stow
stow:
	stow -v stow

.PHONY: rm-stow
rm-stow:
	stow -v -D stow

.PHONY: tmux
tmux:
	stow -v tmux

.PHONY: rm-tmux
rm-tmux:
	stow -v -D tmux

.PHONY: todotxt
todotxt:
	stow -v --target=$$HOME/.config todotxt

.PHONY: rm-todotxt
rm-todotxt:
	stow -v -D --target=$$HOME/.config todotxt

.PHONY: vim
vim:
	stow -v --dotfiles vim

.PHONY: rm-vim
rm-vim:
	stow -v -D --dotfiles vim

.PHONY: vscode
vscode:
	stow -v --dir=local --target="$$HOME/Library/Application Support/Code/User" vscode

.PHONY: rm-vscode
rm-vscode:
	stow -v -D --dir=local --target="$$HOME/Library/Application Support/Code/User" vscode

.PHONY: zsh
zsh:
	stow -v --dotfiles zsh

.PHONY: rm-zsh
rm-zsh:
	stow -v -D --dotfiles zsh

.PHONY: help
help:
	@echo "help"
	@echo "    shows this message"
	@echo ""
	@echo "fishfmt"
	@echo "    Run fish_indent against all fish files. "
