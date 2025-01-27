source "$DOTFILES/tmux/utils/create_win_run.sh"

if initialize_session "CSharp"; then
  new_window "Docker" || echo "Failed to create Docker window"
  run_cmd "cd $HOME" || echo "Failed to run cd $HOME"
  run_cmd "lzd" || echo "Failed to run lzd"

  create_and_run_window "CSharp" "cd $WORK_SYSTEM/CSharp/ && nvim ."
  create_and_run_window "terminal" "cd $WORK_SYSTEM/CSharp"

  select_window 1 
fi

# Finalize and switch/attach to the session
finalize_and_go_to_session || echo "Failed to finalize and go to session"
