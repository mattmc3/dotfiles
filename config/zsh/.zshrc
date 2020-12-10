# just execute 'ZPROF=1 zsh' to run 'zprof' to get the performance details
[[ $ZPROF -ne 1 ]] || zmodload zsh/zprof
alias zbench="for i in \$(seq 1 10); do; /usr/bin/time zsh -i -c exit; done"

# zprezto
export ZPREZTODIR="${ZDOTDIR:-$HOME}/.zprezto"
if [[ ! -d "$ZPREZTODIR" ]]; then
  git clone --depth=1 --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi

# OMZ
export ZSH="${ZDOTDIR:-$HOME}/.oh-my-zsh"
if [[ ! -d "$ZSH" ]]; then
  git clone https://github.com/ohmyzsh/ohmyzsh.git --depth=1 "$ZSH"
fi

# custom
ZSH_CUSTOM="${ZDOTDIR:-$HOME}/.zsh_custom"
if [[ ! -d "$ZSH_CUSTOM" ]]; then
  git clone git@github.com:mattmc3/zsh_custom --recursive "$ZSH_CUSTOM"
fi

# use prezto
source "$ZPREZTODIR/init.zsh"

# zshrc.d
for _f in $ZDOTDIR/zshrc.d/*.zsh(.N); do
  source $_f
done
unset _f

# local dotfiles
[[ -f ~/.config/dotfiles.local/zsh/zshrc.local.zsh ]] && . ~/.config/dotfiles.local/zsh/zshrc.local.zsh

[[ $ZPROF -ne 1 ]] || zprof
