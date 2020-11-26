source $ZSH/plugins/golang/golang.plugin.zsh

for _f in "${0:h}/functions"/*(.N); do
  autoload -Uz "$_f"
done
unset _f
