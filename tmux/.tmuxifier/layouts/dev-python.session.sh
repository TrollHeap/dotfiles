source "$DOTFILES/tmux/scripts/create_win_tmux.sh"

if initialize_session "python"; then
  new_window "Docker" || echo "Failed to create Docker window"
  run_cmd "cd $HOME" || echo "Failed to run cd $HOME"
  run_cmd "lzd" || echo "Failed to run lzd"

  create_and_run_window "Py" "cd $WORK_SYSTEM/Python"

  select_window 1 || echo "Failed to select window 1"
fi

finalize_and_go_to_session || echo "Failed to finalize and go to session"
