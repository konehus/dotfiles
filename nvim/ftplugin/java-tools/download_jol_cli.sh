#!/bin/bash
# Download jol-cli-latest.jar from Shipilev's site (optional -u to force)

# ANSI + Nerd Font icons
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'
ICON_DOWNLOAD=""
ICON_UPDATE=""
ICON_SUCCESS=""
ICON_ERROR=""

# Flags
FORCE_UPDATE=0
while getopts "u" opt; do
  case "$opt" in
    u) FORCE_UPDATE=1 ;;
  esac
done

# Setup
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
REPO_BASE="$XDG_DATA_HOME/repo"
ORG_DIR="$REPO_BASE/openjdk"
TARGET_DIR="$ORG_DIR/jol"
mkdir -p "$TARGET_DIR"

JAR_URL="https://builds.shipilev.net/jol/jol-cli-latest.jar"
JAR_PATH="$TARGET_DIR/jol-cli-latest.jar"
VERSION_FILE="$TARGET_DIR/version.txt"

# Get last modified date from remote
LATEST_VERSION=$(curl -sI "$JAR_URL" | grep -i "Last-Modified" | cut -d' ' -f2- | tr -d '\r')
if [ -z "$LATEST_VERSION" ]; then
  echo -e "${RED}${ICON_ERROR} Failed to get remote version info.${NC}"
  exit 1
fi

# Check current version
if [ -f "$VERSION_FILE" ]; then
  CURRENT_VERSION=$(cat "$VERSION_FILE")
else
  CURRENT_VERSION=""
fi

# If up to date and no force update, exit early
if [ "$FORCE_UPDATE" -eq 0 ] && [ "$CURRENT_VERSION" == "$LATEST_VERSION" ]; then
  echo -e "${GREEN}${ICON_SUCCESS} jol-cli-latest.jar is up-to-date.${NC}"
  exit 0
fi

echo -e "${BLUE}${ICON_UPDATE} Downloading jol-cli-latest.jar...${NC}"
curl --progress-bar -L -o "$JAR_PATH" "$JAR_URL"

if [ $? -ne 0 ]; then
  echo -e "${RED}${ICON_ERROR} Download failed.${NC}"
  exit 1
fi

# Save new version
echo "$LATEST_VERSION" > "$VERSION_FILE"
echo -e "${GREEN}${ICON_SUCCESS} Downloaded jol-cli-latest.jar to ${YELLOW}$JAR_PATH${NC}"
