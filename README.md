# DeepSeek Claude CLI

A CLI wrapper that creates an isolated Claude Code installation configured to use DeepSeek's Anthropic-compatible API instead of the standard Anthropic API.

## 🚀 What This Does

This project provides a seamless way to use Claude Code with DeepSeek's API while keeping your existing Claude installation completely untouched. It creates:

- **Isolated Environment**: Installs Claude Code in `~/.deepseek-claude/`
- **DeepSeek Configuration**: Pre-configured to use DeepSeek's API endpoints and models
- **System Integration**: Adds `deepseek-claude` command available system-wide
- **No Conflicts**: Your original Claude Code installation remains unchanged

## 📋 Prerequisites

- Node.js (v14 or higher)
- npm
- DeepSeek API key ([Get one here](https://platform.deepseek.com/))

## ⚡ Quick Setup

### 1. Set Your DeepSeek API Key

```bash
# Temporary setup (for current session)
export DEEPSEEK_API_KEY=your_actual_api_key_here

# Permanent setup (add to shell profile)
echo 'export DEEPSEEK_API_KEY=your_actual_api_key_here' >> ~/.bashrc  # or ~/.zshrc
source ~/.bashrc  # or source ~/.zshrc
```

### 2. Run the Installation

**Option A: Download and run locally**
```bash
# Make scripts executable (if needed)
chmod +x install-deepseek-claude.sh

# Install DeepSeek Claude
./install-deepseek-claude.sh
```

**Option B: One-line curl installation**
```bash
# Install directly from GitHub
curl -L https://raw.githubusercontent.com/iDrwish/deepseek-claude-wrapper/main/install-deepseek-claude.sh | sh
```

**⚠️ Security Note**: Always review scripts before piping them to sh. You can download and inspect first:
```bash
curl -O https://raw.githubusercontent.com/iDrwish/deepseek-claude-wrapper/main/install-deepseek-claude.sh
# Review the script, then run:
chmod +x install-deepseek-claude.sh
./install-deepseek-claude.sh
```

### 3. Start Using DeepSeek Claude

```bash
# Navigate to your project
cd my-project

# Launch DeepSeek Claude
deepseek-claude
```

## 🎯 Usage Examples

### Basic Usage
```bash
cd my-project
deepseek-claude
```

### With Custom Instructions
```bash
cd my-project
deepseek-claude --instruction "Focus on code optimization and performance"
```

### Get Help
```bash
deepseek-claude --help
```

## 🔧 How It Works

The installation script performs the following:

1. **Creates Isolated Directory**: `~/.deepseek-claude/`
2. **Installs Claude Code**: Local npm installation in the isolated environment
3. **Configures Environment**: Sets these DeepSeek-specific variables:
   - `ANTHROPIC_BASE_URL=https://api.deepseek.com/anthropic`
   - `ANTHROPIC_AUTH_TOKEN=$DEEPSEEK_API_KEY`
   - `ANTHROPIC_MODEL=DeepSeek-V3.1`
   - `ANTHROPIC_SMALL_FAST_MODEL=deepseek-chat`
4. **Creates Wrapper Script**: Bash script that sets up environment and launches Claude
5. **Adds to PATH**: Makes `deepseek-claude` available system-wide

## 🗂️ File Structure

```
deepseek-claude-wrapper/
├── install-deepseek-claude.sh    # Main installation script
├── uninstall-deepseek-claude.sh  # Clean removal script
└── README.md                     # This documentation
```

After installation:
```
~/.deepseek-claude/
├── node_modules/                 # Isolated Claude Code installation
├── package.json                  # npm configuration
└── deepseek-claude              # Environment wrapper script
```

## 🛠️ DeepSeek API Compatibility

This setup leverages DeepSeek's full Anthropic API compatibility:

- ✅ **Full Tool Support**: Function calling and tool usage
- ✅ **Streaming Responses**: Real-time response streaming
- ✅ **Temperature Control**: Fine-tune creativity (0.0 - 2.0)
- ✅ **System Messages**: Custom system prompts
- ✅ **Multi-turn Conversations**: Context-aware conversations
- ✅ **Stop Sequences**: Custom stopping conditions

## 🔄 Uninstallation

To completely remove DeepSeek Claude:

```bash
./uninstall-deepseek-claude.sh
```

This will:
- Remove the `~/.deepseek-claude/` directory
- Remove any system symlinks
- Leave your original Claude Code installation untouched

## ❓ Troubleshooting

### Command Not Found
If `deepseek-claude` is not found:

```bash
# Check if installed
ls -la ~/.deepseek-claude/

# Manually add to PATH
export PATH="$HOME/.deepseek-claude:$PATH"

# Or restart your terminal
```

### API Key Issues
```bash
# Verify API key is set
echo $DEEPSEEK_API_KEY

# Check DeepSeek platform for key validity
# https://platform.deepseek.com/
```

### Permission Issues
```bash
# Make scripts executable
chmod +x install-deepseek-claude.sh
chmod +x uninstall-deepseek-claude.sh
```

## ⚙️ Advanced Configuration

### Custom Installation Location
Edit the `INSTALL_DIR` variable in the installation script:

```bash
# Edit install-deepseek-claude.sh
INSTALL_DIR="$HOME/my-custom-location/.deepseek-claude"
```

### Additional Environment Variables
Add custom variables to the wrapper script:

```bash
# Edit ~/.deepseek-claude/deepseek-claude
export CUSTOM_VAR="value"
```

## 📚 Resources

- [DeepSeek API Documentation](https://api-docs.deepseek.com/)
- [DeepSeek Anthropic API Guide](https://api-docs.deepseek.com/guides/anthropic_api)
- [Claude Code Documentation](https://github.com/anthropics/claude-code)
- [DeepSeek Platform](https://platform.deepseek.com/)

## 🎉 Features

- 🔒 **Complete Isolation**: No interference with existing installations
- 🚀 **One-Command Setup**: Simple installation process
- 🔄 **DeepSeek Integration**: Full API compatibility
- 🛠️ **System-wide Access**: Available from any directory
- 🧹 **Easy Removal**: Clean uninstallation script

---

**Note**: This project is provided as-is for educational and development purposes. Always verify API compatibility with the latest DeepSeek documentation.