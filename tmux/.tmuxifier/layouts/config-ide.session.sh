source "$DOTFILES/tmux/scripts/create_win_tmux.sh"

if initialize_session "03_C_IDE"; then
  create_and_run_window "C-Vim" "cd $DOTFILES/nvim/.config/nvim/lua && nvim ."
  create_and_run_window "C-Tmux" "cd $DOTFILES/tmux && nvim .tmux.conf"
  create_and_run_window "C-Tmuxifier" "cd $DOTFILES/tmux/.tmuxifier/layouts && nvim ."
  create_and_run_window "C-Alacritty" "cd $DOTFILES/alacritty/.config/alacritty && nvim alacritty.toml"

  select_window 1 || echo "Failed to select window 1"
fi

finalize_and_go_to_session || echo "Failed to finalize and go to session"
