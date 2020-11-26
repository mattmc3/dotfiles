for _f in "${0:h}/functions"/*(.N); do
  autoload -Uz "$_f"
done
unset _f
