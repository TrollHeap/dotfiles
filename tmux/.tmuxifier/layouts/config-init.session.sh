source "$DOTFILES/tmux/scripts/create_win_tmux.sh"

if initialize_session "Zsh"; then
  # Fenêtre SPLIT (deux panes : btop / cat Makefile)
  create_split_window "btop-shell" \
    "cd \$HOME && btop" \
    "cd \$DOTFILES && cat Makefile"

  # Fenêtre shell classique
  create_and_run_window "shell" "cd \$HOME"

  select_window 1 || echo "Failed to select window 1"
fi

finalize_and_go_to_session || echo "Failed to finalize and go to session"
