source "$DOTFILES/tmux/scripts/create_win_tmux.sh"

SESSION_NAME="school-linux"

if initialize_session "$SESSION_NAME"; then
    NOTES="$HOME/Developer/L3_CNAM_OS"
    # Fenêtre shell classique
    create_and_run_window "primitiveOS" "cd $NOTES/exercise/primitiveos && nvim ."
    create_and_run_window "shell" "cd $NOTES/exercise/primitiveos"
    create_split_window "$SESSION_NAME" "notes_l3" "h" 50 \
        "cd $NOTES/weeks && nvim . " \
        "cd $NOTES && nvim roadmap.md"
    create_and_run_window "taskflow" "cd $HOME && cd Developer/taskflow-cli"

    select_window 1 || echo "Failed to select window 1"
fi

finalize_and_go_to_session || echo "Failed to finalize and go to session"
