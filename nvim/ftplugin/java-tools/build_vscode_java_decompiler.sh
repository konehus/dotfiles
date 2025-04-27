#!/bin/bash
# Clone dgileadi/vscode-java-decompiler with optional -u flag

# ANSI + Nerd Font
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'
ICON_CLONE=""
ICON_UPDATE=""
ICON_SUCCESS=""
ICON_ERROR=""

FORCE_UPDATE=0
while getopts "u" opt; do
  case "$opt" in
    u) FORCE_UPDATE=1 ;;
  esac
done

XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
REPO_BASE="$XDG_DATA_HOME/repo"
ORG_DIR="$REPO_BASE/dgileadi"
TARGET_DIR="$ORG_DIR/vscode-java-decompiler"
VERSION_FILE="$TARGET_DIR/version.txt"
REPO_URL="https://github.com/dgileadi/vscode-java-decompiler.git"

mkdir -p "$ORG_DIR"

# Clone if not present
if [ ! -d "$TARGET_DIR/.git" ]; then
  echo -e "${BLUE}${ICON_CLONE} Cloning into ${YELLOW}$TARGET_DIR${NC}"
  git clone "$REPO_URL" "$TARGET_DIR" || {
    echo -e "${RED}${ICON_ERROR} Clone failed.${NC}"
    exit 1
  }
fi

cd "$TARGET_DIR"
git fetch origin &>/dev/null
LATEST_COMMIT=$(git rev-parse origin/master)

if [ -f "$VERSION_FILE" ]; then
  CURRENT_VERSION=$(cat "$VERSION_FILE")
else
  CURRENT_VERSION=""
fi

if [ "$FORCE_UPDATE" -eq 0 ] && [ "$CURRENT_VERSION" == "$LATEST_COMMIT" ]; then
  echo -e "${GREEN}${ICON_SUCCESS} vscode-java-decompiler is up-to-date at commit ${YELLOW}$LATEST_COMMIT${NC}"
  exit 0
fi

echo -e "${BLUE}${ICON_UPDATE} Updating to latest commit ${YELLOW}$LATEST_COMMIT${NC}"
git reset --hard origin/master &>/dev/null
echo "$LATEST_COMMIT" > "$VERSION_FILE"

echo -e "${GREEN}${ICON_SUCCESS} Updated vscode-java-decompiler to ${YELLOW}$LATEST_COMMIT${NC}"
