source "$DOTFILES/tmux/scripts/create_win_tmux.sh"

SESSION_NAME="Toolbox"

if initialize_session "$SESSION_NAME"; then
    CAPSULE="$HOME/Developer/capsule"
    TOOLBOX="$CAPSULE/toolbox_v1"
    TOOLBOX_CORE="$TOOLBOX/src-tauri/src/core"

    create_and_run_window "toolbox" "cd $TOOLBOX_CORE && nvim ."
    create_and_run_window "toolshell" "cd $TOOLBOX_CORE"
    create_and_run_window "notes" "cd $CAPSULE/notes && nvim capsule.md"
fi

finalize_and_go_to_session || echo "Failed to finalize and go to session"
