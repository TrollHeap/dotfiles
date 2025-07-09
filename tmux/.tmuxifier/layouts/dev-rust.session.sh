source "$DOTFILES/tmux/scripts/create_win_tmux.sh"

if initialize_session "rust"; then
    create_and_run_window "Rusting" "cd-rust && cd rustlings && nvim ."
    create_and_run_window "shell-rustlings" "cd-rust && cd rustlings"
    create_and_run_window "test-rust" "cd-rust && cd get-dependencies/src nvim ."
    create_and_run_window "notes" "cd-rust && cd notes-rust && nvim ."
    select_window 1 || echo "Failed to select window 1"
fi

finalize_and_go_to_session || echo "Failed to finalize and go to session"
