#!/bin/bash

zsh::installed() {
    command -v zsh &> /dev/null
}

zsh::set_default_shell() {
    local path
    path="$(which zsh)"
    [[ "$SHELL" != "$path" ]] && chsh -s "$path"
}
