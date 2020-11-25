#!/usr/bin/env bash

function usage() {
   cat << HEREDOC

   Usage: restore-pip-pkgs [--pip NUM]

   optional arguments:
     -h, --help           show this help message and exit
     -p, --pip NUM        which pip (2 or 3?)

HEREDOC
}

function main() {
	POSITIONAL=()
	pip="pip"
	while [ "$#" -gt 0 ]; do
		case "$1" in
			-h) usage; exit 0;;
			-p) pip="$2"; shift 2;;

			--pip=*) pip="pip${1#*=}"; shift 1;;
			--pip) echo "$1 requires an argument" >&2; exit 1;;

			-*) echo "unknown option: $1" >&2; exit 1;;
			*) POSITIONAL+=("$1"); shift 1;;
		esac
	done

	restore_file="${POSITIONAL[0]:-$PWD/$pip-requirements.txt}"
	[[ -f "$restore_file" ]] || { echo >&2 "pip requirements file not found: $restore_file"; exit 1; }
	command -v $pip >/dev/null 2>&1 || { echo >&2 "$pip not found."; exit 1; }

	echo "restoring $pip packages..."
	$pip install -r "$restore_file"
}
main $@
