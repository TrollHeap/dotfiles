source "$DOTFILES/tmux/utils/create_win_run.sh"

if initialize_session "Config"; then
  create_and_run_window "C-Vim" "cd $DOTFILES/nvim/.config/nvim/lua && nvim ."
  create_and_run_window "C-Scripts" "cd $DOTFILES/scripts/.config/scripts/ && nvim ."
  create_and_run_window "C-EnvFiles" "cd $DOTFILES/env-files/.config/env-files && nvim ."
  create_and_run_window "C-Zsh" "cd $DOTFILES/zsh && nvim .zshrc"
  create_and_run_window "C-Tmux" "cd $DOTFILES/tmux && nvim .tmux.conf"
  create_and_run_window "C-Tmuxifier" "cd $DOTFILES/tmux/.tmuxifier/layouts && nvim ."
  create_and_run_window "C-Wezterm" "cd $DOTFILES/wezterm/.config/wezterm && nvim ."

  select_window 1 || echo "Failed to select window 1"
fi

finalize_and_go_to_session || echo "Failed to finalize and go to session"
