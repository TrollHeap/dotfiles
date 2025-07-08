source "$DOTFILES/tmux/scripts/create_win_tmux.sh"

if initialize_session "01_Capsule"; then
    local CAPSULE="$HOME/Developer/capsule"

    create_and_run_window "cap-bash" "cd $CAPSULE/toolbox_v1 & nvim ."
    create_and_run_window "cap-shell" "cd $CAPSULE/toolbox_v1"
    create_and_run_window "cap-note" "cd $CAPSULE/notes && nvim info.md"

    select_window 1 || echo "Failed to select window 1"
fi

finalize_and_go_to_session || echo "Failed to finalize and go to session"
