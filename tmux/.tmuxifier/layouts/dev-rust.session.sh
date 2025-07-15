source "$DOTFILES/tmux/scripts/create_win_tmux.sh"

SESSION_NAME="Rust"

if initialize_session "$SESSION_NAME"; then
    local RUST="$HOME/Developer/WORKSPACE/COMPUTER_SCIENCE/SYSTEMS/Rust"
    local RUSTLING="$RUST/rustlings"

    create_split_window "$SESSION_NAME" "rustlings" "h" 50 \
        "cd $RUSTLING && rustlings" \
        "cd $RUSTLING/exercises && nvim ."

    create_split_window "$SESSION_NAME" "prac-rust" "h" 50 \
        "cd $RUST/get-dependencies/src && nvim ." \
        "cd $RUST/notes-rust && nvim ."

    create_and_run_window "sgpt-rust" "cd $RUST/spgt_rust && nvim ."
    select_window 1 || echo "Failed to select window 1"
fi

finalize_and_go_to_session || echo "Failed to finalize and go to session"
