# shellcheck shell=bash source=/dev/null

# Manage Python venvs.
function venv {
  local workon_home="${WORKON_HOME:-${XDG_DATA_HOME:-$HOME/.local/share}/venvs}"
  local -a usage=(
    "usage: venv [--home=<home>] [-r|--remove] [-p|--path] <pyvenv>"
    "       venv [-h|--help] [-l|--list]"
  )
  local -a o_badopt o_home o_list o_remove o_path

  # Show help if no arguments provided.
  if [[ "$#" -eq 0 ]]; then
    printf "%s\n" "${usage[@]}"; return 0
  fi

  # Parse arguments
  while [[ "$#" -gt 0 ]]; do
    case "$1" in
      --)          shift; break ;;
      -h|--help)   printf "%s\n" "${usage[@]}"; return 0 ;;
      -l|--list)   o_list+=("$1")        ;;
      -r|--remove) o_remove+=("$1")      ;;
      -p|--path)   o_path+=("$1")        ;;
      --home)      shift; o_home+=("$1") ;;
      --home=*)    o_home=("${1#*=}")    ;;
      -*)          o_badopt+=("$1")      ;;
      *)           break                 ;;
    esac
    shift
  done

  if [[ "${#o_badopt}" -gt 0 ]]; then
    echo >&2 "venv: Unexpected option '${o_badopt[0]}'."
    printf "%s\n" "${usage[@]}"; return 1
  fi

  if [[ "${#o_home}" -gt 0 ]]; then
    workon_home="${o_home[-1]}"
  fi

  # --list
  if [[ "${#o_list}" -gt 0 ]]; then
    shopt -s nullglob
    local pyvenv
    for pyvenv in "$workon_home"/*; do
      echo "${pyvenv##*/}"
    done
    shopt -u nullglob
    return 0
  fi

  # Expecting <pyvenv>
  if [[ "$#" -eq 0 ]]; then
    echo >&2 "venv: Expecting argument <pyvenv>. Try 'venv -h' for usage."
    return 1
  fi

  # --path/--remove
  if [[ "${#o_path}" -gt 0 ]] || [[ "${#o_remove}" -gt 0 ]]; then
    if [[ ! -d "$workon_home/$1" ]]; then
      echo >&2 "venv: pyvenv not found '$1'."
      return 1
    fi
    if [[ "${#o_remove}" -gt 0 ]]; then
      rm -rf -- "${workon_home:?}/$1"
    else
      echo "$workon_home/$1"
    fi
    return 0
  fi

  # Make venv if missing and activate
  if [[ ! -d "$workon_home/$1" ]]; then
    echo "Creating pyvenv: '$1'."
    python3 -m venv "$workon_home/$1" || return 1
  fi
  source "$workon_home/$1/bin/activate"
}

# Work on Python venvs.
function workon() {
  if [[ "$#" -eq 0 ]]; then
    echo >&2 "workon: Expecting name of Python venv."
    return 1
  fi
  local workon_home="${WORKON_HOME:-${XDG_DATA_HOME:-$HOME/.local/share}/venvs}"
  [[ -d "$workon_home" ]] || mkdir -p "$workon_home"
  if [[ ! -d "$workon_home/$1" ]]; then
    echo >&2 "workon: Python venv not found '$1'."
    return 1
  fi
  source "$workon_home/$1/bin/activate"
}
