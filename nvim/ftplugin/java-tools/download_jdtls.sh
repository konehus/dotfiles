#!/bin/bash
# Minimal update script with optional -u flag, ANSI colors, and Nerd Font icons

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'  # No Color

# Nerd Font icons
ICON_FOLDER=""
ICON_DOWNLOAD=""
ICON_EXTRACT=""
ICON_CLEANUP=""
ICON_UPDATE=""
ICON_SUCCESS=""
ICON_ERROR=""

# Parse command-line options (use -u for update)
UPDATE=0
while getopts "u" opt; do
  case "$opt" in
    u) UPDATE=1 ;;
  esac
done

# Determine XDG_DATA_HOME or default to $HOME/.local/share, then set repo directory
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export REPO="$XDG_DATA_HOME/repo"
# The installation folder for jdtls will be $REPO/jdtls
TARGET_DIR="$REPO/jdtls"

# Ensure the base repo directory exists
mkdir -p "$REPO"

# Define the version file path (inside the installed jdtls folder)
VERSION_FILE="$TARGET_DIR/version.txt"

# Fetch the latest version string from the remote URL
LATEST_VERSION=$(curl --progress-bar -s "https://download.eclipse.org/jdtls/snapshots/latest.txt" | tr -d '\n')
if [ -z "$LATEST_VERSION" ]; then
    echo -e "${RED}${ICON_ERROR} Failed to fetch the latest version.${NC}"
    exit 1
fi

# If a version file exists, read the current installed version
if [ -f "$VERSION_FILE" ]; then
    CURRENT_VERSION=$(cat "$VERSION_FILE")
else
    CURRENT_VERSION=""
fi

# If not updating and jdtls is already installed, just output the version info
if [ $UPDATE -eq 0 ] || [ "$CURRENT_VERSION" ==  "$LATEST_VERSION" ] ; then
    if [ -n "$CURRENT_VERSION" ]; then
        echo -e "${BLUE}Installed jdtls version: ${YELLOW}$CURRENT_VERSION${NC}"
        echo -e "${BLUE}Latest available version: ${YELLOW}$LATEST_VERSION${NC}"
        if [ "$CURRENT_VERSION" == "$LATEST_VERSION" ]; then
            echo -e "${GREEN}${ICON_SUCCESS} jdtls is up-to-date.${NC}"
        else
            echo -e "${BLUE}${ICON_UPDATE} Update available. Run with -u to update.${NC}"
        fi
        exit 0
    else
        echo -e "${BLUE}No jdtls installation found. Proceeding with download...${NC}"
    fi
fi

echo -e "${BLUE}${ICON_UPDATE} Updating jdtls to $LATEST_VERSION...${NC}"

# If a previous installation exists, remove it and create fresh 
if [ -d "$TARGET_DIR" ]; then
  rm -rf "$TARGET_DIR"
fi

mkdir -p "$TARGET_DIR"

# Define download URL and output tarball path (saved into the repo folder)
DOWNLOAD_URL="https://www.eclipse.org/downloads/download.php?file=/jdtls/snapshots/jdt-language-server-latest.tar.gz"
OUTPUT_FILE="$TARGET_DIR/$LATEST_VERSION.tar.gz"

echo -e "${BLUE}${ICON_DOWNLOAD} Downloading jdtls snapshot...${NC}"
curl --progress-bar -L -o "$OUTPUT_FILE" "$DOWNLOAD_URL"

if [ $? -ne 0 ]; then
    echo -e "${RED}${ICON_ERROR} Download failed.${NC}"
    exit 1
fi
echo -e "${GREEN}${ICON_SUCCESS} Download complete.${NC}"

echo -e "${BLUE}${ICON_EXTRACT} Extracting archive...${NC}"
# Extract the archive into the repo directory to preserve its structure
tar -xzf "$OUTPUT_FILE" -C "$TARGET_DIR"
if [ $? -ne 0 ]; then
    echo -e "${RED}${ICON_ERROR} Extraction failed.${NC}"
    exit 1
fi
rm "$OUTPUT_FILE"

# Write the latest version into the version file
echo "$LATEST_VERSION" > "$VERSION_FILE"

echo -e "${GREEN}${ICON_SUCCESS} jdtls updated to $LATEST_VERSION.${NC}"

# Also download lombok.jar into the repo
LOMBOK_DIR="$REPO/lombok"
LOMBOK_JAR="$LOMBOK_DIR/lombok.jar"
LOMBOK_URL="https://projectlombok.org/downloads/lombok.jar"

mkdir -p "$LOMBOK_DIR"

echo -e "${BLUE}${ICON_DOWNLOAD} Downloading lombok.jar...${NC}"
curl --progress-bar -L -o "$LOMBOK_JAR" "$LOMBOK_URL"
if [ $? -ne 0 ]; then
  echo -e "${RED}${ICON_ERROR} Failed to download lombok.jar.${NC}"
else
  echo -e "${GREEN}${ICON_SUCCESS} lombok.jar downloaded to ${YELLOW}$LOMBOK_JAR${NC}"
fi

exit 0
