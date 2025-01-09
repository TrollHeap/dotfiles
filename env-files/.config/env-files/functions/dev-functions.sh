# Initialisation of Cargo if the env file exists
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Initialize Pyenv
if command -v pyenv >/dev/null; then
    eval "$(pyenv init --path)"
    eval "$(pyenv virtualenv-init -)"
fi
