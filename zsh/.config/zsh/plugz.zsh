#!/usr/bin/env zsh
local PLUGZ_SOURCE="$0:A:h"

_plugz_echo() { printf %s\\n "$@" ;}
_plugz_echoerr() { printf %s\\n "-- plugz: $*" >&2 ;}

_plugz_init() { _plugz_echo "$*" >> "${PLUGZ_INIT}" ;}


if [[ -z "${PLUGZ_DIR}" ]]; then
  PLUGZ_DIR="${ZDOTDIR:-$HOME}/.zplugins"
fi

if [[ -z "${PLUGZ_INIT}" ]]; then
  PLUGZ_INIT="${PLUGZ_DIR}/init.zsh"
fi

# The user can explicitly disable plugz attempting to invoke `compinit`, or it
# will be automatically disabled if `compinit` appears to have already been
# invoked.
if [[ -z "${PLUGZ_AUTOLOAD_COMPINIT}" && -z "${(t)_comps}" ]]; then
  PLUGZ_AUTOLOAD_COMPINIT=1
fi

if [[ -n "${PLUGZ_CUSTOM_COMPDUMP}" ]]; then
  PLUGZ_COMPINIT_DIR_FLAG="-d ${(q)PLUGZ_CUSTOM_COMPDUMP}"
  PLUGZ_COMPINIT_FLAGS="${PLUGZ_COMPINIT_DIR_FLAG} ${PLUGZ_COMPINIT_FLAGS}"
fi

if [[ -z "${PLUGZ_LOADED}" ]]; then
  PLUGZ_LOADED=()
fi

if [[ -z "${PLUGZ_PREZTO_OPTIONS}" ]]; then
  PLUGZ_PREZTO_OPTIONS=()
fi

if [[ -z "${PLUGZ_PREZTO_LOAD}" ]]; then
  PLUGZ_PREZTO_LOAD=()
fi

if [[ -z "${PLUGZ_COMPLETIONS}" ]]; then
  PLUGZ_COMPLETIONS=()
fi

if [[ -z "${PLUGZ_USE_PREZTO}" ]]; then
  PLUGZ_USE_PREZTO=0
fi

if [[ -z "${PLUGZ_PREZTO_LOAD_DEFAULT}" ]]; then
  PLUGZ_PREZTO_LOAD_DEFAULT=1
fi

if [[ -z "${PLUGZ_OH_MY_ZSH_REPO}" ]]; then
  PLUGZ_OH_MY_ZSH_REPO=ohmyzsh
fi

if [[ "${PLUGZ_OH_MY_ZSH_REPO}" != */* ]]; then
  PLUGZ_OH_MY_ZSH_REPO="${PLUGZ_OH_MY_ZSH_REPO}/ohmyzsh"
fi

if [[ -z "${PLUGZ_OH_MY_ZSH_BRANCH}" ]]; then
  PLUGZ_OH_MY_ZSH_BRANCH=master
fi

if [[ -z "${PLUGZ_PREZTO_REPO}" ]]; then
  PLUGZ_PREZTO_REPO=sorin-ionescu
fi

if [[ "${PLUGZ_PREZTO_REPO}" != */* ]]; then
  PLUGZ_PREZTO_REPO="${PLUGZ_PREZTO_REPO}/prezto"
fi

if [[ -z "${PLUGZ_PREZTO_BRANCH}" ]]; then
  PLUGZ_PREZTO_BRANCH=master
fi

_plugz_encode_url () {
  # remove characters from a url that don't work well in a filename.
  # inspired by -anti-get-clone-dir() method from antigen.
  local url="${1}"
  url="${url//\//-SLASH-}"
  url="${url//\:/-COLON-}"
  url="${url//\|/-PIPE-}"
  url="${url//~/-TILDE-}"
  _plugz_echo "$url"
}

_plugz_get_clone_dir() {
  local repo="${1}"
  local branch="${2:-master}"

  if [[ -e "${repo}/.git" ]]; then
    _plugz_echo "${PLUGZ_DIR}/local/${repo:t}-${branch}"
  else
    # Repo directory will be location/reponame
    local reponame="${repo:t}"
    # Need to encode incase it is a full url with characters that don't
    # work well in a filename.
    local location="$(_plugz_encode_url ${repo:h})"
    repo="${location}/${reponame}"
    _plugz_echo "${PLUGZ_DIR}/${repo}-${branch}"
  fi
}

