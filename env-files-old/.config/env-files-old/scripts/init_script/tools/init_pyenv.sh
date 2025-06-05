#!/bin/bash

# Initialize Pyenv (Python Version Manager)
pyenv_init(){
    if command -v pyenv >/dev/null; then
        eval "$(pyenv init --path)" 2>>"$LOG_FILE/init_errors.log"
        eval "$(pyenv virtualenv-init -)" 2>>"$LOG_FILE/init_errors.log"
    else
        printf "Warning: Pyenv is not installed.\n" | echo 2>> "$LOG_FILE/init_errors.log"
    fi
}

pyenv_init
