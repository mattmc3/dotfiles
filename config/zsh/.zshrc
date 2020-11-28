# just execute 'ZPROF=1 zsh' to run 'zprof' to get the performance details
[[ $ZPROF -ne 1 ]] || zmodload zsh/zprof
alias zbench="for i in \$(seq 1 10); do; /usr/bin/time zsh -i -c exit; done"

# zprezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# OMZ
# source "${ZDOTDIR:-$HOME}/.zohmyzshrc"

# local dotfiles
[[ -f ~/.config/dotfiles.local/zsh/zshrc.local.zsh ]] && . ~/.config/dotfiles.local/zsh/zshrc.local.zsh

[[ $ZPROF -ne 1 ]] || zprof
