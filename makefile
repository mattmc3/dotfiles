# makefile
.PHONY: help fish rmfish fishfmt stow rmstow submodules
.DEFAULT_GOAL := help

fish:
	stow -v fish

rmfish:
	stow -v -D fish

fishfmt:
	find . \( -type f -or -type l \) -name '*.fish' ! -name 'fisher.fish' ! -path './fisher/*' ! -path './aliases/*' -exec fish_indent -w {} \;

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
