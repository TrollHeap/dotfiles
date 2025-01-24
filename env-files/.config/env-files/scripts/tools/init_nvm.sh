#!/bin/bash

export NVM_DIR="$HOME/.nvm"

nvm_init(){
    if [ -s "$NVM_DIR/nvm.sh" ]; then
        source "$NVM_DIR/nvm.sh" 2>>"$LOG_FILE/init_errors.log"
        if ! command -v nvm >/dev/null; then
            printf "Error: NVM initialized, but 'nvm' command is not available.\n" >> "$LOG_FILE/init_errors.log"
        fi
    else
        printf "Warning: NVM is not installed or its initialization script is missing.\n" >> "$LOG_FILE/init_errors.log"
    fi
}

nvm_init
