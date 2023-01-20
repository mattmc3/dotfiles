# makefile
.PHONY: help submodules stow
.DEFAULT_GOAL := help

stow:
	stow --verbose --dotfiles --target=$$HOME home
	stow --verbose --dotfiles --target=$$HOME/.config config
	mkdir -p $$HOME/.zsh
	stow --verbose --dotfiles --target=$$HOME/.zsh zsh

unstow:
	stow -D --verbose --dotfiles --target=$$HOME home
	stow -D --verbose --dotfiles --target=$$HOME/.config config
	stow -D --verbose --dotfiles --target=$$HOME/.zsh zsh

submodules:
	git submodule update --recursive --remote

help:
	@echo "help"
	@echo "    shows this message"
	@echo ""
	@echo "submodules"
	@echo "    Update submodules. "
