# ─── Global Encoding ────────────────────────────────────────────────────────────
# Source shared variables for shell and scripts
[[ -f "$HOME/dotfiles/env-files/.config/env-files/core/exports.sh" ]] && source "$HOME/dotfiles/env-files/.config/env-files/core/exports.sh"

# --- Load environment variable definitions ---

export DOTFILES="$HOME/dotfiles"
export ROOT_ENV="$DOTFILES/env-files/.config/env-files"

# Load env vars (paths, tools, etc)
ENV_VAR_FILE="$ROOT_ENV/config/variables.env"
if [ -r "$ENV_VAR_FILE" ]; then
  source "$ENV_VAR_FILE"
else
  echo "⚠️  Could not source: $ENV_VAR_FILE" >&2
fi

