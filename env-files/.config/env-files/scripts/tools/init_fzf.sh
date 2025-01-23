#!/bin/bash

FZF_DIR="$HOME/.fzf/shell"

# Initialiser FZF (Fuzzy Finder)
if [ -f "$FZF_DIR/completion.zsh" ]; then
    source "$FZF_DIR/completion.zsh" 2>>"$LOG_FILE/init_errors.log"
else
    printf "Error: FZF completion file not found at '%s'.\n" "$FZF_DIR/completion.zsh" | echo 2>> "$LOG_FILE/init_errors.log"
fi

if [ -f "$FZF_DIR/key-bindings.zsh" ]; then
    source "$FZF_DIR/key-bindings.zsh" 2>>"$LOG_FILE/init_errors.log"
else
    printf "Error: FZF key bindings file not found at '%s'.\n" "$FZF_DIR/key-bindings.zsh" | echo 2>> "$LOG_FILE/init_errors.log"
fi
