if initialize_session "Stats"; then

  new_window "Btop" || echo "Failed to create Btop window"
  run_cmd "btop" || echo "Failed to run 'btop'"

  new_window "Zsh" || echo "Failed to create Zsh window"
  #run_cmd "" || echo "Failed to run 'cd ~/.config/tmux && nvim .'"

  select_window 1 || echo "Failed to select window 1"
fi

finalize_and_go_to_session || echo "Failed to finalize and go to session"
