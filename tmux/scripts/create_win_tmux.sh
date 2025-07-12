create_and_run_window() {
    local window_name="$1"
    local cmd="$2"
    if new_window "$window_name"; then
        run_cmd "$cmd" || echo "Running window '$cmd'"
    else
        echo "Failed to create $window_name window"
    fi
}

# --- Always require session_name as $1 ---
# create_split_window <session_name> <win_name> <split_type: h|v> <size> <cmd1> <cmd2>
create_split_window() {
    local session_name="$1"
    local win_name="$2"
    local split_type="$3"   # h or v
    local size="$4"         # percentage (ex: 60) or absolute (ex: 20)
    local cmd1="$5"
    local cmd2="$6"

    local win_id
    win_id=$(tmux new-window -P -F "#{window_id}" -n "$win_name" -t "$session_name:")

    tmux send-keys -t "$win_id".0 "$cmd1" C-m

    if [[ "$split_type" == "h" ]]; then
        tmux split-window -h -t "$win_id".0 -l "$size"
    else
        tmux split-window -v -t "$win_id".0 -l "$size"
    fi

    tmux send-keys -t "$win_id".1 "$cmd2" C-m
    tmux select-pane -t "$win_id".0
}

# create_complex_layout <session_name> <win_name> <cmd_a> <cmd_b> <cmd_c1> <cmd_c2>
create_complex_layout() {
    local session_name="$1"
    local win_name="$2"
    local cmd_a="$3"
    local cmd_b="$4"
    local cmd_c1="$5"
    local cmd_c2="$6"

    local win_id
    win_id=$(tmux new-window -P -F "#{window_id}" -n "$win_name" -t "$session_name:")

    tmux split-window -h -t "$win_id".0 -p 20
    tmux split-window -v -t "$win_id".0 -p 50
    tmux split-window -v -t "$win_id".1 -p 50

    tmux send-keys -t "$win_id".0 "$cmd_a" C-m
    tmux send-keys -t "$win_id".2 "$cmd_b" C-m
    tmux send-keys -t "$win_id".1 "$cmd_c1" C-m
    tmux send-keys -t "$win_id".3 "$cmd_c2" C-m

    tmux select-pane -t "$win_id".0
}

# create_three_panes_70_30v <session_name> <win_name> <cmd_a> <cmd_c1> <cmd_c2>
create_three_panes_70_30v() {
    local session_name="$1"
    local win_name="$2"
    local cmd_a="$3"
    local cmd_c1="$4"
    local cmd_c2="$5"

    local win_id
    win_id=$(tmux new-window -P -F "#{window_id}" -n "$win_name" -t "$session_name:")

    tmux split-window -h -t "$win_id".0 -p 30
    tmux split-window -v -t "$win_id".1 -p 50

    tmux send-keys -t "$win_id".0 "$cmd_a" C-m
    tmux send-keys -t "$win_id".1 "$cmd_c1" C-m
    tmux send-keys -t "$win_id".2 "$cmd_c2" C-m

    tmux select-pane -t "$win_id".0
}
