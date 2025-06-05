#!/usr/bin/env bash
set -euo pipefail

STATE_FILE="$C_LOGS/flags/.init_flags"

state::is_done() {
    local flag="$1"
    grep -qx "$flag" "$STATE_FILE" 2>/dev/null
}

state::mark_done() {
    local flag="$1"
    echo "$flag" >> "$STATE_FILE"
}
