# shellcheck shell=bash disable=SC1091
#
# Jupyter
#

export JUPYTER_CONFIG_DIR="${JUPYTER_CONFIG_DIR:-${XDG_CONFIG_HOME:-$HOME/.config}/jupyter}"

# shellcheck disable=SC2016
function juno {
  local workon_home="${WORKON_HOME:-${XDG_DATA_HOME:-$HOME/.local/share}/venvs}"
  [[ -d "$workon_home" ]] || mkdir -p "$workon_home"

  if [[ ! -d "$workon_home/juno" ]]; then
    if command -v workon >/dev/null 2>&1; then
      workon juno
    else
      python3 -m venv "$workon_home/juno" || return 1
      source "$workon_home/juno/bin/activate"
    fi
    pip install --upgrade pip
    pip install jupyterlab
    pip install pandas
    deactivate
  fi

  local jupyter_prj=$HOME/Projects/mattmc3/jupyter
  if [[ ! -d "$jupyter_prj" ]]; then
    git clone git@github.com:mattmc3/jupyter "$jupyter_prj"
  fi

  jupyter lab "${1:-$jupyter_prj}"
}
