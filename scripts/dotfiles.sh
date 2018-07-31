#!/usr/bin/env bash
# dotfiles installer

# set variables
_dotfiles_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
_backup_dir="${_dotfiles_dir}/bak/$(date +"%Y%m%d_%H%M%S")"

file_list=()
while IFS= read -d $'\0' -r file ; do
    file_list=("${file_list[@]}" "$file")
done < <(find ./home -type f -not -name ".DS_Store" -not -path "*.symlink/*" -print0)

function usage() {
    echo "Usage:"
    echo "  dotfiles.sh install"
    echo "  dotfiles.sh uninstall"
}

function abspath() {
    if [ "$1" == "." ]; then
        echo "$(pwd)"
    elif [ "$1" == ".." ]; then
        echo "$(dirname "$(pwd)")"
    else
        echo "$(cd "$(dirname "$1")"; pwd)/$(basename "$1")"
    fi
}

function swapdir() {
    echo "${3}${1#$2}"
}

function symlink_dotfile() {
    # args
    local source="$1"
    local target="$2"
    local exitcode=

    # backup
    if [[ -e "${target}" ]]; then
        mkdir -p "${_backup_dir}"
        backup_target=`swapdir "$target" "$HOME" "$_backup_dir"`
        backup_target_dir=`dirname "$backup_target"`
        if [[ ! -d "$backup_target_dir" ]]; then
            mkdir -p "$backup_target_dir"
        fi

        if [[ -d "${target}" ]]; then
            cp -r "${target}" "${backup_target}"
        else
            cp "${target}" "${backup_target}"
        fi
    fi

    # install symlink
    echo "symlinking \"${source}\" to \"${target}\""
    if [[ -d "${source}" ]]; then
        rm -rf "${target}"
    fi
    ln -sfn "${source}" "${target}"
    exitcode=$?
    if [[ $exitcode -ne 0 ]]; then
        echo "FAILED symlinking!" 1>&2
        return 1
    else
        return 0
    fi
}

function unsymlink_dotfile() {
    local symlink=$1
    if [[ -L "${symlink}" ]]; then
        echo "uninstalling ${symlink}"
        target=$(readlink "$symlink")

        if [[ -d "${symlink}" ]]; then
            unlink "${symlink}"
            cp -r "$target" "$symlink"
        else
            rm -f "$symlink"
            cp "$target" "$symlink"
        fi
    else
        echo "File is not a symlink: ${symlink}. Skipping..."
    fi
}

function main() {
    for file in "${file_list[@]}" ; do
        dotfile_path=`abspath "$file"`
        dest_file=`swapdir "$dotfile_path" "$_dotfiles_dir/home" "$HOME"`
        dest_dir=`dirname "$dest_file"`
        if [[ ! -d "$dest_dir" ]]; then
            mkdir -p "$dest_dir"
        fi

        if [[ $_action = "install" ]]; then
            symlink_dotfile "$dotfile_path" "$dest_file"
        elif [[ $_action = "uninstall" ]]; then
            unsymlink_dotfile "$dest_file"
        fi
    done
}

# begin script
_action="$1"
if [[ $_action != "install" ]] && [[ $_action != "uninstall" ]]; then
    usage
    exit 1
fi
main
