.DEFAULT_GOAL := help

backup:
	./scripts/pkglist.sh backup

restore:
	./scripts/pkglist.sh restore

install:
	./scripts/dotfiles.sh install

uninstall:
	./scripts/dotfiles.sh uninstall

help:
	@echo "help"
	@echo "    shows this message"
	@echo ""
	@echo "backup"
	@echo "    Runs backup scripts for each dotfiles app. "
	@echo "    Backup is for taking snapshots of settings that aren't able to "
	@echo "    be easily symlinked, such as editor packages or extensions. "
	@echo ""
	@echo "restore"
	@echo "    Runs restore scripts for each dotfiles app. "
	@echo "    Restore applies whatever backups were taken by 'make backup'. "
	@echo ""
	@echo "install"
	@echo "    Runs install scripts for each dotfiles app. "
	@echo "    Install should add symlinks for any app in this dotfiles "
	@echo "    project. "
	@echo ""
	@echo "uninstall"
	@echo "    Runs uninstall scripts for each dotfiles app. "
	@echo "    Uninstall should remove symlinks put in place with "
	@echo "    'make install' and put back physical copies of from this "
	@echo "    dotfiles project. "
	@echo ""