_plugz_get_clone_url() {
  local repo="${1}"

  if [[ -e "${repo}/.git" ]]; then
    _plugz_echo "${repo}"
  else
    # expand short github url syntax: `username/reponame`.
    if [[ $repo != git://* &&
          $repo != https://* &&
          $repo != http://* &&
          $repo != ssh://* &&
          $repo != git@*:*/*
        ]]; then
      repo="https://github.com/${repo%.git}.git"
    fi
    _plugz_echo "${repo}"
  fi
}

plugz_clone() {
  local repo="${1}"
  local branch="${2:-master}"
  local url="$(_plugz_get_clone_url ${repo})"
  local dir="$(_plugz_get_clone_dir ${repo} ${branch})"

  if [[ ! -d "${dir}" ]]; then
    mkdir -p "${dir}"
    git clone --depth=1 --recursive -b "${branch}" "${url}" "${dir}"
  fi
}

_plugz_add_to_fpath() {
  local completion_path="${1}"

  # add the directory to PLUGZ_COMPLETIONS array if not present
  if [[ ! "${PLUGZ_COMPLETIONS[@]}" =~ ${completion_path} ]]; then
    PLUGZ_COMPLETIONS+=("${completion_path}")
  fi
}

_plugz_source() {
  local file="${1}"

  if [[ ! "${PLUGZ_LOADED[@]}" =~ "${file}" ]]; then
    PLUGZ_LOADED+=("${file}")
    source "${file}"

    completion_path="${file:h}"

    _plugz_add_to_fpath "${completion_path}"
  fi
}

_plugz_prezto_option() {
  local module options params
  module=${1}; shift
  option=${1}; shift
  params=${@}
  if [[ ${module} =~ "^:" ]]; then
    module=${module[1,]}
  fi
  if [[ ! $module =~ "^(\*|module|prezto:module):" ]]; then
    module="module:$module"
  fi
  if [[ ! $module =~ "^(prezto):" ]]; then
    module="prezto:$module"
  fi
  local cmd="zstyle ':${module}' $option ${params}"

  # execute in place
  eval $cmd

  if [[ ! "${PLUGZ_PREZTO_OPTIONS[@]}" =~ "${cmd}" ]]; then
    PLUGZ_PREZTO_OPTIONS+=("${cmd}")
  fi
}

_plugz_prezto_load(){
  local params="$*"
  local cmd="pmodload ${params[@]}"

  # execute in place
  eval $cmd

  if [[ ! "${PLUGZ_PREZTO[@]}" =~ "${cmd}" ]]; then
    PLUGZ_PREZTO_LOAD+=("${params[@]}")
  fi
}

plugz_init() {
  if [[ -f "${PLUGZ_INIT}" ]]; then
    source "${PLUGZ_INIT}"
  fi
}

plugz_reset() {
  _plugz_echoerr 'Deleting `'"${PLUGZ_INIT}"'` ...'
  if [[ -f "${PLUGZ_INIT}" ]]; then
    rm "${PLUGZ_INIT}"
  fi
  if [[ -f "${PLUGZ_CUSTOM_COMPDUMP}" ]] || [[ -d "${PLUGZ_CUSTOM_COMPDUMP}" ]]; then
    _plugz_echoerr 'Deleting `'"${PLUGZ_CUSTOM_COMPDUMP}"'` ...'
    rm -r "${PLUGZ_CUSTOM_COMPDUMP}"
  fi
}

plugz_update() {
  setopt localoptions extended_glob
  for repo in "${PLUGZ_DIR}"/(^.git)/*; do
    _plugz_echoerr "Updating '${repo}' ..."
    (cd "${repo}" \
      && git pull \
      && git submodule update --init --recursive)
  done
  plugz_reset
}

plugz_save() {
  _plugz_echoerr 'Creating `'"${PLUGZ_INIT}"'` ...'

  _plugz_echo "# {{{" >! "${PLUGZ_INIT}"
  _plugz_init "# Generated by plugz."
  _plugz_init "# This file will be overwritten the next time you run plugz save!"
  _plugz_init ""
  _plugz_init "ZSH=$(_plugz_get_zsh)"
  if [[ ${PLUGZ_USE_PREZTO} == 1 ]]; then
    _plugz_init ""
    _plugz_init "# ### Prezto initialization"
    for option in "${PLUGZ_PREZTO_OPTIONS[@]}"; do
      _plugz_init "${option}"
    done
  fi

  _plugz_init ""
  _plugz_init "# ### General modules"
  for file in "${PLUGZ_LOADED[@]}"; do
    _plugz_init 'source "'"${(q)file}"\"
  done

  # Set up fpath, load completions
  # NOTE: This *intentionally* doesn't use ${PLUGZ_COMPINIT_FLAGS}; the only
  #       available flags are meaningless in the presence of `-C`.
  _plugz_init ""
  _plugz_init "# ### Plugins & Completions"
  _plugz_init 'fpath=('"${(@q)PLUGZ_COMPLETIONS}"' ${fpath})'
  if [[ ${PLUGZ_AUTOLOAD_COMPINIT} == 1 ]]; then
    _plugz_init ""
    _plugz_init 'autoload -Uz compinit && \'
    _plugz_init '   compinit -C '"${PLUGZ_COMPINIT_DIR_FLAG}"
  fi

  # Check for file changes
  if [[ ! -z "${PLUGZ_RESET_ON_CHANGE}" ]]; then
    _plugz_init ""
    _plugz_init "# ### Recompilation triggers"

    local ages="$(stat -Lc "%Y" 2>/dev/null $PLUGZ_RESET_ON_CHANGE || \
            stat -Lf "%m" 2>/dev/null $PLUGZ_RESET_ON_CHANGE)"
    local shas="$(cksum ${PLUGZ_RESET_ON_CHANGE})"

    _plugz_init "read -rd '' ages <<AGES; read -rd '' shas <<SHAS"
    _plugz_init "$ages"
    _plugz_init "AGES"
    _plugz_init "$shas"
    _plugz_init "SHAS"

    _plugz_init 'if [[ -n "$PLUGZ_RESET_ON_CHANGE" \'
    _plugz_init '   && "$(stat -Lc "%Y" 2>/dev/null $PLUGZ_RESET_ON_CHANGE || \'
    _plugz_init '         stat -Lf "%m"             $PLUGZ_RESET_ON_CHANGE)" != "$ages" \'
    _plugz_init '   && "$(cksum                     $PLUGZ_RESET_ON_CHANGE)" != "$shas" ]]; then'
    _plugz_init '   printf %s\\n '\''-- plugz: Files in $PLUGZ_RESET_ON_CHANGE changed; resetting `init.zsh`...'\'
    _plugz_init '   plugz reset'
    _plugz_init 'fi'
  fi

  # load prezto modules
  if [[ ${PLUGZ_USE_PREZTO} == 1 ]]; then
    _plugz_init ""
    _plugz_init "# ### Prezto modules"
    printf %s "pmodload" >> "${PLUGZ_INIT}"
    for module in "${PLUGZ_PREZTO_LOAD[@]}"; do
      printf %s " ${module}" >> "${PLUGZ_INIT}"
    done
  fi

  _plugz_init ""
  _plugz_init "# }}}"

  plugz_apply
}

plugz_apply() {
  fpath=(${(q)PLUGZ_COMPLETIONS[@]} ${fpath})

  if [[ ${PLUGZ_AUTOLOAD_COMPINIT} == 1 ]]; then
    _plugz_echoerr "Initializing completions ..."

    autoload -Uz compinit && \
      compinit $PLUGZ_COMPINIT_FLAGS
  fi
}

_plugz_path-contains() {
  setopt localoptions nonomatch nocshnullglob nonullglob;
  [ -e "$1"/*"$2"(.,@[1]) ]
}

_plugz_get_zsh(){
  if [[ ${PLUGZ_USE_PREZTO} == 1 ]]; then
    _plugz_echo "$(_plugz_get_clone_dir "$PLUGZ_PREZTO_REPO" "$PLUGZ_PREZTO_BRANCH")"
  else
    _plugz_echo "$(_plugz_get_clone_dir "$PLUGZ_OH_MY_ZSH_REPO" "$PLUGZ_OH_MY_ZSH_BRANCH")"
  fi
}

plugz_load() {
  if [[ "$#" == 0 ]]; then
    _plugz_echoerr '`load` requires at least one parameter:'
    _plugz_echoerr '`plugz load <repo> [location] [branch]`'
  elif [[ "$#" == 1 && ("${1[1]}" == '/' || "${1[1]}" == '.' ) ]]; then
    local location="${1}"
  else
    local repo="${1}"
    local file="${2}"
    local branch="${3:-master}"
    local dir="$(_plugz_get_clone_dir ${repo} ${branch})"
    local location="${dir}/${file}"
    location=${location%/}

    # clone repo if not present
    if [[ ! -d "${dir}" ]]; then
      plugz_clone "${repo}" "${branch}"
    fi
  fi

  # source the file
  if [[ -f "${location}" ]]; then
    _plugz_source "${location}"

  # Prezto modules have init.zsh files
  elif [[ -f "${location}/init.zsh" ]]; then
    _plugz_source "${location}/init.zsh"

  elif [[ -f "${location}.zsh-theme" ]]; then
    _plugz_source "${location}.zsh-theme"

  elif [[ -f "${location}.theme.zsh" ]]; then
    _plugz_source "${location}.theme.zsh"

  elif [[ -f "${location}.zshplugin" ]]; then
    _plugz_source "${location}.zshplugin"

  elif [[ -f "${location}.zsh.plugin" ]]; then
    _plugz_source "${location}.zsh.plugin"

  # Classic ohmyzsh plugins have foo.plugin.zsh
  elif _plugz_path-contains "${location}" ".plugin.zsh" ; then
    for script (${location}/*\.plugin\.zsh(N)) _plugz_source "${script}"

  elif _plugz_path-contains "${location}" ".zsh" ; then
    for script (${location}/*\.zsh(N)) _plugz_source "${script}"

  elif _plugz_path-contains "${location}" ".sh" ; then
    for script (${location}/*\.sh(N)) _plugz_source "${script}"

  # Completions
  elif [[ -d "${location}" ]]; then
    _plugz_add_to_fpath "${location}"

  else
    if [[ -d ${dir:-$location} ]]; then
    _plugz_echoerr "Failed to load ${dir:-$location} -- ${file}"
    else
    _plugz_echoerr "Failed to load ${dir:-$location}"
    fi
  fi
}

plugz_loadall() {
  # shameless copy from antigen

  # Bulk add many bundles at one go. Empty lines and lines starting with a `#`
  # are ignored. Everything else is given to `plugz_load` as is, no
  # quoting rules applied.

  local line

  grep '^[[:space:]]*[^[:space:]#]' | while read line; do
    # Using `eval` so that we can use the shell-style quoting in each line
    # piped to `antigen-bundles`.
    eval "plugz_load $line"
  done
}

plugz_saved() {
  [[ -f "${PLUGZ_INIT}" ]] && return 0 || return 1
}

plugz_list() {
  if [[ -f "${PLUGZ_INIT}" ]]; then
    cat "${PLUGZ_INIT}"
  else
    _plugz_echoerr '`init.zsh` missing, please use `plugz save` and then restart your shell.'
    return 1
  fi
}

plugz_selfupdate() {
  if [[ -e "${PLUGZ_SOURCE}/.git" ]]; then
    (cd "${PLUGZ_SOURCE}" \
      && git pull) \
      && plugz reset
  else
    _plugz_echoerr "Not running from a git repository; cannot automatically update."
    return 1
  fi
}

plugz_ohmyzsh() {
  local repo="$PLUGZ_OH_MY_ZSH_REPO"
  local file="${1:-oh-my-zsh.sh}"

  plugz_load "${repo}" "${file}"
}

plugz_prezto() {
  local repo="$PLUGZ_PREZTO_REPO"
  local file="${1:-init.zsh}"

  # load prezto itself
  if [[ $# == 0 ]]; then
    PLUGZ_USE_PREZTO=1
    plugz_load "${repo}" "${file}"
    if [[ ${PLUGZ_PREZTO_LOAD_DEFAULT} != 0 ]]; then
      _plugz_prezto_load "'environment' 'terminal' 'editor' 'history' 'directory' 'spectrum' 'utility' 'completion' 'prompt'"
    fi

  # this is a prezto module
  elif [[ $# == 1 ]]; then
    local module=${file}
    if [[ -z ${file} ]]; then
      _plugz_echoerr 'Please specify which module to load using `plugz prezto <name of module>`'
      return 1
    fi
    _plugz_prezto_load "'$module'"

  # this is a prezto option
  else
    shift
    _plugz_prezto_option ${file} ${(qq)@}
  fi

}

plugz_pmodule() {
  local repo="${1}"
  local branch="${2:-master}"

  local dir="$(_plugz_get_clone_dir ${repo} ${branch})"

  # clone repo if not present
  if [[ ! -d "${dir}" ]]; then
    plugz_clone "${repo}" "${branch}"
  fi

  local module="${repo:t}"
  _plugz_prezto_load "'${module}'"
}

plugz() {
  local cmd="${1}"
  if [[ -z "${cmd}" ]]; then
    _plugz_echo 'usage: `plugz [command | instruction] [options]`'
    _plugz_echo "    commands: list, saved, reset, clone, update, selfupdate"
    _plugz_echo "    instructions: load, ohmyzsh, pmodule, prezto, save, apply"
    return 1
  fi

  shift

  if functions "plugz_${cmd}" > /dev/null ; then
    "plugz_${cmd}" "${@}"
  else
    _plugz_echoerr 'Command not found: `'"${cmd}"\`
    return 1
  fi
}

ZSH=$(_plugz_get_zsh)
fpath=($PLUGZ_SOURCE $fpath)
plugz_init
