if [[ ! -d "${0:h}/external" ]]; then
  git clone --depth=1 --recursive https://github.com/zsh-users/zsh-completions.git "${0:h}/external"
fi
source "${0:h}/external/zsh-completions.plugin.zsh"
