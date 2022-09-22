# makefile
.PHONY: help submodules stow
.DEFAULT_GOAL := help

stow:
	stow --verbose --dotfiles --target=$$HOME home 2>&1 | grep -v 'Absolute/relative mismatch'
	stow --verbose --dotfiles --target=$$HOME/.config config 2>&1 | grep -v 'Absolute/relative mismatch'

unstow:
	stow -D --verbose --dotfiles --target=$$HOME home 2>&1 | grep -v 'Absolute/relative mismatch'
	stow -D --verbose --dotfiles --target=$$HOME/.config config 2>&1 | grep -v 'Absolute/relative mismatch'

submodules:
	git submodule update --recursive --remote

help:
	@echo "help"
	@echo "    shows this message"
	@echo ""
	@echo "submodules"
	@echo "    Update submodules. "
