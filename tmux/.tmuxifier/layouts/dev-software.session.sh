source "$DOTFILES/tmux/scripts/create_win_tmux.sh"

readonly SESSION_NAME="Shell"

if initialize_session "$SESSION_NAME"; then
    new_window "Docker" || echo "Failed to create Docker window"
    run_cmd "cd $HOME" || echo "Failed to run cd $HOME"
    run_cmd "lzd" || echo "Failed to run lzd"

    create_and_run_window "C" "cd $WORK_SYSTEM/C_CPP && nvim ."
    create_and_run_window "shell" "cd $WORK_DEVOPS"
    create_and_run_window "term_shell" "cd $WORK_DEVOPS"

    select_window 1
fi

finalize_and_go_to_session || echo "Failed to finalize and go to session"
