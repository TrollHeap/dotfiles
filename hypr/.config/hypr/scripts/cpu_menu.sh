#!/bin/bash

choice=$(printf "performance\npowersave\nstatus" | rofi -dmenu -p "CPU governor")

case "$choice" in
    performance)
        sudo cpupower frequency-set -g performance
        notify-send "CPU governor: $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)"
        ;;
    powersave)
        sudo cpupower frequency-set -g powersave
        notify-send "CPU governor: $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)"
        ;;
    status)
        notify-send "CPU governor: $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)"
        ;;
esac
