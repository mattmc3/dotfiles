# makefile
.PHONY: help submodules \
	fish rmfish fishfmt \
	git rmgit \
	stow rmstow \
	vscode rmvscode
.DEFAULT_GOAL := help

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
