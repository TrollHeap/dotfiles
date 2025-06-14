source "$DOTFILES/tmux/scripts/create_win_tmux.sh"

if initialize_session "Config-Env"; then
  create_and_run_window "C-EnvFiles" "cd $DOTFILES/env-files/.config/env-files && nvim ."
  create_and_run_window "C-Scripts" "cd $DOTFILES/scripts/.config/scripts/ && nvim ."
  create_and_run_window "C-Zsh" "cd $DOTFILES/zsh && nvim .zshrc"
  create_and_run_window "C-Makefile" "cd $DOTFILES && nvim Makefile"

  select_window 1 || echo "Failed to select window 1"
fi

finalize_and_go_to_session || echo "Failed to finalize and go to session"
