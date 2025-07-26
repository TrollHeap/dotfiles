#!/usr/bin/env bash

source "$ROOT_ENV/main.sh"
source "$ROOT_ENV/core/lib/state.sh"

WORKSPACE_FLAG="workspace"
DEVELOPER_FLAG="Developer"

# --- Check si déjà fait ---
if state::is_done "$WORKSPACE_FLAG"; then
    echo "[✓] Workspace already initialized — skipping"
    exit 0
fi

# --- Demande à l'utilisateur ---
read -r -p "Souhaitez-vous initialiser le workspace dans \$HOME/$DEVELOPER_FLAG ? [o/N] " confirm
if [[ ! "$confirm" =~ ^[OoYy]$ ]]; then
    echo "[✗] Initialisation annulée."
    exit 1
fi

# --- Création du workspace ---
cd "$HOME" || exit 1
mkdir -p "$DEVELOPER_FLAG"
cd "$HOME/$DEVELOPER_FLAG" || exit 1

WORKSPACE="$PWD"

echo "[+] Setting up WORKSPACE at: $WORKSPACE"
mkdir -p "$WORKSPACE"
cd "$WORKSPACE" || exit 1

# --- ACTIVE ---
echo "→ Création des dossiers ACTIVE/INBOX/repository..."
mkdir -p \
    ACTIVE/INBOX/{42_POOL,Anglais,cnam-l3,CS_Projects,leetcode,OPEN_SOURCE,shell_exo} \
    ACTIVE/PROJECTS/{Active,SideProject} \
    ACTIVE/TASKS

# --- ARCHIVED ---
echo "→ Création des dossiers ARCHIVED/ (hors archives et images)..."
mkdir -p ARCHIVED/ARCHIVED_2023
mkdir -p ARCHIVED/portfolioimage

# --- COMPUTER_SCIENCE ---
echo "→ Création des dossiers COMPUTER_SCIENCE/ALGORITHMS, SYSTEMS, WEB, etc..."
mkdir -p \
    COMPUTER_SCIENCE/ALGORITHMS \
    COMPUTER_SCIENCE/CLOUD \
    COMPUTER_SCIENCE/DESIGNS_PATTERN \
    COMPUTER_SCIENCE/MATHS \
    COMPUTER_SCIENCE/SYSTEMS/{C-CPP,Linux,Python,Rust,VM-iso} \
    COMPUTER_SCIENCE/WEB/{back-end,front-end}

# --- RESOURCES ---
echo "→ Création des dossiers RESOURCES/PDF/…"
mkdir -p \
    RESOURCES/PDF/{42_SCHOOL,bash,CS,CYBER,DSA,SOLUTION_DIGITAL,WEB}

# --- Tree Preview ---
echo -e "\n🌳 Aperçu de la structure :"
command -v tree &>/dev/null && tree -L 3 --dirsfirst -n "$WORKSPACE" | head -n 40 || echo "(tree non installé)"

# --- State Flag ---
state::mark_done "$WORKSPACE_FLAG"
echo "[✓] Workspace initialized."
