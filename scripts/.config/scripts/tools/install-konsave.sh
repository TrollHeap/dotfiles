#!/usr/bin/env bash
# ╭────────────────────────────────────────────────────────────────────────╮
# │ KONSAVE INSTALLER – FOR KDE - Debian/Ubuntu & Fedora/RHEL              │
# ╰────────────────────────────────────────────────────────────────────────╯

if command -v python3 &>/dev/null; then
  if python3 -m pip --version &>/dev/null; then
    python3 -m pip install --user konsave
  else
    echo "[-] pip non trouvé, installation via dnf..."
    sudo dnf install -y python3-pip
    python3 -m pip install --user konsave
  fi
else
  echo "❌ python3 absent du système — installation interrompue."
  exit 1
fi
