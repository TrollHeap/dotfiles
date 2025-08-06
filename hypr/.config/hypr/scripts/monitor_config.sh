#!/usr/bin/env bash
set -euo pipefail

MONS=$(hyprctl monitors -j | jq '.[] | select(.disabled == false) | .name' | wc -l)
MODEL=$(hostnamectl | awk -F': ' '/Model/ {print $2}')

if [ "$MONS" -eq 1 ]; then
    # Un seul écran → auto
    hyprctl keyword monitor ",preferred,auto,1"
    exit 0
elif [[ "$MODEL" == "EliteMini Series" && "$MONS" -eq 2 ]]; then
    # Specific case for EliteMini Series with 2 monitors
    hyprctl keyword monitor "HDMI-A-1,2560x1440@120,440x0,1.25"
    hyprctl keyword monitor "DP-3,3440x1440@159,0x-1440,1"
    exit 0
else
    # Specific case for T480 with 2 monitors
    hyprctl keyword monitor "eDP-1,1920x1080@60,0x0,1"
    hyprctl keyword monitor "DP-1,3440x1440@100,-760x-1440,1"
    exit 0
fi
