# borrow some goodies from Oh-My-Zsh

# Universal clipboard commands
function detect-clipboard {
  ##? clipcopy - Copy data to clipboard
  ##? Usage:
  ##?  <command> | clipcopy    - copies stdin to clipboard
  ##?  clipcopy <file>         - copies a file's contents to clipboard
  ##?
  ##? clippaste - Paste data from clipboard to stdout
  ##? Usage:
  ##?   clippaste   - writes clipboard's contents to stdout
  ##?   clippaste | <command>    - pastes contents and pipes it to another process
  ##?   clippaste > <file>       - paste contents to a file
  ##?
  ##? Examples:
  ##?   # Pipe to another process
  ##?   clippaste | grep foo
  ##?
  ##?   # Paste to a file
  ##?   clippaste > file.txt

  emulate -L zsh

  # Universal clipboard commands with clipcopy/clippaste
  # https://github.com/neovim/neovim/blob/e682d799fa3cf2e80a02d00c6ea874599d58f0e7/runtime/autoload/provider/clipboard.vim#L55-L121
  if [[ "${OSTYPE}" == darwin* ]] && (( ${+commands[pbcopy]} )) && (( ${+commands[pbpaste]} )); then
    function clipcopy { cat "${1:-/dev/stdin}" | pbcopy; }
    function clippaste { pbpaste; }
  elif [[ "${OSTYPE}" == (cygwin|msys)* ]]; then
    function clipcopy { cat "${1:-/dev/stdin}" > /dev/clipboard; }
    function clippaste { cat /dev/clipboard; }
  elif (( $+commands[clip.exe] )) && (( $+commands[powershell.exe] )); then
    function clipcopy { cat "${1:-/dev/stdin}" | clip.exe; }
    function clippaste { powershell.exe -noprofile -command Get-Clipboard; }
  elif [ -n "${WAYLAND_DISPLAY:-}" ] && (( ${+commands[wl-copy]} )) && (( ${+commands[wl-paste]} )); then
    function clipcopy { cat "${1:-/dev/stdin}" | wl-copy &>/dev/null &|; }
    function clippaste { wl-paste; }
  elif [ -n "${DISPLAY:-}" ] && (( ${+commands[xsel]} )); then
    function clipcopy { cat "${1:-/dev/stdin}" | xsel --clipboard --input; }
    function clippaste { xsel --clipboard --output; }
  elif [ -n "${DISPLAY:-}" ] && (( ${+commands[xclip]} )); then
    function clipcopy { cat "${1:-/dev/stdin}" | xclip -selection clipboard -in &>/dev/null &|; }
    function clippaste { xclip -out -selection clipboard; }
  elif (( ${+commands[lemonade]} )); then
    function clipcopy { cat "${1:-/dev/stdin}" | lemonade copy; }
    function clippaste { lemonade paste; }
  elif (( ${+commands[doitclient]} )); then
    function clipcopy { cat "${1:-/dev/stdin}" | doitclient wclip; }
    function clippaste { doitclient wclip -r; }
  elif (( ${+commands[win32yank]} )); then
    function clipcopy { cat "${1:-/dev/stdin}" | win32yank -i; }
    function clippaste { win32yank -o; }
  elif [[ $OSTYPE == linux-android* ]] && (( $+commands[termux-clipboard-set] )); then
    function clipcopy { cat "${1:-/dev/stdin}" | termux-clipboard-set; }
    function clippaste { termux-clipboard-get; }
  elif [ -n "${TMUX:-}" ] && (( ${+commands[tmux]} )); then
    function clipcopy { tmux load-buffer "${1:--}"; }
    function clippaste { tmux save-buffer -; }
  else
    return 1
  fi
}

function _try_clipboard_detection_or_fail() {
  local clipcmd="${1}"; shift
  if detect-clipboard; then
    "${clipcmd}" "$@"
  else
    print "${clipcmd}: Platform $OSTYPE not supported or xclip/xsel not installed" >&2
    return 1
  fi
}
function clipcopy() { _try_clipboard_detection_or_fail clipcopy "$@"; }
function clippaste() { _try_clipboard_detection_or_fail clippaste "$@"; }

# Universal open command.
(( ${+commands[open]} )) ||
function open() {
  local open_cmd

  # define the open command
  case "$OSTYPE" in
    cygwin*)  open_cmd='cygstart' ;;
    linux*)   [[ "$(uname -r)" != *icrosoft* ]] && open_cmd='nohup xdg-open' || {
                open_cmd='cmd.exe /c start ""'
                [[ -e "$1" ]] && { 1="$(wslpath -w "${1:a}")" || return 1 }
              } ;;
    msys*)    open_cmd='start ""' ;;
    *)        echo "Platform $OSTYPE not supported"
              return 1
              ;;
  esac

  ${=open_cmd} "$@" &>/dev/null
}
