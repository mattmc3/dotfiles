#!/usr/bin/env bash
# shellcheck disable=SC2002

# clipcopy/clippaste
detect_clipboard() {
  if [[ "${OSTYPE}" == darwin* ]] && command -v pbcopy >/dev/null && command -v pbpaste >/dev/null; then
    function clipcopy() { cat "${1:-/dev/stdin}" | pbcopy; }
    function clippaste() { pbpaste; }
  elif [[ "${OSTYPE}" == cygwin* ]] || [[ "${OSTYPE}" == msys* ]]; then
    function clipcopy() { cat "${1:-/dev/stdin}" > /dev/clipboard; }
    function clippaste() { cat /dev/clipboard; }
  elif command -v clip.exe >/dev/null && command -v powershell.exe >/dev/null; then
    function clipcopy() { cat "${1:-/dev/stdin}" | clip.exe; }
    function clippaste() { powershell.exe -noprofile -command Get-Clipboard; }
  elif [ -n "${WAYLAND_DISPLAY:-}" ] && command -v wl-copy >/dev/null && command -v wl-paste >/dev/null; then
    function clipcopy() { cat "${1:-/dev/stdin}" | wl-copy &>/dev/null; }
    function clippaste() { wl-paste --no-newline; }
  elif [ -n "${DISPLAY:-}" ] && command -v xsel >/dev/null; then
    function clipcopy() { cat "${1:-/dev/stdin}" | xsel --clipboard --input; }
    function clippaste() { xsel --clipboard --output; }
  elif [ -n "${DISPLAY:-}" ] && command -v xclip >/dev/null; then
    function clipcopy() { cat "${1:-/dev/stdin}" | xclip -selection clipboard -in &>/dev/null; }
    function clippaste() { xclip -out -selection clipboard; }
  elif command -v lemonade >/dev/null; then
    function clipcopy() { cat "${1:-/dev/stdin}" | lemonade copy; }
    function clippaste() { lemonade paste; }
  elif command -v doitclient >/dev/null; then
    function clipcopy() { cat "${1:-/dev/stdin}" | doitclient wclip; }
    function clippaste() { doitclient wclip -r; }
  elif command -v win32yank >/dev/null; then
    function clipcopy() { cat "${1:-/dev/stdin}" | win32yank -i; }
    function clippaste() { win32yank -o; }
  elif [[ $OSTYPE == linux-android* ]] && command -v termux-clipboard-set >/dev/null; then
    function clipcopy() { cat "${1:-/dev/stdin}" | termux-clipboard-set; }
    function clippaste() { termux-clipboard-get; }
  elif [ -n "${TMUX:-}" ] && command -v tmux >/dev/null; then
    function clipcopy() { tmux load-buffer "${1:--}"; }
    function clippaste() { tmux save-buffer -; }
  else
    _retry_clipboard_detection_or_fail() {
      local clipcmd="${1}"; shift
      if detect_clipboard; then
        "${clipcmd}" "$@"
      else
        echo "${clipcmd}: Platform $OSTYPE not supported or xclip/xsel not installed" >&2
        return 1
      fi
    }
    function clipcopy() { _retry_clipboard_detection_or_fail clipcopy "$@"; }
    function clippaste() { _retry_clipboard_detection_or_fail clippaste "$@"; }
    return 1
  fi
}

function clipcopy() {
  unset -f clipcopy
  detect_clipboard || true
  clipcopy "$@"
}

function clippaste() {
  unset -f clippaste
  detect_clipboard || true
  clippaste "$@"
}
