fpath+=( /Users/mmcelheny/.cache/repos/mattmc3/zfunctions )
source /Users/mmcelheny/.cache/repos/mattmc3/zfunctions/zfunctions.plugin.zsh
fpath+=( /Users/mmcelheny/.cache/repos/belak/zsh-utils/editor )
source /Users/mmcelheny/.cache/repos/belak/zsh-utils/editor/editor.plugin.zsh
fpath+=( /Users/mmcelheny/.cache/repos/belak/zsh-utils/utility )
source /Users/mmcelheny/.cache/repos/belak/zsh-utils/utility/utility.plugin.zsh
fpath+=( /Users/mmcelheny/.cache/repos/zsh-users/zsh-completions/src )
fpath+=( /Users/mmcelheny/.cache/repos/belak/zsh-utils/completion )
source /Users/mmcelheny/.cache/repos/belak/zsh-utils/completion/completion.plugin.zsh
if ! (( $+functions[zsh-defer] )); then
  fpath+=( /Users/mmcelheny/.cache/repos/romkatv/zsh-defer )
  source /Users/mmcelheny/.cache/repos/romkatv/zsh-defer/zsh-defer.plugin.zsh
fi
fpath+=( /Users/mmcelheny/.cache/repos/zsh-users/zsh-autosuggestions )
zsh-defer source /Users/mmcelheny/.cache/repos/zsh-users/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
fpath+=( /Users/mmcelheny/.cache/repos/zdharma-continuum/fast-syntax-highlighting )
zsh-defer source /Users/mmcelheny/.cache/repos/zdharma-continuum/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
fpath+=( /Users/mmcelheny/.cache/repos/zsh-users/zsh-history-substring-search )
zsh-defer source /Users/mmcelheny/.cache/repos/zsh-users/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh
