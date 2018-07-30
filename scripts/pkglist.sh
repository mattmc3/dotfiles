#!/usr/bin/env bash

function usage() {
    echo "Usage:"
    echo "pkglist.sh backup"
    echo "pkglist.sh restore"
}

function apm_pkglist() {
    if type apm > /dev/null 2>&1 ; then
        echo "${_action} atom packages..."
        if [[ $_action = "backup" ]]; then
            apm list --installed --bare | grep -v 'node_modules' > "${_dotfiles_root}/pkglist/apm-list.txt"
        else
            lines=`cat "${_dotfiles_root}/pkglist/apm-list.txt"`
            for line in $lines ; do
                # the apm export has version numbers that packages-file does not need
                local atom_pkg=`echo $line | awk -F'@' '{ print $1 }'`
                if [[ ! -d "$HOME/.atom/packages/$atom_pkg" ]]; then
                    apm install $atom_pkg --compatible
                else
                    echo "$atom_pkg package already installed"
                fi
            done
        fi
    else
        echo "apm not found... skipping..." 1>&2
        return 1
    fi
}

function brew_pkglist() {
    if type brew > /dev/null 2>&1 ; then
        echo "${_action} Brewfile..."
        if [[ $_action = "backup" ]]; then
            (cd "${_dotfiles_root}/pkglist" && brew bundle dump --force)
        else
            (cd "${_dotfiles_root}/pkglist" && brew bundle)
        fi
    else
        echo "homebrew not found... skipping..." 1>&2
        return 1
    fi
}

function gem_pkglist() {
    if type gem > /dev/null 2>&1 ; then
        echo "${_action} missing ruby gems..."
        if [[ $_action = "backup" ]]; then
            gem list --local > "${_dotfiles_root}/pkglist/gem-list.txt"
        else
            cat "${_dotfiles_root}/pkglist/gem-list.txt" | awk '{ print $1 }' | xargs gem install --conservative
        fi
    else
        echo "ruby gems not found... skipping..." 1>&2
        return 1
    fi
}

function macos_app_pkglist() {
    echo "${_action} macOS app list..."
    if [[ $_action = "backup" ]]; then
        ls -1 /Applications > "${_dotfiles_root}/pkglist/macos-app-list.txt"
    else
        echo "Sorry. No functionality to install macOS app list outside of 'brew cask'."
    fi
}

function npm_pkglist() {
    if type npm > /dev/null 2>&1 ; then
        echo "${_action} node.js packages..."
        if [[ $_action = "backup" ]]; then
            npm ls -g --depth=0 > "${_dotfiles_root}/pkglist/npm-list.txt"
        else
            cat "${_dotfiles_root}/pkglist/npm-list.txt" | awk 'NR>1{ print $2 }' | awk -F'@' '{ print $1 }' | xargs npm install -g
        fi
    else
        echo "npm not found... skipping..." 1>&2
        return 1
    fi
}

function pip_pkglist() {
    pips=(pip2 pip3)
    for pip in "${pips[@]}" ; do
        if type $pip > /dev/null 2>&1 ; then
            echo "restoring python $pip packages..."
            if [[ $_action = "backup" ]]; then
                $pip freeze > "${_dotfiles_root}/pkglist/${pip}_requirements.txt"
            else
                $pip install -r "${_dotfiles_root}/pkglist/${pip}_requirements.txt"
            fi
        else
            echo "$pip not found... skipping..." 1>&2
        fi
    done
}

function subl_pkglist() {
    if [[ -f "$HOME/Library/Application Support/Sublime Text 3/Packages/User/Package Control.sublime-settings" ]] ; then
        echo "${_action} sublime packages..."
        if [[ $_action = "backup" ]]; then
            cp "$HOME/Library/Application Support/Sublime Text 3/Packages/User/Package Control.sublime-settings" "${_dotfiles_root}/pkglist"
        else
            echo "Sorry. Sublime Text 3 package restore not implemented."
        fi
    else
        echo "Sublime Text 3 not found... skipping..." 1>&2
    fi
}

function vscode_pkglist() {
    if type code > /dev/null 2>&1 ; then
        echo "${_action} visual-studio-code extentions..."
        if [[ $_action = "backup" ]]; then
            code --list-extensions > "${_dotfiles_root}/pkglist/extensions.txt"
        else
            cat "${_dotfiles_root}/pkglist/extensions.txt" | xargs -L 1 code --install-extension
        fi
    else
        echo "visual-studio-code not found... skipping..." 1>&2
    fi
}

function main() {
    apm_pkglist
    brew_pkglist
    gem_pkglist
    macos_app_pkglist
    npm_pkglist
    pip_pkglist
    subl_pkglist
    vscode_pkglist
}

# begin
_dotfiles_root="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
_action="$1"
_result=0

if [[ $_action != "backup" ]] && [[ $_action != "restore" ]] ; then
    usage
    _result=1
else
    main
fi

# clean
unset _dotfiles_root
unset _action
unset -f apm_pkglist
unset -f brew_pkglist
unset -f gem_pkglist
unset -f macos_app_pkglist
unset -f npm_pkglist
unset -f pip_pkglist
unset -f subl_pkglist
unset -f vscode_pkglist
unset -f main
exit $_result
