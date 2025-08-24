#!/bin/bash

# DeepSeek Claude Installation Script
# This script installs claude-code in an isolated environment configured for DeepSeek
# Can be run directly or via curl: curl -L https://raw.githubusercontent.com/yourusername/claude-code-deepseek-cli/main/install-deepseek-claude.sh | sh

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

echo -e "${BLUE}🚀 Installing DeepSeek Claude in isolated environment...${NC}"

# Check if Node.js and npm are installed
if ! command -v node &> /dev/null; then
    echo -e "${RED}❌ Error: Node.js is not installed. Please install Node.js first.${NC}"
    exit 1
fi

if ! command -v npm &> /dev/null; then
    echo -e "${RED}❌ Error: npm is not installed. Please install npm first.${NC}"
    exit 1
fi

# Check for DeepSeek API key
if [ -z "$DEEPSEEK_API_KEY" ]; then
    echo -e "${YELLOW}⚠️  Warning: DEEPSEEK_API_KEY environment variable is not set.${NC}"
    echo -e "${YELLOW}   You can set it later by running: export DEEPSEEK_API_KEY=your_api_key${NC}"
    echo -e "${YELLOW}   Or add it to your shell profile (~/.bashrc, ~/.zshrc, etc.)${NC}"
    echo ""
fi

# Create installation directory
echo -e "${BLUE}📁 Creating installation directory: $INSTALL_DIR${NC}"
mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR"

# Initialize npm project if package.json doesn't exist
if [ ! -f "package.json" ]; then
    echo -e "${BLUE}📦 Initializing npm project...${NC}"
    cat > package.json << 'PACKAGE_JSON'
{
  "name": "deepseek-claude-installation",
  "version": "1.0.0",
  "description": "DeepSeek Claude isolated installation",
  "private": true
}
PACKAGE_JSON
fi

# Install claude-code locally
echo -e "${BLUE}⬇️  Installing @anthropic-ai/claude-code...${NC}"
npm install @anthropic-ai/claude-code

# Create the wrapper script
echo -e "${BLUE}📝 Creating wrapper script...${NC}"
cat > "$INSTALL_DIR/$WRAPPER_SCRIPT" << 'EOF'
#!/bin/bash

# DeepSeek Claude Wrapper Script
# This script sets up DeepSeek environment variables and launches claude-code

# Check if DEEPSEEK_API_KEY is set
if [ -z "$DEEPSEEK_API_KEY" ]; then
    echo "❌ Error: DEEPSEEK_API_KEY environment variable is not set."
    echo "Please set it by running: export DEEPSEEK_API_KEY=your_api_key"
    echo "Or add it to your shell profile (~/.bashrc, ~/.zshrc, etc.)"
    exit 1
fi

# Set DeepSeek environment variables
export ANTHROPIC_BASE_URL="https://api.deepseek.com/anthropic"
export ANTHROPIC_AUTH_TOKEN="$DEEPSEEK_API_KEY"
export ANTHROPIC_MODEL="DeepSeek-V3.1"
export ANTHROPIC_SMALL_FAST_MODEL="deepseek-chat"

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Run claude-code from the isolated installation
exec "$SCRIPT_DIR/node_modules/.bin/claude" "$@"
EOF

# Make the wrapper script executable
chmod +x "$INSTALL_DIR/$WRAPPER_SCRIPT"

# Add to PATH instead of using symlink (avoids sudo requirement)
echo -e "${BLUE}🔗 Adding to PATH...${NC}"
SHELL_PROFILE=""
if [ "$SHELL" = "/bin/zsh" ] || [ "$SHELL" = "/usr/bin/zsh" ]; then
    SHELL_PROFILE="$HOME/.zshrc"
elif [ "$SHELL" = "/bin/bash" ] || [ "$SHELL" = "/usr/bin/bash" ]; then
    SHELL_PROFILE="$HOME/.bashrc"
fi

if [ -n "$SHELL_PROFILE" ]; then
    if ! grep -q "/.deepseek-claude:" "$SHELL_PROFILE" 2>/dev/null; then
        echo "export PATH=\"\$HOME/.deepseek-claude:\$PATH\"" >> "$SHELL_PROFILE"
        echo -e "${GREEN}✅ Added to PATH in $SHELL_PROFILE${NC}"
        echo -e "${YELLOW}⚠️  Run 'source $SHELL_PROFILE' or restart your terminal to activate${NC}"
    else
        echo -e "${GREEN}✅ Already in PATH${NC}"
    fi
else
    echo -e "${YELLOW}⚠️  Could not detect shell profile. Manually add to your PATH:${NC}"
    echo -e "${YELLOW}   export PATH=\"$INSTALL_DIR:\$PATH\"${NC}"
fi

echo ""
echo -e "${GREEN}🎉 Installation completed successfully!${NC}"
echo ""
echo -e "${BLUE}📋 Usage Instructions:${NC}"
echo -e "1. Set your DeepSeek API key:"
echo -e "   ${YELLOW}export DEEPSEEK_API_KEY=your_api_key_here${NC}"
echo ""
echo -e "2. Navigate to your project directory and run:"
echo -e "   ${YELLOW}deepseek-claude${NC}"
echo ""
echo -e "${BLUE}📚 Additional Information:${NC}"
echo -e "• Your original claude installation remains untouched"
echo -e "• DeepSeek Claude is installed in: $INSTALL_DIR"
echo -e "• The command 'deepseek-claude' is now available system-wide"
echo -e "• To uninstall, simply run: rm -rf $INSTALL_DIR && sudo rm $BIN_DIR/$WRAPPER_SCRIPT"
echo ""
echo -e "${BLUE}🔧 Environment Variables Set:${NC}"
echo -e "• ANTHROPIC_BASE_URL=https://api.deepseek.com/anthropic"
echo -e "• ANTHROPIC_AUTH_TOKEN=\$DEEPSEEK_API_KEY"
echo -e "• ANTHROPIC_MODEL=DeepSeek-V3.1"
echo -e "• ANTHROPIC_SMALL_FAST_MODEL=deepseek-chat"
echo ""
