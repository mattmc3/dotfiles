##? dotfiles
##?
##?	Usage: make <command>
##?
##?	Commands:

.DEFAULT_GOAL := help

##?   submodules  update all submodules
submodules:
	git submodule update --recursive --remote
.PHONY : submodules

##?   stow        create symlinks to dotfiles
stow:
	stow --verbose --dotfiles .
.PHONY : stow

##?   unstow      remove symlinks to dotfiles
unstow:
	stow --verbose --dotfiles -D .
.PHONY : unstow

##?   help        show this message
help:
	@grep "^##?" makefile | cut -c 5-
.PHONY : help
