#!/usr/bin/env bash

if ! systemctl is-active --quiet tor; then
    echo "[+] Démarrage du service Tor..."
    sudo systemctl start tor
else
    echo "[✓] Le service Tor est déjà actif."
fi

echo "[+] Lancement de Tor Browser..."
torbrowser-launcher
