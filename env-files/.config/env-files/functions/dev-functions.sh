# Initialisation of Cargo if the env file exists
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# NVM initialization
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"


# Initialize Pyenv
if command -v pyenv >/dev/null; then
    eval "$(pyenv init --path)"
    eval "$(pyenv virtualenv-init -)"
fi
