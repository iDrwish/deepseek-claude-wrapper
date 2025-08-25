# DeepSeek Claude CLI

A CLI wrapper that creates an isolated Claude Code installation configured to use DeepSeek V3.1 with **100% Claude Code CLI compatibility**. Every command and flag from the [official Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code/cli-reference) works identically.

## 🚀 What This Does

This project provides a seamless way to use Claude Code with DeepSeek V3.1 while maintaining **complete CLI compatibility** with the original Claude Code:

- **🔄 100% CLI Compatibility**: All Claude Code commands and flags work with `deepseek-claude`
- **🔒 Isolated Environment**: Installs Claude Code in `~/.deepseek-claude/`
- **🧠 DeepSeek V3.1 Integration**: Pre-configured to use DeepSeek's advanced reasoning model
- **🛠️ System Integration**: Adds `deepseek-claude` command available system-wide
- **🚫 No Conflicts**: Your original Claude Code installation remains unchanged

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
echo 'export DEEPSEEK_API_KEY=your_actual_api_key_here' >> ~/.bashrc  # or ~/.bash_profile / ~/.zshrc
source ~/.bashrc  # or source ~/.bash_profile / ~/.zshrc
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
curl -L https://raw.githubusercontent.com/iDrwish/deepseek-claude-wrapper/main/install-deepseek-claude.sh | bash
```

**⚠️ Security Note**: Always review scripts before piping them to bash. You can download and inspect first:
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

## 🚀 Complete Claude Code CLI Compatibility

**`deepseek-claude` provides 100% compatibility with all Claude Code CLI commands and flags.** Every feature from the [official Claude Code CLI reference](https://docs.anthropic.com/en/docs/claude-code/cli-reference) works identically, just with DeepSeek V3.1 as the backend.

### 📋 All Claude Code Commands Work:

| Command | DeepSeek Equivalent | Description |
|---------|---------------------|-------------|
| `claude` | `deepseek-claude` | Start interactive REPL |
| `claude "query"` | `deepseek-claude "query"` | Start REPL with initial prompt |
| `claude -p "query"` | `deepseek-claude -p "query"` | Query via SDK, then exit |
| `claude -c` | `deepseek-claude -c` | Continue most recent conversation |
| `claude update` | `deepseek-claude update` | Update to latest version |
| `claude config` | `deepseek-claude config` | Configure settings |
| `claude mcp` | `deepseek-claude mcp` | Configure MCP servers |
| `claude doctor` | `deepseek-claude doctor` | Health diagnostics |

### 🏷️ All Claude Code Flags Work:

| Flag | Example with DeepSeek | Description |
|------|----------------------|-------------|
| `--print, -p` | `deepseek-claude -p "query"` | Print response without interactive mode |
| `--model` | `deepseek-claude --model sonnet` | Set model (uses DeepSeek V3.1) |
| `--output-format` | `deepseek-claude -p "query" --output-format json` | Specify output format |
| `--verbose` | `deepseek-claude --verbose` | Enable verbose logging |
| `--debug` | `deepseek-claude --debug` | Enable debug mode |
| `--continue, -c` | `deepseek-claude -c` | Continue recent conversation |
| `--resume, -r` | `deepseek-claude -r "session-id"` | Resume specific session |
| `--add-dir` | `deepseek-claude --add-dir ../apps ../lib` | Add working directories |
| `--allowedTools` | `deepseek-claude --allowedTools "Bash" "Edit"` | Allow specific tools |
| `--disallowedTools` | `deepseek-claude --disallowedTools "Edit"` | Disallow specific tools |
| `--permission-mode` | `deepseek-claude --permission-mode plan` | Set permission mode |
| `--append-system-prompt` | `deepseek-claude --append-system-prompt "Custom"` | Append system prompt |
| `--max-turns` | `deepseek-claude -p --max-turns 3 "query"` | Limit agentic turns |

**📚 Complete Reference**: See [Claude Code CLI Reference](https://docs.anthropic.com/en/docs/claude-code/cli-reference) for detailed documentation of all commands and flags.

## 🎯 Usage Examples

### Basic Usage
```bash
cd my-project
deepseek-claude
```

### Advanced CLI Usage
```bash
# Non-interactive with JSON output
deepseek-claude -p "Analyze this codebase" --output-format json

# Continue previous conversation with verbose logging
deepseek-claude -c --verbose

# Debug mode with custom system prompt
deepseek-claude --debug --append-system-prompt "Focus on security"

# Pipe content for analysis
cat logs.txt | deepseek-claude -p "Analyze these logs"

# Resume specific session
deepseek-claude -r "session-123" "Continue the refactoring"
```

### Configuration & Management
```bash
# Configure settings (same as Claude)
deepseek-claude config set theme dark
deepseek-claude config list

# Health check
deepseek-claude doctor

# Update to latest version
deepseek-claude update
```

## 🔧 How It Works

The installation creates a transparent wrapper that provides **100% compatibility** with all [Claude Code CLI commands and flags](https://docs.anthropic.com/en/docs/claude-code/cli-reference):

1. **Creates Isolated Directory**: `~/.deepseek-claude/`
2. **Installs Claude Code**: Local npm installation in the isolated environment
3. **Configures Environment**: Sets these DeepSeek-specific variables:
   - `ANTHROPIC_BASE_URL=https://api.deepseek.com/anthropic`
   - `ANTHROPIC_AUTH_TOKEN=$DEEPSEEK_API_KEY`
   - `ANTHROPIC_MODEL=DeepSeek-V3.1`
   - `ANTHROPIC_SMALL_FAST_MODEL=deepseek-chat`
4. **Creates Smart Wrapper**: Intercepts `update` command, passes everything else to Claude transparently
5. **Adds to PATH**: Makes `deepseek-claude` available system-wide with full CLI compatibility

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

### Auto-Update Failed Message
If you see "Auto-update failed" when starting `deepseek-claude`:

```bash
# This is normal for isolated installations
# Use the built-in update command instead:
deepseek-claude update
```

**Why this happens**: The isolated installation can't auto-update like global installations, but manual updates work perfectly.

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

- 🔄 **100% Claude CLI Compatibility**: Every command and flag from [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code/cli-reference) works identically
- 🧠 **DeepSeek V3.1 Reasoning**: Advanced reasoning capabilities with full tool support
- 🔒 **Complete Isolation**: No interference with existing Claude installations
- 🚀 **One-Command Setup**: Simple installation process with automatic configuration
- 🛠️ **System-wide Access**: Available from any directory as `deepseek-claude`
- 🧹 **Easy Management**: Built-in update command and clean uninstallation

---

**Note**: This project is provided as-is for educational and development purposes. Always verify API compatibility with the latest DeepSeek documentation.