#!/usr/bin/env bash

if command -v cargo>/dev/null; then
    echo "[+] Installing spotify_layer term..."
    cargo install spotify_player --locked
fi
