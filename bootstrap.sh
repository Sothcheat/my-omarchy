#!/bin/bash

# Bootstrap installer for My Omarchy
set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

REPO_URL="https://github.com/Sothcheat/my-omarchy.git"
INSTALL_DIR="$HOME/.local/share/omarchy"

echo -e "${BLUE}╔═══════════════════════════════════╗${NC}"
echo -e "${BLUE}║   My Omarchy Bootstrap Installer  ║${NC}"
echo -e "${BLUE}╚═══════════════════════════════════╝${NC}"

# Check Arch Linux
if [[ ! -f /etc/arch-release ]]; then
    echo -e "${RED}Error: Requires Arch Linux${NC}"
    exit 1
fi

# Install git if needed
if ! command -v git &> /dev/null; then
    echo -e "${YELLOW}Installing git...${NC}"
    sudo pacman -S --needed --noconfirm git
fi

# Backup existing installation
if [[ -d "$INSTALL_DIR" ]]; then
    BACKUP="${INSTALL_DIR}.backup.$(date +%Y%m%d_%H%M%S)"
    echo -e "${YELLOW}Backing up to $BACKUP${NC}"
    mv "$INSTALL_DIR" "$BACKUP"
fi

# Clone repository
echo -e "${GREEN}Downloading My Omarchy...${NC}"
git clone --depth 1 https://github.com/Sothcheat/my-omarchy.git "$INSTALL_DIR"

# Make scripts executable
chmod +x "$INSTALL_DIR/install.sh"
find "$INSTALL_DIR/bin" -type f -exec chmod +x {} \;
find "$INSTALL_DIR/install" -type f -name "*.sh" -exec chmod +x {} \;

# Run installer
echo -e "${GREEN}Starting installation...${NC}"
cd "$INSTALL_DIR"
exec bash "$INSTALL_DIR/install.sh"
