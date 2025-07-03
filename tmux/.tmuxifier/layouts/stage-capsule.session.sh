source "$DOTFILES/tmux/scripts/create_win_tmux.sh"

if initialize_session "01_Capsule"; then
  create_and_run_window "Taskflow" "cd $HOME/Developer/taskflow-cli && taskcli"
  create_and_run_window "main" "cd $HOME/Developer/Capsule-work "

  select_window 1 || echo "Failed to select window 1"
fi

finalize_and_go_to_session || echo "Failed to finalize and go to session"
