#!/bin/bash

# Helper function to initialize path
init_path() {
    local path=$1
    if [ -f "$path" ]; then
        source "$path" 2>>"$LOG_FILE/init_errors.log"
    else
        printf "Error: File '%s' not found!\n" "$path" | echo 2>> "$LOG_FILE/init_errors.log"
        exit 1
    fi
}
