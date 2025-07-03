source "$DOTFILES/tmux/scripts/create_win_tmux.sh"

if initialize_session "01_Capsule"; then
  create_and_run_window "capsule-bash" "cd $HOME/Developer/Capsule-work/toolbox_v1/src/scripts && .nvim"
  create_and_run_window "capsule-shell" "cd $HOME/Developer/Capsule-work/toolbox_v1/src/scripts/ "
  create_and_run_window "capsule-front" "cd $HOME/Developer/Capsule-work/toolbox_v1/"

  select_window 1 || echo "Failed to select window 1"
fi

finalize_and_go_to_session || echo "Failed to finalize and go to session"
