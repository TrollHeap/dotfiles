#!/usr/bin/env bash

source "$DOTFILES/tmux/scripts/create_win_tmux.sh"

readonly SESSION_NAME="C_IDE"

if initialize_session "$SESSION_NAME"; then
    readonly NVIM="$DOTFILES/nvim/.config/nvim/lua"
    readonly HYPRLAND="$DOTFILES/hypr/.config/hypr"
    readonly WAYBAR="$DOTFILES/waybar/.config/waybar"
    readonly TMUXIFIER="$DOTFILES/tmux/.tmuxifier/layouts"
    readonly ALACRITTY="$DOTFILES/alacritty/.config/alacritty "

    create_split_window "$SESSION_NAME" "IDE" "h" 50 \
        "cd $NVIM && nvim ." \
        "cd $ALACRITTY && nvim alacritty.toml"

    create_split_window "$SESSION_NAME" "hyprland" "h" 50 \
        "cd $HYPRLAND && nvim ." \
        "cd $WAYBAR && nvim ."

    create_split_window "$SESSION_NAME" "tmux" "h" 50 \
        "cd $TMUXIFIER && nvim ." \
        "cd $DOTFILES/tmux && nvim .tmux.conf"

    select_window 1 || echo "Failed to select window 1"
fi

finalize_and_go_to_session || echo "Failed to finalize and go to session"

