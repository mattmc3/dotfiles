#
# startup file read in interactive login shells
#
# The following code helps us by optimizing the existing framework.
# This includes zcompile, zcompdump, etc.
#
# https://raw.githubusercontent.com/zimfw/zimfw/zsh-5.2/login_init.zsh
#

# Execute code that does not affect the current session in the background.
{
  # Compile the completion dump to increase startup speed.
  zcompdump="${XDG_CACHE_HOME:-$HOME/.cache}/prezto/zcompdump"
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zcompile "$zcompdump"
  fi
} &!

(
  local zdotdir dirs files d f
  zdotdir=${ZDOTDIR:-${HOME}}
  setopt local_options extended_glob
  autoload -U zrecompile

  dirs=(
    $ANTIBODY_HOME
    $ZGEN_DIR
    $ZSH
    $ZSH_CUSTOM
    $ZPREZTODIR
  )

  files=(
    ${ZSH_COMPDUMP:-$zdotdir/.zcompdump}
    $zdotdir/.zshrc
    $ZSH/oh-my-zsh.sh
  )

  for d in $dirs; do
    if [[ -d "$d" ]]; then
      for f in "$d"/**/*.zsh{,-theme}(.N); do
        zrecompile -pq "$f"
      done
    fi
  done

  for f in $files; do
    [[ ! -f "$f" ]] || zrecompile -pq "$f"
  done

  # cleanup
  find $HOME -type f -name "*.zwc.old" -maxdepth 1 -delete
  if [[ "$HOME" != "$ZDOTDIR" ]] && [[ -d "$ZDOTDIR" ]]; then
    find "$ZDOTDIR:A" -type f -name "*.zwc.old" -delete
  fi
) &!
