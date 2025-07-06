#!/usr/bin/env bash

source "$C_CORE/env.sh"
source "$C_CORE/init/state.sh"

WORKSPACE_FLAG="workspace"

if state::is_done "$WORKSPACE_FLAG"; then
    echo "[✓] Workspace already initialized — skipping"
    exit 0
fi

cd $HOME/Developer

echo "[+] Setting up WORKSPACE at: $WORKSPACE"
mkdir -p "$WORKSPACE"
cd "$WORKSPACE"

# --- ACTIVE ---
echo "→ Création des dossiers ACTIVE/INBOX/repository..."
mkdir -p \
    ACTIVE/INBOX/{42_POOL,Anglais,cnam-l3,CS_Projects,leetcode,OPEN_SOURCE,shell_exo} \
    ACTIVE/PROJECTS/{Active,SideProject} \
    ACTIVE/TASKS

# --- ARCHIVED ---
echo "→ Création des dossiers ARCHIVED/ (hors archives et images)..."
mkdir -p ARCHIVED/ARCHIVED_2023
mkdir -p ARCHIVED/portfolioimage  # Les images restent (adaptation si tu les exclus)

# --- COMPUTER_SCIENCE ---
echo "→ Création des dossiers COMPUTER_SCIENCE/ALGORITHMS, SYSTEMS, WEB, etc..."
mkdir -p \
    COMPUTER_SCIENCE/ALGORITHMS \
    COMPUTER_SCIENCE/CLOUD \
    COMPUTER_SCIENCE/DESIGNS_PATTERN \
    COMPUTER_SCIENCE/MATHS \
    COMPUTER_SCIENCE/SYSTEMS/{C-CPP,Linux,Python,VM-iso} \
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
