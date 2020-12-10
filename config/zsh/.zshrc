# just execute 'ZPROF=1 zsh' to run 'zprof' to get the performance details
[[ $ZPROF -ne 1 ]] || zmodload zsh/zprof
alias zbench="for i in \$(seq 1 10); do; /usr/bin/time zsh -i -c exit; done"

# zprezto
export ZPREZTODIR="${ZDOTDIR:-$HOME}/.zprezto"
if [[ ! -d "$ZPREZTODIR" ]]; then
  git clone --depth=1 --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi
source "$ZPREZTODIR/init.zsh"

# OMZ
# source "${ZDOTDIR:-$HOME}/.zohmyzshrc"

# zshrc.d
for _f in $ZDOTDIR/zshrc.d/*.zsh(.N); do
  source $_f
done
unset _f

# local dotfiles
[[ -f ~/.config/dotfiles.local/zsh/zshrc.local.zsh ]] && . ~/.config/dotfiles.local/zsh/zshrc.local.zsh

[[ $ZPROF -ne 1 ]] || zprof
