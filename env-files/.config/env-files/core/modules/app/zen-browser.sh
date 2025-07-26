#!/usr/bin/env bash
set -euo pipefail

# === Config ===
APP_NAME="Zen Browser"
INSTALL_DIR="$HOME/.local/opt/zenbrowser"
BIN_DIR="$HOME/.local/bin"
DESKTOP_FILE="$HOME/.local/share/applications/zenbrowser.desktop"
ICON_PATH="$HOME/dotfiles/env-files/.config/env-files/core/modules/app/icons/zen-icon.png"

ARCHIVE_URL="https://example.com/zenbrowser.tar.xz"
ARCHIVE_NAME="zenbrowser.tar.xz"
BIN_NAME="zenbrowser"  # Nom du binaire principal (ajuste si besoin)
BIN_PATH="$INSTALL_DIR/$BIN_NAME"

# === Déjà installé ? ===
if [[ -x "$BIN_PATH" && -L "$BIN_DIR/$BIN_NAME" ]]; then
    echo "[✓] Zen Browser déjà installé — skipping"
else
    # === Confirmation utilisateur ===
    read -r -p "Installer Zen Browser ? [o/N] " confirm
    if [[ "$confirm" =~ ^[OoYy]$ ]]; then
        echo "[*] Suppression ancienne installation de Zen Browser..."
        rm -rf "$INSTALL_DIR"
        rm -f "$BIN_DIR/$BIN_NAME"
        rm -f "$DESKTOP_FILE"

        echo "[+] Téléchargement de Zen Browser (.tar.xz)..."
        mkdir -p "$INSTALL_DIR" "$BIN_DIR"
        curl -L "$ARCHIVE_URL" -o "/tmp/$ARCHIVE_NAME"

        echo "[+] Extraction..."
        tar -xf "/tmp/$ARCHIVE_NAME" -C "$INSTALL_DIR" --strip-components=1
        rm "/tmp/$ARCHIVE_NAME"

        echo "[+] Configuration des permissions..."
        chmod +x "$BIN_PATH"
        ln -sf "$BIN_PATH" "$BIN_DIR/$BIN_NAME"

        echo "[+] Copie de l'icône..."
        cp "$ICON_PATH" "$INSTALL_DIR/zenbrowser.png"

        echo "[+] Création de $DESKTOP_FILE"
        mkdir -p "$(dirname "$DESKTOP_FILE")"
        cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Name=$APP_NAME
Comment=Minimal web browser
Exec=$BIN_DIR/$BIN_NAME
Icon=$INSTALL_DIR/zenbrowser.png
Terminal=false
Type=Application
Categories=Network;WebBrowser;
StartupWMClass=zenbrowser
EOF

        command -v update-desktop-database >/dev/null && update-desktop-database "$HOME/.local/share/applications"
        echo "[✔] Zen Browser installé."
    else
        echo "[✗] Installation Zen Browser ignorée."
    fi
fi
