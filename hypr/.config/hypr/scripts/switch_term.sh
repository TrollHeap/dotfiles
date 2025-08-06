#!/usr/bin/env bash
set -euo pipefail

MODEL=$(hostnamectl | awk -F': ' '/Model/ {print $2}')

if [[ "$MODEL" == "EliteMini Series" ]]; then
    TERMINAL=kitty
elif [[ "$MODEL" == "ThinkPad T480" ]]; then
    TERMINAL=alacritty
fi

# Écrit la ligne dans un fichier temporaire ou inclut via source
echo "\$terminal = $TERMINAL" > ~/.config/hypr/terminal.conf
