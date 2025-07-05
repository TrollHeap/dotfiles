#!/usr/bin/env bash
set -euo pipefail

# --- Configuration (modifiable) ---
REMOTE="${1:-kde-binary}"                   # Nom du remote rclone
PROFILE="${2:-kde-binary}"                  # Nom du profil konsave (et du .knsv)
DEST="${HOME}/dotfiles/${PROFILE}.knsv"     # Chemin de destination local

# --- 1. Pull le fichier depuis le remote ---
echo "rclone: Pulling $PROFILE.knsv depuis le remote '$REMOTE'..."
rclone copy -P "${REMOTE}:/${PROFILE}.knsv" "$(dirname "$DEST")"

if [[ ! -f "$DEST" ]]; then
    echo "❌ Fichier $DEST non trouvé après le pull. Abandon."
    exit 1
fi

echo "Fichier récupéré : $(ls -lh "$DEST")"
echo

# --- 2. Import dans Konsave (remplace/ajoute ce profil) ---
echo "konsave: Import du profil $PROFILE..."
konsave -i "$DEST"

echo

# --- 3. Appliquer le profil ---
echo "konsave: Application du profil $PROFILE..."
konsave -a "$PROFILE"

echo
echo "✅ Profil Konsave '$PROFILE' PULLÉ et APPLIQUÉ."
echo "Tu dois te déconnecter/reconnecter pour voir tous les effets."
