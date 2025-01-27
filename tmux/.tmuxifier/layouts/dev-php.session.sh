source "$DOTFILES/tmux/utils/create_win_run.sh"

if initialize_session "Php"; then
  new_window "Docker" || echo "Failed to create Docker window"
  run_cmd "cd $HOME" || echo "Failed to run cd $HOME"
  run_cmd "lzd" || echo "Failed to run lzd"

  create_and_run_window "PHP" "cd $WORK_WEB/PHP"
  create_and_run_window "Laravel" "cd $WORK_WEB/PHP/LARAVEL"

  select_window 1 || echo "Failed to select window 1"
fi

# Finalize and switch/attach to the session
finalize_and_go_to_session || echo "Failed to finalize and go to session"
