source "$DOTFILES/tmux/scripts/create_win_tmux.sh"

if initialize_session "01_Capsule"; then
    create_and_run_window "cap-bash" "cd $HOME/Developer/capsule/toolbox_v1/src/scripts && nvim ."
    create_and_run_window "cap-shell" "cd $HOME/Developer/capsule/toolbox_v1/src/scripts/ "
    create_and_run_window "cap-note" "cd $HOME/Developer/capsules/notes && nvim info.md"

    select_window 1 || echo "Failed to select window 1"
fi

finalize_and_go_to_session || echo "Failed to finalize and go to session"
