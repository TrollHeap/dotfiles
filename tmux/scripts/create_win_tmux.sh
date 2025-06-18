create_and_run_window() {
    local window_name=$1
    local cmd=$2

    if new_window "$window_name"; then
      run_cmd "$cmd" || echo " Running window '$cmd'"
    else
      echo "Failed to create $window_name window"
    fi
}

create_split_window() {
    local win_name="$1"
    local cmd1="$2"
    local cmd2="$3"
    local session_name=${SESSION:-00_ZSH}

    local win_id
    win_id=$(tmux new-window -P -F "#{window_id}" -n "$win_name" -t "$session_name:")

    tmux send-keys -t "$win_id".0 "$cmd1" C-m
    tmux split-window -h -t "$win_id"
    tmux send-keys -t "$win_id".1 "$cmd2" C-m
    tmux select-pane -t "$win_id".0
}
