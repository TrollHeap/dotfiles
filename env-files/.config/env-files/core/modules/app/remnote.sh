#!/usr/bin/env bash
set -euo pipefail

# === Config ===
APP_NAME="RemNote"
INSTALL_DIR="$HOME/.local/opt/remnote"
BIN_DIR="$HOME/.local/bin"
DESKTOP_FILE="$HOME/.local/share/applications/remnote.desktop"
ICON_PATH="$HOME/dotfiles/env-files/.config/env-files/core/modules/app/icons/remnote-icon.png"
APPIMAGE_URL="https://backend.remnote.com/desktop/linux"
APPIMAGE_NAME="remnote.AppImage"
APPIMAGE_PATH="$INSTALL_DIR/$APPIMAGE_NAME"

# === Déjà installé ? ===
if [[ -x "$APPIMAGE_PATH" && -L "$BIN_DIR/remnote" ]]; then
    echo "[✓] RemNote déjà installé — skipping"
else
    # === Confirmation utilisateur ===
    read -r -p "Installer RemNote ? [o/N] " confirm
    if [[ "$confirm" =~ ^[OoYy]$ ]]; then
        echo "[*] Suppression ancienne installation de RemNote..."
        rm -rf "$INSTALL_DIR"
        rm -f "$BIN_DIR/remnote"
        rm -f "$DESKTOP_FILE"
        rm -rf "$HOME/.config/RemNote" "$HOME/.cache/RemNote" "$HOME/.local/share/RemNote"

        echo "[+] Téléchargement de RemNote AppImage..."
        mkdir -p "$INSTALL_DIR" "$BIN_DIR"
        cd "$INSTALL_DIR"
        curl -L "$APPIMAGE_URL" -o "$APPIMAGE_NAME"
        chmod +x "$APPIMAGE_NAME"
        ln -sf "$APPIMAGE_PATH" "$BIN_DIR/remnote"
        cp "$ICON_PATH" "$INSTALL_DIR/remnote.png"

        echo "[+] Création de $DESKTOP_FILE"
        mkdir -p "$(dirname "$DESKTOP_FILE")"
        cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Name=$APP_NAME
Comment=All-in-one thinking and learning tool
Exec=$BIN_DIR/remnote
Icon=$INSTALL_DIR/remnote.png
Terminal=false
Type=Application
Categories=Utility;Education;
StartupWMClass=remnote
EOF

        command -v update-desktop-database >/dev/null && update-desktop-database "$HOME/.local/share/applications"
        echo "[✔] RemNote installé."
    else
        echo "[✗] Installation RemNote ignorée."
    fi
fi

# ici, suite du script...
