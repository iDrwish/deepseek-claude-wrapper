#!/bin/bash

# DeepSeek Claude Uninstall Script
# This script removes the isolated DeepSeek Claude installation

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
INSTALL_DIR="$HOME/.deepseek-claude"
BIN_DIR="/usr/local/bin"
WRAPPER_SCRIPT="deepseek-claude"

echo -e "${BLUE}🗑️  Uninstalling DeepSeek Claude...${NC}"

# Remove installation directory
if [ -d "$INSTALL_DIR" ]; then
    echo -e "${BLUE}📁 Removing installation directory: $INSTALL_DIR${NC}"
    rm -rf "$INSTALL_DIR"
    echo -e "${GREEN}✅ Installation directory removed${NC}"
else
    echo -e "${YELLOW}⚠️  Installation directory not found: $INSTALL_DIR${NC}"
fi

# Remove symlink from /usr/local/bin
if [ -L "$BIN_DIR/$WRAPPER_SCRIPT" ] || [ -f "$BIN_DIR/$WRAPPER_SCRIPT" ]; then
    echo -e "${BLUE}🔗 Removing symlink: $BIN_DIR/$WRAPPER_SCRIPT${NC}"
    if [ -w "$BIN_DIR" ]; then
        rm -f "$BIN_DIR/$WRAPPER_SCRIPT"
        echo -e "${GREEN}✅ Symlink removed successfully${NC}"
    else
        echo -e "${YELLOW}⚠️  Attempting to remove symlink with sudo...${NC}"
        if sudo rm -f "$BIN_DIR/$WRAPPER_SCRIPT"; then
            echo -e "${GREEN}✅ Symlink removed successfully with sudo${NC}"
        else
            echo -e "${RED}❌ Failed to remove symlink. You may need to manually remove:${NC}"
            echo -e "${YELLOW}   $BIN_DIR/$WRAPPER_SCRIPT${NC}"
        fi
    fi
else
    echo -e "${YELLOW}⚠️  Symlink not found: $BIN_DIR/$WRAPPER_SCRIPT${NC}"
fi

echo ""
echo -e "${GREEN}🎉 DeepSeek Claude has been uninstalled successfully!${NC}"
echo -e "${BLUE}📋 Note: Your original claude installation remains untouched${NC}"
echo ""
