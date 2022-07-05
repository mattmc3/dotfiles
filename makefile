# makefile
.PHONY: help submodules
.DEFAULT_GOAL := help

submodules:
	git submodule update --recursive --remote

help:
	@echo "help"
	@echo "    shows this message"
	@echo ""
	@echo "submodules"
	@echo "    Update submodules. "
