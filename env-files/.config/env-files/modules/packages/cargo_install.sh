#!/usr/bin/env bash

if command -v cargo>/dev/null; then
    echo "[+] Installing spotify_layer term..."
    cargo install spotify_player --locked

    echo "[+] Installing ripgrep..."
    cargo install ripgrep

    echo "[+] Installing fd-find..."
    cargo install fd-find

    echo "[+] Installing dust..."
    cargo install du-dust

    echo "[+] Installing zoxide..."
    cargo install zoxide --locked
fi
