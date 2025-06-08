#!/usr/bin/env bash

# ╭──────────────────────────────────────────────────────────────╮
# │ STATE - Bootstrap step tracking using a flat file            │
# ╰──────────────────────────────────────────────────────────────╯

STATE_FILE="$C_BOOTSTRAP/.init_flags"

state::is_done() {
  local flag="$1"
  grep -qx "$flag" "$STATE_FILE" 2>/dev/null
}

state::mark_done() {
  local flag="$1"
  echo "$flag" >> "$STATE_FILE"
}
