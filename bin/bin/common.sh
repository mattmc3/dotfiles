# common bash functions... good for an import, or just to copy/paste elsewhere

echoerr() { echo $@ 1>&2; return 1; }

fatalerr() { echo $@ 1>&2; exit 1; }

fn_exists() {
	[[ -n "$1" ]] || echo "usage: fn_exists <fn>" 1>&2
	declare -f -F $1 > /dev/null
	return $?
}

cmd_exists() {
	[[ -n "$1" ]] || echo "usage: cmd_exists <cmd>" 1>&2
	if ! type $1 > /dev/null 2>&1 ; then
		return 1
	fi
	return 0
}
