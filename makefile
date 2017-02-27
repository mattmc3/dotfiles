.DEFAULT_GOAL := help

build:
	./scripts/build.sh

install:
	./scripts/install.sh

uninstall:
	./scripts/uninstall.sh

# atom
# https://discuss.atom.io/t/installed-packages-list-into-single-file/12227/9
# https://discuss.atom.io/t/how-to-backup-all-your-settings/15674
apm-install:
	apm install --packages-file ./modules/atom/apmfile.txt

apm-export:
	apm list --installed --bare > ./modules/atom/apmfile.txt
	apm list > ./modules/atom/apm-list-raw.txt

help:
	@echo "help"
	@echo "    shows this message"
	@echo ""
	@echo "build"
	@echo "    runs build.sh, which updates some of the project files from the "
	@echo "    master files on the current machine, as well as any other build "
	@echo "    tasks. "
	@echo ""
	@echo "install"
	@echo "    runs install.sh, which installs the dotfiles on the machine. "
	@echo ""
	@echo "uninstall"
	@echo "    runs uninstall.sh, which uninstalls the dotfiles by replacing "
	@echo "    any dotfiles managed symlinks with copies of their target from "
	@echo "    the dotfiles project. "
	@echo ""
	@echo "apm-export"
	@echo "    exports a snapshot of all of atom's installed packages into the "
	@echo "    dotfiles apmfile.txt. "
	@echo ""
	@echo "apm-install"
	@echo "    runs atom's package manager (apm) to install all packages in "
	@echo "    the dotfiles apmfile.txt. "
	@echo ""
