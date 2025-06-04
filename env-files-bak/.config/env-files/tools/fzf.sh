#!/bin/bash

FZF_SHELL_DIR="$FZF_DIR/shell"

fzf::installed() {
    [[ -f "$FZF_DIR/install" ]]
}

fzf::setup_bindings() {
    [[ -f "$FZF_SHELL_DIR/completion.zsh" ]] && source "$FZF_SHELL_DIR/completion.zsh" 2>>"$LOG_FILE/init_errors.log"
    [[ -f "$FZF_SHELL_DIR/key-bindings.zsh" ]] && source "$FZF_SHELL_DIR/key-bindings.zsh" 2>>"$LOG_FILE/init_errors.log"
}
