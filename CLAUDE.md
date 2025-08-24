# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a CLI wrapper for Claude Code that configures it to use DeepSeek's Anthropic-compatible API instead of the standard Anthropic API. It creates an isolated installation that doesn't interfere with existing Claude Code setups.

## Key Architecture

- **Isolated Installation**: Installs Claude Code in `~/.deepseek-claude/` directory
- **Environment Configuration**: Sets DeepSeek-specific environment variables:
  - `ANTHROPIC_BASE_URL=https://api.deepseek.com/anthropic`
  - `ANTHROPIC_AUTH_TOKEN=$DEEPSEEK_API_KEY`
  - `ANTHROPIC_MODEL=DeepSeek-V3.1`
  - `ANTHROPIC_SMALL_FAST_MODEL=deepseek-chat`
- **Wrapper Script**: Creates a bash script that sets up the environment and launches the isolated Claude Code
- **PATH Integration**: Adds the installation directory to user's PATH via shell profile

## Development Commands

### Installation
```bash
# Set API key first
export DEEPSEEK_API_KEY=your_api_key_here

# Run installation
./install-deepseek-claude.sh
```

### Usage
```bash
# Navigate to project and launch
deepseek-claude

# With custom instructions
deepseek-claude --instruction "Focus on performance optimization"
```

### Uninstallation
```bash
./uninstall-deepseek-claude.sh
```

## File Structure

- `install-deepseek-claude.sh` - Main installation script
- `uninstall-deepseek-claude.sh` - Clean removal script
- `README.md` - Comprehensive documentation

## Important Notes

- Requires `DEEPSEEK_API_KEY` environment variable to be set
- Uses DeepSeek's Anthropic-compatible API endpoint
- Maintains complete isolation from any existing Claude Code installation
- No build, test, or lint commands needed - this is a wrapper/configuration project