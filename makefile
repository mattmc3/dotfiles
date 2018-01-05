.DEFAULT_GOAL := help

install:
	./tools/install.sh

uninstall:
	./tools/uninstall.sh

help:
	@echo "help"
	@echo "    shows this message"
	@echo ""
	@echo "install"
	@echo "    runs tools/install.sh, which installs the dotfiles. "
	@echo ""
	@echo "uninstall"
	@echo "    runs uninstall.sh, which uninstalls the dotfiles by replacing "
	@echo "    any dotfiles managed symlinks with copies of their target from "
	@echo "    the dotfiles project. "
	@echo ""
