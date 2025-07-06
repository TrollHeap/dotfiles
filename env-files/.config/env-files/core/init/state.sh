#!/usr/bin/env bash

# ╭──────────────────────────────────────────────────────────────╮
# │ STATE - Bootstrap step tracking using a flat file            │
# ╰──────────────────────────────────────────────────────────────╯

source "$HOME/dotfiles/env-files/.config/env-files/config/env/globals_locals.env"

STATE_FILE="$C_BOOTSTRAP/.init_flags"

state::is_done() {
    local flag="$1"
    grep -qx "$flag" "$STATE_FILE" 2>/dev/null
}

state::mark_done() {
    local flag="$1"
    echo "$flag" >> "$STATE_FILE"
}
