# makefile
.PHONY: help submodules stow unstow
.DEFAULT_GOAL := help

stow:
	stow home
	stow zsh
	stow --target=$$HOME/.config config

unstow:
	stow -D home
	stow -D zsh
	stow -D --target=$$HOME/.config config

submodules:
	git submodule update --recursive --remote

help:
	@echo "help"
	@echo "    shows this message"
	@echo ""
	@echo "submodules"
	@echo "    Update submodules. "
