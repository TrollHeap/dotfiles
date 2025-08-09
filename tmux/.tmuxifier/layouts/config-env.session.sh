#!/usr/bin/env bash

source "$DOTFILES/tmux/scripts/create_win_tmux.sh"

readonly SESSION_NAME="C_ENV"

if initialize_session "$SESSION_NAME"; then
    readonly ENVFILES="$DOTFILES/env-files/.config/env-files"
    readonly SCRIPTS="$DOTFILES/scripts/.config/scripts"
    readonly BASHRC="$DOTFILES/bash"

    create_split_window "$SESSION_NAME" "env-scripts" "h" 50 \
        "cd $ENVFILES && nvim ." \
        "cd $SCRIPTS && nvim ."

    create_split_window "$SESSION_NAME" "bash-make" "h" 50 \
        "cd $BASHRC && nvim .bashrc" \
        "cd $DOTFILES && nvim Makefile"

    select_window 1 || echo "Failed to select window 1"
fi

finalize_and_go_to_session || echo "Failed to finalize and go to session"
