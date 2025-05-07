##? Get an Azure DB token
function azdbtok {
    local tok="$(az account get-access-token --resource https://ossrdbms-aad.database.windows.net --query accessToken --output tsv)"
    echo "$tok" | tee >(pbcopy) >(cat)
}

##? Show all extensions in current folder structure.
function allexts {
  find . -not \( -path '*/.git/*' -prune \) -type f -name '*.*' | sed 's|.*\.|\.|' | sort | uniq -c
}

##? Backup files or directories
function bak {
  local now f
  now=$(date +"%Y%m%d-%H%M%S")
  for f in "$@"; do
    if [[ ! -e "$f" ]]; then
      echo "file not found: $f" >&2
      continue
    fi
    cp -R "$f" "$f".$now.bak
  done
}

##? clone - clone a git repo
function clone {
  if [[ -z "$1" ]]; then
    echo "What git repo do you want?" >&2
    return 1
  fi
  local user repo
  if [[ "$1" = */* ]]; then
    user=${1%/*}
    repo=${1##*/}
  else
    user=mattmc3
    repo=$1
  fi

  local giturl="github.com"
  local dest=${XDG_PROJECTS_HOME:-~/Projects}/$user/$repo

  if [[ ! -d $dest ]]; then
    git clone --recurse-submodules "git@${giturl}:${user}/${repo}.git" "$dest"
  else
    echo "No need to clone, that directory already exists."
    echo "Taking you there."
  fi
  cd $dest
}

##? noext - Find files with no file extension
function noext {
  # for fun, rename with: noext -exec mv '{}' '{}.sql' \;
  find . -not \( -path '*/.git/*' -prune \) -type f ! -name '*.*'
}


##? optdiff - show a diff between set options and Zsh defaults
function optdiff {
  tmp1=$(mktemp)
  tmp2=$(mktemp)
  zsh -df -c "set -o" >| $tmp1
  set -o >| $tmp2
  gdiff --changed-group-format='%<' --unchanged-group-format='' $tmp2 $tmp1
  rm $tmp1 $tmp2
}

##? Remove zwc files
function rmzwc {
  if [[ "$1" == "--help" ]] || [[ "$1" == "-h" ]]; then
    echo "rmzwc"
    echo "  removes zcompiled files"
    echo "options:"
    echo " -q         Quiet"
    echo " --dry-run  Dry run"
    echo " -h --help  Show help screen"
    return 0
  fi

  local findprint="-print"
  local finddel="-delete"
  if [[ "$1" == '-q' ]]; then
    findprint=""
  elif [[ "$1" == "--dry-run" ]]; then
    finddel=""
  fi

  if [[ -d "${ZDOTDIR}" ]]; then
    find "${ZDOTDIR:A}" -type f \( -name "*.zwc" -o -name "*.zwc.old" \) $findprint $finddel
  fi
  find "$HOME" -maxdepth 1 -type f \( -name "*.zwc" -o -name "*.zwc.old" \) $findprint $finddel
  find . -maxdepth 1 -type f \( -name "*.zwc" -o -name "*.zwc.old" \) $findprint $finddel
}

##? substenv - substitutes string parts with environment variables
function substenv {
  if (( $# == 0 )); then
    subenv ZDOTDIR | subenv HOME
  else
    local sedexp="s|${(P)1}|\$$1|g"
    shift
    sed "$sedexp" "$@"
  fi
}

function tailf {
  local nl
  tail -f $2 | while read j; do
    print -n "$nl$j"
    nl="\n"
  done
}

##? touchf - makes any dirs recursively and then touches a file if it doesn't exist
function touchf {
  if [[ -n "$1" ]] && [[ ! -f "$1" ]]; then
    mkdir -p "$1:h" && touch "$1"
  fi
}

# # works in both bash and zsh
# ##? up - go up any number of directories
# up() {
#   local parents=${1:-1}
#   if ! (( "$parents" > 0 )); then
#     echo >&2 "up: expecting a numeric parameter"
#     return 1
#   fi
#   local i dotdot=".."
#   for ((i = 1 ; i < parents ; i++)); do
#     dotdot+="/.."
#   done
#   cd $dotdot
# }

##? What's the weather?
function weather {
  curl "http://wttr.in/$1"
}

function zcompiledir {
  emulate -L zsh; setopt localoptions extendedglob globdots globstarshort nullglob rcquotes
  autoload -U zrecompile

  local f
  local flag_clean=false
  [[ "$1" == "-c" ]] && flag_clean=true && shift
  if [[ -z "$1" ]] || [[ ! -d "$1" ]]; then
    echo "Bad or missing directory $1" && return 1
  fi

  if [[ $flag_clean == true ]]; then
    for f in "$1"/**/*.zwc(.N) "$1"/**/*.zwc.old(.N); do
      echo "removing $f" && command rm -f "$f"
    done
  else
    for f in "$1"/**/*.zsh{,-theme}; do
      echo "compiling $f" && zrecompile -pq "$f"
    done
  fi
}

##? Echo to stderror
function echoerr {
  echo >&2 "$@"
}

##? Pass thru for copy/paste markdown
function $ { $@ }

##? Check if a file can be autoloaded by trying to load it in a subshell.
function is-autoloadable {
  ( unfunction $1 ; autoload -U +X $1 ) &> /dev/null
}

##? Check if a name is a command, function, or alias.
function is-callable {
  (( $+commands[$1] || $+functions[$1] || $+aliases[$1] || $+builtins[$1] ))
}

##? Check a string for case-insensitive "true" value (1,y,yes,t,true,o,on).
function is-true {
  [[ -n "$1" && "$1:l" == (1|y(es|)|t(rue|)|o(n|)) ]]
}

# OS checks.
function is-macos  { [[ "$OSTYPE" == darwin* ]] }
function is-linux  { [[ "$OSTYPE" == linux*  ]] }
function is-bsd    { [[ "$OSTYPE" == *bsd*   ]] }
function is-cygwin { [[ "$OSTYPE" == cygwin* ]] }
function is-termux { [[ "$OSTYPE" == linux-android ]] }

function mkdirvar {
  local dirvar
  for dirvar in $@; do
    [[ -n "$dirvar" ]] && [[ -n "${(P)dirvar}" ]] || continue
    [[ -d "${(P)dirvar}" ]] || mkdir -p "${(P)dirvar}"
  done
}

##? funcfresh - refresh function definition
function funcfresh {
  if ! (( $# )); then
    echo >&2 "funcfresh: Expecting function argument."
    return 1
  elif ! (( $+functions[$1] )); then
    echo >&2 "funcfresh: Function not found '$1'."
    return 1
  fi
  unfunction $1
  autoload -Uz $1
}
