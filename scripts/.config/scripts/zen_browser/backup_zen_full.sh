#!/bin/bash

# Nom du profil actif
PROFILE_NAME="c1rqdgcq.Default Profile"
PROFILE_PATH="$HOME/.zen/$PROFILE_NAME"

# Répertoire de sauvegarde horodaté
BACKUP_BASE="$HOME/zen-backups/full"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
BACKUP_DIR="$BACKUP_BASE/${PROFILE_NAME// /_}-$TIMESTAMP"

# Création du dossier
mkdir -p "$BACKUP_DIR"

# Vérification que Zen Browser est bien fermé
if pgrep -f zen-browser > /dev/null; then
  echo "❌ Zen Browser est encore en cours. Ferme-le d'abord (ou pkill -f zen-browser)."
  exit 1
fi

# Copie complète du profil
cp -a "$PROFILE_PATH"/* "$BACKUP_DIR/"

echo "✅ Sauvegarde complète du profil '$PROFILE_NAME' enregistrée dans :"
echo "   $BACKUP_DIR"
