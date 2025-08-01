#!/bin/bash

weathertext="$HOME/.config/hypr/scripts/weather/weathertext"

while true; do
    weather=$(curl -s "https://wttr.in/$(curl -s https://ipinfo.io/json | grep -o '"city": *"[^"]*"' | cut -d '"' -f 4)?format=%25l%3A%20%25C%2C%20%25t")
    weather_len=${#weather}
    output=""
    i=0
    while [ $i -lt $weather_len ]; do
        if [ $i -eq 30 ]; then
            output="$output..."
            break
        fi
        char=$(printf "%s" "$weather" | cut -c $((i + 1)))
        output="$output$char"
        i=$((i + 1))
    done
    if [ "$output" != "" ]; then
        echo "$output" > "$weathertext"
    fi
    sleep 60
done
