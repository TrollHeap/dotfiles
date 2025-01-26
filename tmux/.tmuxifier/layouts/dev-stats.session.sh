source "$DOTFILES/tmux/utils/create_win_run.sh"

if initialize_session "Stats"; then

  create_and_run_window "BTop" "btop"
  create_and_run_window "term" "cd"

  select_window 1 || echo "Failed to select window 1"
fi

finalize_and_go_to_session || echo "Failed to finalize and go to session"
