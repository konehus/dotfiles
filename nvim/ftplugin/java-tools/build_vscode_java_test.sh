#!/bin/bash
# Clone and build microsoft/vscode-java-test with optional -u (force update)

# ANSI Colors + Nerd Font Icons
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

ICON_CLONE=""
ICON_BUILD=""
ICON_UPDATE=""
ICON_SUCCESS=""
ICON_ERROR=""
ICON_GIT=""

# Flags
FORCE_UPDATE=0
while getopts "u" opt; do
  case "$opt" in
    u) FORCE_UPDATE=1 ;;
  esac
done

# Repo setup
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
REPO_BASE="$XDG_DATA_HOME/repo"
ORG_DIR="$REPO_BASE/microsoft"
TARGET_DIR="$ORG_DIR/vscode-java-test"
VERSION_FILE="$TARGET_DIR/version.txt"
REPO_URL="https://github.com/microsoft/vscode-java-test.git"

mkdir -p "$ORG_DIR"

# Clone if not exists
if [ ! -d "$TARGET_DIR/.git" ]; then
  echo -e "${BLUE}${ICON_CLONE} Cloning microsoft/vscode-java-test into ${YELLOW}$TARGET_DIR${NC}"
  git clone "$REPO_URL" "$TARGET_DIR" || {
    echo -e "${RED}${ICON_ERROR} Failed to clone repository.${NC}"
    exit 1
  }
fi

cd "$TARGET_DIR"

# Fetch remote and check latest commit hash
git fetch origin &>/dev/null
LATEST_COMMIT=$(git rev-parse origin/main)
CURRENT_COMMIT=$(git rev-parse HEAD)

if [ -f "$VERSION_FILE" ]; then
  STORED_VERSION=$(cat "$VERSION_FILE")
else
  STORED_VERSION=""
fi

if [ "$FORCE_UPDATE" -eq 0 ]; then
  if [ "$STORED_VERSION" == "$LATEST_COMMIT" ]; then
    echo -e "${GREEN}${ICON_SUCCESS} vscode-java-test is up-to-date at commit ${YELLOW}$LATEST_COMMIT${NC}"
    exit 0
  else
    echo -e "${BLUE}${ICON_UPDATE} Update available. Latest commit: ${YELLOW}$LATEST_COMMIT${NC}"
  fi
else
  echo -e "${BLUE}${ICON_UPDATE} Forcing update and rebuild...${NC}"
fi

# Reset to latest main 
git reset --hard origin/main &>/dev/null

# Build
echo -e "${BLUE}${ICON_BUILD} Building vscode-java-test with ./mvnw clean install...${NC}"
(cd "$TARGET_DIR/java-extension" && ./mvnw clean install)

if [ $? -ne 0 ]; then
  echo -e "${RED}${ICON_ERROR} Build failed.${NC}"
  exit 1
fi

# Save new version hash
echo "$LATEST_COMMIT" > "$VERSION_FILE"
echo -e "${GREEN}${ICON_SUCCESS} vscode-java-test updated and built at commit ${YELLOW}$LATEST_COMMIT${NC}"
