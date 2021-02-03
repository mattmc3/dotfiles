.DEFAULT_GOAL := help

.PHONY: backup
backup:
	./bin/dotfiles backup

.PHONY: install
install:
	./bin/dotfiles install

.PHONY: uninstall
uninstall:
	./bin/dotfiles uninstall

.PHONY: help
help:
	@echo "help       shows this message"
	@echo "backup     backup dotfiles"
	@echo "install    symlinks dotfiles"
	@echo "uninstall  un-symlinks dotfiles"
