#!/usr/bin/env bash
set -euo pipefail

# === Config ===
INSTALL_DIR="$HOME/.local/opt/zenbrowser"
BIN_DIR="$HOME/.local/bin"
DESKTOP_FILE="$HOME/.local/share/applications/zenbrowser.desktop"
ICON_PATH="$HOME/dotfiles/env-files/.config/env-files/core/modules/app/icons/zen-icon.png"

APPIMAGE_URL="https://github.com/zen-browser/desktop/releases/download/1.14.7b/zen-x86_64.AppImage"
APPIMAGE_NAME="zenbrowser.AppImage"
APPIMAGE_PATH="$INSTALL_DIR/$APPIMAGE_NAME"
BIN_NAME="zen"
BIN_PATH="$BIN_DIR/$BIN_NAME"

# === Déjà installé ? ===
if [[ -x "$APPIMAGE_PATH" && -L "$BIN_PATH" ]]; then
    echo "[✓] Zen Browser déjà installé — skipping"
fi
# === Confirmation utilisateur ===
read -r -p "Installer Zen Browser ? [o/N] " confirm
if [[ "$confirm" =~ ^[OoYy]$ ]]; then
    echo "[*] Suppression ancienne installation de Zen Browser..."
    rm -rf "$INSTALL_DIR"
    rm -f "$BIN_PATH"
    rm -f "$DESKTOP_FILE"

    echo "[+] Téléchargement de Zen Browser (.AppImage)..."
    mkdir -p "$INSTALL_DIR" "$BIN_DIR"
    curl -L "$APPIMAGE_URL" -o "$APPIMAGE_PATH"

    echo "[+] Configuration des permissions..."
    chmod +x "$APPIMAGE_PATH"
    ln -sf "$APPIMAGE_PATH" "$BIN_PATH"

    echo "[+] Copie de l'icône..."
    cp "$ICON_PATH" "$INSTALL_DIR/zenbrowser.png"

    echo "[+] Création de $DESKTOP_FILE"
    mkdir -p "$(dirname "$DESKTOP_FILE")"
    cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Name=Zen Browser
GenericName=Zen
Comment=Minimal web browser
Exec=/home/binary/.local/bin/zen
Icon=/home/binary/.local/opt/zenbrowser/zenbrowser.png
Terminal=false
Type=Application
Categories=Network;WebBrowser;
StartupWMClass=zenbrowser
Keywords=zen;browser;web;minimal;
EOF

    command -v update-desktop-database >/dev/null && update-desktop-database "$HOME/.local/share/applications"
    echo "[✔] Zen Browser installé."
else
    echo "[✗] Installation Zen Browser ignorée."
fi
