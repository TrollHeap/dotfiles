source "$DOTFILES/tmux/scripts/create_win_tmux.sh"

SESSION_NAME="Capsule"

if initialize_session "$SESSION_NAME"; then
    CAPSULE="$HOME/Developer/capsule/"
    TOOLBOX="$CAPSULE/toolbox_v1"
    TOOLBOX_CORE="$TOOLBOX/src-tauri/src/core"

    create_and_run_window "toolbox" "cd $TOOLBOX_CORE && nvim ."
    # create_three_panes_70_30v "$SESSION_NAME" "toolbox" \
        #     "cd $TOOLBOX_CORE && nvim ." \
        #     "cd $TOOLBOX_CORE" \
        #     "cd $TOOLBOX && lzg"

    create_and_run_window "ssa-php" "cd $CAPSULE/SSA_web/ssapaysdemorlaix && nvim ."
    create_and_run_window "shell-ssa" "cd $CAPSULE/SSA_web/ssapaysdemorlaix && nvim ."
    create_split_window "$SESSION_NAME" "notes-capsule" "h" 50 \
        "cd $CAPSULE/notes && nvim info.md" \
        "cd $HOME && spotify_player"
    select_window 1 || echo "Failed to select window 1"
fi

finalize_and_go_to_session || echo "Failed to finalize and go to session"
