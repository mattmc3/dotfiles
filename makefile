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

##?   help        show this message
help:
	@grep "^##?" makefile | cut -c 5-
.PHONY : help
