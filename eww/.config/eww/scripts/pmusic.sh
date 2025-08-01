#!/bin/bash

playerctl metadata -F -f '{{playerName}}|{{position}}|{{mpris:length}}' | \
    while IFS='|' read -r player position length; do
    # Défensive : si vides ou non numériques
    if [[ "$position" =~ ^[0-9]+$ ]]; then
        pos_sec=$(( (position + 500000) / 1000000 ))
        pos_str=$(printf "%d:%02d" $((pos_sec / 60)) $((pos_sec % 60)))
    else
        pos_sec=""
        pos_str=""
    fi
    jq -n -c \
        --arg position "$pos_sec" \
        --arg positionStr "$pos_str" \
        '{position: $position, positionStr: $positionStr}'
done
