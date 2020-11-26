if [[ -z $_Z_DATA ]]; then
  export _Z_DATA="${XDG_DATA_HOME:-$HOME/.local/share}"/.z
  [[ -f "$_Z_DATA" ]] || { mkdir -p "$_Z_DATA:h" && touch $_Z_DATA }
fi
source "$ZSH/plugins/z/z.plugin.zsh"
