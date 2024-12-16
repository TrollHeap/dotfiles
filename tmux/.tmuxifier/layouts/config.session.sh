if initialize_session "Config"; then
  new_window "C-Vim" || echo "Failed to create C-Vim window"
  run_cmd "config && nvim ." || echo "Failed to run 'config && nvim .'"

  new_window "C-Tmux" || echo "Failed to create C-Tmux window"
  run_cmd "cd ~/dotfiles/tmux && nvim ." || echo "Failed to run 'cd ~/.config/tmux && nvim .'"

  new_window "C-Tmuxifier" || echo "Failed to create C-Tmuxifier window"
  run_cmd "cd ~/dotfiles/tmux/.tmuxifier/layouts && nvim ." || echo "Failed to run 'cd ~/.config/tmux/.tmuxifier/layouts && nvim .'"

  new_window "C-Envman" || echo "Failed to create C-Envman window"
  run_cmd "cd ~/dotfiles/env-files/.config/env-files && nvim ." || echo "Failed to run 'cd ~/.config/envman && nvim .'"

  new_window "C-Wezterm" || echo "Failed to create C-Wezterm window"
  run_cmd "cd ~/.config/wezterm && nvim ." || echo "Failed to run 'cd ~/.config/wezterm && nvim .'"

  select_window 1 || echo "Failed to select window 1"
fi

finalize_and_go_to_session || echo "Failed to finalize and go to session"
