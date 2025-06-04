[[ -f "$HOME/.config/env-files/bootstrap/core/load_env.sh" ]] && source "$HOME/.config/env-files/bootstrap/core/load_env.sh"

if [ -r "$C_BOOTSTRAP/init.sh" ]; then
  source "$C_BOOTSTRAP/init.sh"
fi
