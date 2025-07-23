source "$DOTFILES/tmux/scripts/create_win_tmux.sh"

SESSION_NAME="Capsule-php"

if initialize_session "$SESSION_NAME"; then
    CAPSULE="$HOME/Developer/capsule"

    create_and_run_window "backphp" "cd $CAPSULE/SSA_web/ssapaysdemorlaix && nvim ."
    create_and_run_window "shellphp" "cd $CAPSULE/SSA_web/ssapaysdemorlaix"
    create_and_run_window "notes" "cd $CAPSULE/notes && nvim capsule.md"
    select_window 1 || echo "Failed to select window 1"
fi

finalize_and_go_to_session || echo "Failed to finalize and go to session"
