REPO_HOME="${XDG_CACHE_HOME:-$HOME/.cache}/bash/repos"
typeset -a repos
repos=(
  akinomyoga/ble.sh
  romkatv/gitstatus
  #bash-it/bash-it
  #ohmybash/oh-my-bash
  wez/wezterm
)
for _repo in "${repos[@]}"; do
  [[ -d "$REPO_HOME/$_repo" ]] && continue
  echo "Cloning ${_repo}..."
  git clone --quiet --depth 1 --recurse-submodules --shallow-submodules \
    https://github.com/$_repo "$REPO_HOME/$_repo" &
done
wait
unset _repo
