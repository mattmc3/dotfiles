export PATH="$PATH:$HOME/bin/git"

function clone {
  if [[ -z "$1" ]]; then
    echo "What git repo do you want?" >&2
    return 1
  fi
  local user repo
  if [[ "$1" = */* ]]; then
    user="${1%/*}"
    repo="${1##*/}"
  else
    user=mattmc3
    repo="$1"
  fi

  local giturl="github.com"
  local dest="${XDG_PROJECTS_HOME:-$HOME/Projects}/$user/$repo"

  if [[ ! -d $dest ]]; then
    git clone --recurse-submodules "git@${giturl}:${user}/${repo}.git" "$dest"
  else
    echo "No need to clone, that directory already exists."
    echo "Taking you there."
  fi
  cd "$dest"
}
