#!/bin/bash

# Function to duplicate the PATH variable
duplicate_path() {
    local old_path="$PATH"
    local new_path
    new_path=$(echo "$old_path" | tr ':' '\n' | awk '!seen[$0]++' | tr '\n' ':')
    export PATH="${new_path%:}"
}
