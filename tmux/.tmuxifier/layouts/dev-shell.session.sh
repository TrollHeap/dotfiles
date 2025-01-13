if initialize_session "Shell"; then
  new_window "Docker" || echo "Failed to create Docker window"
  run_cmd "cd $HOME" || echo "Failed to run cd $HOME"
  run_cmd "lzd" || echo "Failed to run lzd"

  new_window "shell_test" 
  run_cmd "cd ~/Developer/WORKSPACE/Shell/"
  run_cmd "nvim ." 

  new_window "terminal"
  run_cmd "cd ~/Developer/WORKSPACE/Shell/"

  # Optionally, select a window to be displayed first. 0 is the index of the first window.
  select_window 1 
fi

# Finalize and switch/attach to the session
finalize_and_go_to_session || echo "Failed to finalize and go to session"
