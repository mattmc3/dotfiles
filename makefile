.DEFAULT_GOAL := help

.PHONY: all
all: stow home config

.PHONY: rm-all
rm-all: rm-stow rm-home rm-config

.PHONY: submodules
submodules:
	git submodule update --recursive --remote
	git submodule foreach git checkout main
	git submodule foreach git pull origin main

.PHONY: config
config:
	stow -v --target=$$HOME/.config config

.PHONY: rm-config
rm-config:
	stow -v -D --target=$$HOME/.config config

.PHONY: home
home:
	stow -v --dotfiles --target=$$HOME home

.PHONY: rm-home
rm-home:
	stow -v -D --dotfiles --target=$$HOME home

.PHONY: stow
stow:
	stow -v --dotfiles --target=$$HOME stow

.PHONY: rm-stow
rm-stow:
	stow -v -D --dotfiles --target=$$HOME stow

.PHONY: help
help:
	@echo "help"
	@echo "    shows this message"
	@echo ""
