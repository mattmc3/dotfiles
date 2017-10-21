.DEFAULT_GOAL := help

backup:
	@./scripts/backup.sh

clean:
	@./scripts/clean.sh

init:
	@./scripts/init.sh

restore:
	@./scripts/restore.sh

help:
	@echo "help"
	@echo "    shows this message"
	@echo ""
	@echo "init"
	@echo "    runs scripts/init.sh, which sets up the machine and dotfiles to "
	@echo "    ensure that the environment works. Usually, this is a one time "
	@echo "    setup. "
	@echo ""
	@echo "backup"
	@echo "    runs scripts/backup.sh, which backs up dotfiles and settings "
	@echo "    on the current machine, as well as any other build tasks. "
	@echo ""
	@echo "restore"
	@echo "    runs scripts/restore.sh, which restores dotfiles on the current "
	@echo "    machine from this dotfiles repo. "
	@echo "    WARNING: this is potentially a destructive action. Only run this"
	@echo "    if you want to overwrite your existing settings."
	@echo ""
