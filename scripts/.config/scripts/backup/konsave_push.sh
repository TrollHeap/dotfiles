#!/bin/zsh

set -euo pipefail

PROFILE="${1:-kde-binary}"  
DEST="${HOME}/${PROFILE}.knsv"

echo "konsave: Saving profile..."
konsave -s "$PROFILE" -f

echo "konsave: Exporting profile..."
konsave -e "$PROFILE"

if [[ ! -f "$DEST" ]]; then
  echo "❌ Export failed: $DEST not found"
  exit 1
fi

echo "rclone: Pushing $DEST to Google Drive..."
if rclone copy -P "$DEST" gdrive:/; then
  echo "rclone: Profile KDE Push to GoogleDrive successful!"
else
  echo "❌ rclone: Push failed!"
  exit 1
fi
