#!/usr/bin/env bash

source "$C_CORE/env.sh"
source "$C_CORE/init/state.sh"

WORKSPACE_FLAG="workspace"

if state::is_done "$WORKSPACE_FLAG"; then
    echo "[✓] Workspace already initialized — skipping"
    exit 0
fi

echo "[+] Setting up workspace at: $WORKSPACE"

mkdir -p "$WORKSPACE" || { echo "❌ Cannot create root workspace"; exit 1; }
cd "$WORKSPACE" || { echo "❌ Cannot enter $WORKSPACE"; exit 1; }

# --- Core Layer ---
echo "🔨 Building Core layer..."
mkdir -p Core/Languages/{Web,Systems}
mkdir -p Core/DevOps/{Shell_Scripts,Linux,CI-CD}

# --- Projects Layer ---
echo "🚀 Initializing projects..."
mkdir -p Projects/Active/{\!_Urgent,\~_In_Progress,\~__StandBy}
mkdir -p Projects/{Clients,Learning,Experimental,Later}

# --- Libraries & Ecosystem ---
echo "📚 Setting up shared resources..."
mkdir -p Libraries/{Snippets,Templates}
mkdir -p Ecosystem/{Open_Source,Contributions}

# --- Extensions ---
echo "⚙️  Configuring extensions..."
mkdir -p Core/Languages/Web/{JS_TS,PHP,Python}
mkdir -p Core/Languages/Systems/{C_CPP,Python,CSharp,Lua}

# --- Special Files ---
touch Projects/Active/\!_Urgent/!!_IN_PROGRESS
touch Projects/Active/\~_In_Progress/!_README.md

# --- Tree Preview ---
echo -e "\n🌳 Workspace structure preview:"
command -v tree &>/dev/null && tree -L 3 --dirsfirst -n "$WORKSPACE" | head -n 20 || echo "(tree not installed)"

# --- Cleanup ---
find "$WORKSPACE" -type d -empty -delete 2>/dev/null

# --- State Flag ---
state::mark_done "$WORKSPACE_FLAG"
echo "[✓] Workspace initialized."
