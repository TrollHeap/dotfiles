#!/usr/bin/env zsh
set -euo pipefail

# === Config ===
APP_NAME="RemNote"
INSTALL_DIR="$HOME/.local/opt/remnote"
BIN_DIR="$HOME/.local/bin"
DESKTOP_FILE="$HOME/.local/share/applications/remnote.desktop"
ICON_PATH="$ROOT_SCRIPTS/appli/remnote/remnote-icon.png"
APPIMAGE_URL="https://backend.remnote.com/desktop/linux"
APPIMAGE_NAME="remnote.AppImage"

# === Préparation des répertoires ===
mkdir -p "$INSTALL_DIR" "$BIN_DIR"
cd "$INSTALL_DIR"

# === Télécharger l’AppImage ===
echo "[+] Téléchargement de RemNote AppImage..."
curl -L "$APPIMAGE_URL" -o "$APPIMAGE_NAME"

# === Rendre exécutable ===
chmod +x "$APPIMAGE_NAME"

# === Symlink vers ~/.local/bin ===
ln -sf "$INSTALL_DIR/$APPIMAGE_NAME" "$BIN_DIR/remnote"

# === Copier l'icône personnalisée ===
cp "$ICON_PATH" "$INSTALL_DIR/remnote.png"

# === Créer le fichier .desktop ===
echo "[+] Création de $DESKTOP_FILE"
# === Créer le fichier .desktop ===
mkdir -p "$(dirname "$DESKTOP_FILE")"
echo "[+] Création de $DESKTOP_FILE"
cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Name=RemNote
Comment=All-in-one thinking and learning tool
Exec=$BIN_DIR/remnote
Icon=$INSTALL_DIR/remnote.png
Terminal=false
Type=Application
Categories=Utility;Education;
StartupWMClass=remnote
EOF

# === Mise à jour de la base XDG ===
command -v update-desktop-database >/dev/null && update-desktop-database "$HOME/.local/share/applications"

echo "[✔] RemNote installé. Lance via 'remnote' ou le menu d'applications."

