# makefile
.PHONY: help submodules \
	fish rmfish fishfmt \
	git rmgit \
	stow rmstow
.DEFAULT_GOAL := help

fish:
	stow -v fish

rmfish:
	stow -v -D fish

fishfmt:
	find . \( -type f -or -type l \) -name '*.fish' ! -name 'fisher.fish' ! -path './fisher/*' ! -path './aliases/*' -exec fish_indent -w {} \;

git:
	stow -v --dotfiles --no-folding git
	stow -v --dotfiles --no-folding --dir=local --target=$$HOME/.config git

rmgit:
	stow -v -D git
	stow -v -D --dir=local --target=$$HOME/.config git

stow:
	stow -v stow

rmstow:
	stow -v -D stow

submodules:
	git submodule update --recursive --remote

help:
	@echo "help"
	@echo "    shows this message"
	@echo ""
	@echo "fishfmt"
	@echo "    Run fish_indent against all fish files. "
