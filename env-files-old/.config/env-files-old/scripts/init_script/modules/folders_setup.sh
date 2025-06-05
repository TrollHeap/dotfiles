#!/bin/bash

# ----- Hybrid Structure Configuration -----
BASE_DIR="$HOME/Developer/Workspace"

echo "Setting up workspace..."
mkdir -p "$BASE_DIR" || { echo " Error creating root directory"; exit 1; }

cd "$BASE_DIR" || { echo " Failed to access $BASE_DIR"; exit 1; }

# Core Layer
echo "🔨 Building Core layer..."
mkdir -p Core/Languages/{Web,Systems}
mkdir -p Core/DevOps/{Shell_Scripts,Linux,CI-CD}

# Projects Layer
echo "🚀 Initializing projects..."
mkdir -p Projects/{Active/\!_Urgent,Active/\~_In_Progress,Active/\~__StandBy,Clients,Learning,Experimental,Later}

# Libraries & Ecosystem
echo "📚 Setting up shared resources..."
mkdir -p Libraries/{Snippets,Templates}
mkdir -p Ecosystem/{Open_Source,Contributions}

# Subdirectory Initialization
echo "⚙️  Configuring extensions..."
mkdir -p Core/Languages/Web/{JS_TS,PHP,Python}
mkdir -p Core/Languages/Systems/{C_CPP,Python,CSharp,Lua}

# Special Files
touch Projects/Active/\!_Urgent/!!_IN_PROGRESS
touch Projects/Active/\~_In_Progress/!_README.md

echo -e "\n✅ Structure successfully created at:\n$(pwd)\n"

# Tree Preview
echo "🌳 Generated directory tree:"
tree -L 3 --dirsfirst -n "$BASE_DIR" | head -n 20

# Cleanup
find "$BASE_DIR" -type d -empty -delete 2>/dev/null
