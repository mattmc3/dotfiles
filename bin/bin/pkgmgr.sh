#!/usr/bin/env sh

echoerr() {
	echo $@ 1>&2
}

fatal() {
	echo $@ 1>&2
	exit 1
}

ensure_app_exists() {
	type $1 > /dev/null 2>&1 || { echoerr "$1 not found!"; exit 1; }
}

ensure_fn_exists() {
	declare -f -F $1 > /dev/null
	return $?
}

apm_export() {
	apm list --installed --bare | grep -v 'node_modules' | grep . | sort -f
}

apm_import() {
	awk -F'@' '{print $1}' "$1" |
		xargs -I % sh -c '[ ! -d "$HOME/.atom/packages/%" ] && apm install % --compatible || echo "already installed: %"'
}

gem_export() {
	gem list --local
}

gem_import() {
	awk '{ print $1 }' "$1" | xargs gem install --conservative
}

brew_export() {
	# brew is a pain... it dumps to a forced Brewfile, and is not consistently
	# sorted, making version controling your Brewfile tricky. #FixedIt
	brew bundle dump --force
	brewfile="Brewfile"
	brewfile_tmp="Brewfile.tmp"
	grep '^tap\ '  "$brewfile" | sort  > "$brewfile_tmp"
	grep '^brew\ ' "$brewfile" | sort >> "$brewfile_tmp"
	grep '^cask\ ' "$brewfile" | sort >> "$brewfile_tmp"
	grep '^mas\ '  "$brewfile" | sort >> "$brewfile_tmp"
	cat "$brewfile_tmp"
	rm "$brewfile_tmp" "$brewfile"
}

brew_import() {
	brew bundle --file="$1"
}

macos_apps_export() {
	# get a list of the mac apps installed. Apps are really directories, so
	# don't descend into it.
	find /Applications -type d -not \( -path '*.app/*' -prune \) -name '*.app' | cut -d'/' -f3- | sort -f
}

pip_export() {
	pip$2 freeze
}

pip_import() {
	pip$2 install -r "$1"
}

npm_export() {
	npm ls -g --depth=0
}

npm_import() {
	awk 'NR>1{ print $2 }' "$1" | awk -F'@' '{ print $1 }' | xargs npm install -g
}

code_export() {
	code --list-extensions
}

code_import() {
	cat "$1" | xargs -L 1 code --install-extension
}

azuredatastudio_export() {
	azure-data-studio --list-extensions
}

main() {
	local action="$1"
	local app="$2"
	local appname="$2"
	local filepath="$3"

	# who cares what order we got the params in. swap em if needed
	if [ $app == "export" ] || [ $app == "import" ]; then
		tmp="$action"
		action="$app"
		app="$tmp"
	fi

	# pip2/3 support...
	local rest=
	if [[ $app != "pip" ]] && [[ $app == pip* ]]; then
		rest=${app##*pip}
		appname=pip
	fi

	if [[ $app == "macos_apps" ]]; then
		app=
	fi

	[[ -z $app ]] || ensure_app_exists "$app"
	ensure_fn_exists "${appname}_${action}"

	if [[ $action == "import" ]]
	then
		[[ -f "$filepath" ]] || fatal "import packages file not found: $filepath"
	fi

	${appname}_${action} "$filepath" $rest
}
main $@
