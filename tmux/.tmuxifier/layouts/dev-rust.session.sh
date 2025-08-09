source "$DOTFILES/tmux/scripts/create_win_tmux.sh"

readonly SESSION_NAME="Rust"

if initialize_session "$SESSION_NAME"; then
    readonly RUST="$HOME/Developer/WORKSPACE/COMPUTER_SCIENCE/SYSTEMS/Rust"
    readonly RUSTLING="$RUST/rustlings"
    readonly L3CNAM="$HOME/Developer/L3_CNAM"

    create_split_window "$SESSION_NAME" "rustlings" "h" 50 \
        "cd $RUSTLING && rustlings" \
        "cd $RUSTLING/exercises && nvim ."

    create_split_window "$SESSION_NAME" "prac-rust" "h" 50 \
        "cd $RUST/get-dependencies/src && nvim ." \
        "cd $RUST/notes-rust && nvim ."

    #create_and_run_window "sgpt-rust" "cd $RUST/spgt_rust && nvim ."
    create_split_window "$SESSION_NAME" "notes_l3" "h" 50 \
        "cd $L3CNAM/weeks && nvim . " \
        "cd $L3CNAM && nvim roadmap.md"
    select_window 1 || echo "Failed to select window 1"
fi

finalize_and_go_to_session || echo "Failed to finalize and go to session"
