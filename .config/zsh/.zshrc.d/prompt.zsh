setopt TRANSIENT_RPROMPT
if [[ -n "$STARSHIP_SHELL" ]]; then
  export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/${STARSHIP_SHELL}.toml"
fi
