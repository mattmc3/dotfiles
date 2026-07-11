# shellcheck shell=bash

# Cross-platform support for an 'open' command.
if ! type open >/dev/null 2>&1; then
  if [[ "$OSTYPE" == cygwin* ]]; then
    alias open='cygstart'
  elif [[ "$OSTYPE" == linux-android ]]; then
    alias open='termux-open'
  elif type explorer.exe >/dev/null 2>&1; then
    alias open='explorer.exe'
  elif type xdg-open >/dev/null 2>&1; then
    alias open='xdg-open'
  fi
fi

if command -v python3 >/dev/null 2>&1 && ! command -v python >/dev/null 2>&1; then
  alias python=python3
fi
if command -v pip3 >/dev/null 2>&1 && ! command -v pip >/dev/null 2>&1; then
  alias pip=pip3
fi
if ! command -v envsubst >/dev/null 2>&1; then
  alias envsubst="python -c 'import os,sys;[sys.stdout.write(os.path.expandvars(l)) for l in sys.stdin]'"
fi
if ! command -v hd >/dev/null 2>&1 && command -v hexdump >/dev/null 2>&1; then
  alias hd='hexdump -C'
fi

# Cross-platform support for clipboard commands (clipcopy/clippaste).
if [[ "$OSTYPE" == darwin* ]]; then
  alias clipcopy='pbcopy'
  alias clippaste='pbpaste'
elif [[ "$OSTYPE" == cygwin* ]]; then
  alias clipcopy='tee > /dev/clipboard'
  alias clippaste='cat /dev/clipboard'
elif type clip.exe >/dev/null 2>&1 && type powershell.exe >/dev/null 2>&1; then
  alias clipcopy='clip.exe'
  alias clippaste='powershell.exe -noprofile -command Get-Clipboard'
elif [[ -n "$WAYLAND_DISPLAY" ]] && type wl-copy >/dev/null 2>&1 && type wl-paste >/dev/null 2>&1; then
  alias clipcopy='wl-copy'
  alias clippaste='wl-paste'
elif [[ -n "$DISPLAY" ]] && type xclip >/dev/null 2>&1; then
  alias clipcopy='xclip -selection clipboard -in'
  alias clippaste='xclip -selection clipboard -out'
elif [[ -n "$DISPLAY" ]] && type xsel >/dev/null 2>&1; then
  alias clipcopy='xsel --clipboard --input'
  alias clippaste='xsel --clipboard --output'
fi

if type clipcopy >/dev/null 2>&1 && ! type pbcopy >/dev/null 2>&1; then
  alias pbcopy=clipcopy
  alias pbpaste=clippaste
fi

function copyfile() {
  if [[ -z "$1" ]]; then
    echo "Usage: copyfile <file>" >&2
    return 1
  fi
  if [[ ! -f "$1" ]]; then
    echo "copyfile: '$1' is not a valid file." >&2
    return 1
  fi
  cat "$1" | clipcopy
  printf '%s copied to clipboard.\n' "$1"
}

function copypath() {
  local file="${1:-.}"
  [[ $file = /* ]] || file="$PWD/$file"
  path/normalize "$file" | tr -d '\n' | clipcopy || return 1
  printf '%s copied to clipboard.\n' "$(path/normalize "$file")"
}

function sedi() {
  sed --version >/dev/null 2>&1 && sed -i -- "$@" || sed -i "" "$@"
}
