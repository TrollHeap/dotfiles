#!/bin/bash

# === CONFIGURATION ===
PROFILE_NAME="c1rqdgcq.Default Profile"
PROFILE_DIR="$HOME/.zen/$PROFILE_NAME"
BACKUP_BASE="$HOME/zen-backups/full"

# === SÉLECTION INTERACTIVE D'UNE SAUVEGARDE ===
echo "📦 Sauvegardes disponibles :"
ls -1 "$BACKUP_BASE" | nl
read -rp "➡️  Numéro de la sauvegarde à restaurer : " SELECTION

BACKUP_FOLDER=$(ls -1 "$BACKUP_BASE" | sed -n "${SELECTION}p")
BACKUP_PATH="$BACKUP_BASE/$BACKUP_FOLDER"

# === VÉRIFICATIONS ===
if [ ! -d "$BACKUP_PATH" ]; then
  echo "❌ Sauvegarde introuvable : $BACKUP_PATH"
  exit 1
fi

if pgrep -f zen-browser > /dev/null; then
  echo "❌ Zen Browser est encore en cours. Ferme-le d'abord (ou pkill -f zen-browser)."
  exit 1
fi

# === SAUVEGARDE DU PROFIL ACTUEL ===
TS=$(date +%Y%m%d-%H%M%S)
CURRENT_BACKUP="$HOME/zen-backups/pre-restore/${PROFILE_NAME// /_}-$TS"
mkdir -p "$CURRENT_BACKUP"
cp -a "$PROFILE_DIR"/* "$CURRENT_BACKUP/"
echo "🔒 Profil actuel sauvegardé dans : $CURRENT_BACKUP"

# === RESTAURATION ===
rm -rf "$PROFILE_DIR"/*
cp -a "$BACKUP_PATH"/* "$PROFILE_DIR/"
echo "✅ Restauration terminée depuis : $BACKUP_PATH"
