#!/usr/bin/env bash
# Mode polling (status) ou action (connect/disconnect/toggle)

list_devices() {
    bluetoothctl devices | awk '{print $2 "|" substr($0, index($0,$3))}'
}

device_status() {
    mac="$1"
    info=$(bluetoothctl info "$mac")
    if echo "$info" | grep -q "Connected: yes"; then
        echo "connected"
    else
        echo "disconnected"
    fi
}

power_status() {
    bluetoothctl show | awk '/Powered:/ {print $2}'
}

case "$1" in
    --list)
        list_devices
        ;;
    --status)
        mac="$2"
        device_status "$mac"
        ;;
    --power)
        power_status
        ;;
    --toggle-power)
        state=$(power_status)
        if [[ "$state" == "yes" ]]; then
            bluetoothctl power off
        else
            bluetoothctl power on
        fi
        ;;
    --connect)
        mac="$2"
        bluetoothctl connect "$mac"
        ;;
    --disconnect)
        mac="$2"
        bluetoothctl disconnect "$mac"
        ;;
    *)
        echo "Usage: $0 [--list|--status <mac>|--power|--toggle-power|--connect <mac>|--disconnect <mac>]"
        exit 1
        ;;
esac
