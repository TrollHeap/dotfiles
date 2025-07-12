#!/usr/bin/env bash

source "$DOTFILES/tmux/scripts/create_win_tmux.sh"

SESSION_NAME="C_IDE"

if initialize_session "$SESSION_NAME"; then
    local NVIM="$DOTFILES/nvim/.config/nvim/lua"
    local TMUXIFIER="$DOTFILES/tmux/.tmuxifier/layouts"
    local ALACRITTY="$DOTFILES/alacritty/.config/alacritty "

    create_split_window "$SESSION_NAME" "IDE" "h" 50 \
        "cd $NVIM && nvim ." \
        "cd $ALACRITTY && nvim alacritty.toml"

    create_and_run_window "tmuxifier" "cd $TMUXIFIER && nvim ."
    create_and_run_window "tmux" "cd $DOTFILES/tmux && nvim .tmux.conf"

    select_window 1 || echo "Failed to select window 1"
fi

finalize_and_go_to_session || echo "Failed to finalize and go to session"

