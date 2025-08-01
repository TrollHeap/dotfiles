#!/bin/bash

base_dir="$HOME/.config/eww/"
image_file="${base_dir}image.jpg"
default_cover="${base_dir}scripts/cover.png"
mkdir -p "$base_dir"

last_art_url=""

playerctl metadata -F -f '{{playerName}}|{{title}}|{{artist}}|{{mpris:artUrl}}|{{status}}|{{mpris:length}}' | \
    while IFS='|' read -r name title artist artUrl status length; do
    # Défensive : handle empty fields
    name="${name:-unknown}"
    title="${title:-}"
    artist="${artist:-}"
    status="${status:-}"
    length="${length:-}"

    # Durée en secondes + format lisible
    if [[ "$length" =~ ^[0-9]+$ ]]; then
        len_sec=$(( (length + 500000) / 1000000 ))
        lengthStr=$(printf "%d:%02d" $((len_sec / 60)) $((len_sec % 60)))
    else
        len_sec=""
        lengthStr=""
    fi

    # Gestion cover art – évite surécriture inutile
    if [[ "$artUrl" =~ ^https?:// ]]; then
        if [[ "$artUrl" != "$last_art_url" ]]; then
            tmp_image="${image_file}.tmp"
            if wget -q -O "$tmp_image" "$artUrl"; then
                mv "$tmp_image" "$image_file"
            else
                rm -f "$image_file"
                cp "$default_cover" "$image_file"
            fi
            last_art_url="$artUrl"
        fi
    else
        # Art par défaut pour fichiers locaux ou inconnu
        if [[ ! -f "$image_file" || "$artUrl" != "$last_art_url" ]]; then
            cp "$default_cover" "$image_file"
            last_art_url="$artUrl"
        fi
    fi

    jq -n -c \
        --arg name "$name" \
        --arg title "$title" \
        --arg artist "$artist" \
        --arg artUrl "$image_file" \
        --arg status "$status" \
        --arg length "$len_sec" \
        --arg lengthStr "$lengthStr" \
        '{name: $name, title: $title, artist: $artist, thumbnail: $artUrl, status: $status, length: $length, lengthStr: $lengthStr}'
done
