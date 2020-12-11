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
	@echo "help"
	@echo "    shows this message"
	@echo ""
	@echo "backup"
	@echo "    backup dotfiles"
	@echo ""
	@echo "install"
	@echo "    stows dotfiles"
	@echo ""
	@echo "uninstall"
	@echo "    unstows dotfiles"
	@echo ""
