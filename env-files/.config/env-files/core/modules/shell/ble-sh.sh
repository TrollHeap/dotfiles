#!/usr/bin/env bash

set -e  # stop on error

BLE_REPO="https://github.com/akinomyoga/ble.sh.git"
BLE_PREFIX="$HOME/.local"
BLE_DIR="$BLE_PREFIX/share/ble.sh"
BLE_TEMP="$HOME/.cache/ble.sh-clone"

if [[ -d "$BLE_DIR" ]]; then
    echo "[✓] ble.sh déjà installé — skipping"
else
    echo "[+] Clonage temporaire de ble.sh..."
    cd "$HOME"
    # Si un ancien clone partiel existe → clean
    rm -rf "$BLE_TEMP"
    git clone --recursive --depth 1 --shallow-submodules "$BLE_REPO" "$BLE_TEMP"

    echo "[+] Installation via make..."
    make -C "$BLE_TEMP" install PREFIX="$BLE_PREFIX"

    echo "[+] Nettoyage du dépôt temporaire"
    rm -rf "$BLE_TEMP"
fi
