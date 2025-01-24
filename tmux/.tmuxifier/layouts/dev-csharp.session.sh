if initialize_session "CSharp"; then
  new_window "Docker" || echo "Failed to create Docker window"
  run_cmd "cd $HOME" || echo "Failed to run cd $HOME"
  run_cmd "lzd" || echo "Failed to run lzd"

  new_window "CSharp" || echo "Failed to create CSharp window"
  run_cmd "cd $HOME/Developer/WORKSPACE/CSharp/" || echo "Failed to run cd CSharp"

  new_window "terminal" || echo "Failed to create CSharp window"
  run_cmd "cd $HOME/Developer/WORKSPACE/CSharp/" || echo "Failed to create CSharp window"

  # Optionally, select a window to be displayed first. 0 is the index of the first window.
  select_window 1 
fi

# Finalize and switch/attach to the session
finalize_and_go_to_session || echo "Failed to finalize and go to session"
