create_and_run_window() {
    local window_name=$1
    local cmd=$2

    if new_window "$window_name"; then
      run_cmd "$cmd" || echo "Failed to run '$cmd'"
    else
      echo "Failed to create $window_name window"
    fi
}
