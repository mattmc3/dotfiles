#
# zzz: Sleepily wait until the end, and then post-lib and post-zshrc.
#

# Sort and source conf files.
_rcs=($__zsh_config_dir/conf.d/*.{sh,zsh}(N))
for _rc in ${(o)_rcs}; do
  [[ ${_rc:t} == '~'* ]] && continue  # ignore tilde ~files
  source "$_rc"
done
unset _rc{,s}

# Init aliases.
[[ -r ${ZDOTDIR:-$HOME}/.zaliases ]] && source ${ZDOTDIR:-$HOME}/.zaliases

# Run local settings.
[[ -r ${ZDOTDIR:-$HOME}/.zshrc.local ]] && source ${ZDOTDIR:-$HOME}/.zshrc.local

# Run this at the very end.
function zshrc-post {
  # Init prompt.
  if (( $#prompt_themes == 0 )); then
    promptinit

    # Set prompt
    if [[ $TERM == dumb ]]; then
      prompt 'off'
    else
      local -a prompt_argv
      zstyle -a ':zephyr:plugin:prompt' 'theme' 'prompt_argv' \
        || prompt_argv=(off)
      prompt "$prompt_argv[@]"
    fi
  fi

  # Init completions.
  (( $+functions[compinit] )) || mycompinit

  # Finish profiling by calling zprof.
  [[ "$ZPROFRC" -eq 1 ]] && zprof
  [[ -v ZPROFRC ]] && unset ZPROFRC

  # Mark loaded.
  add-zsh-hook -d precmd zshrc-post
}

# Add hook so that zshrc-post is run in case the user forgot to.
autoload -Uz add-zsh-hook
add-zsh-hook precmd zshrc-post  # precmd is the only hook I know to use for this.
