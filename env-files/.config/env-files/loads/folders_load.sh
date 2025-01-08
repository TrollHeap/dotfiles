# ----- Create the base directory if it doesn't exist -----
# Base directory for the developer workspace
BASE_DIR="Developer"

echo "Setting up the developer workspace..."
if [ ! -d "$BASE_DIR" ]; then
  mkdir -p "$BASE_DIR/Workspace"
fi


cd "$BASE_DIR" || { echo "Error: unable to access $BASE_DIR"; }
mkdir -p Workspace && cd Workspace 

mkdir -p {JS_TS,PHP,C_CPP,CSharp,LUA,Python,JAVA,SHELL} 
echo " All directories have been created successfully in $(pwd)"

# Return to home directory
cd "$HOME" || { echo "Error: Unable to access $HOME";  }
