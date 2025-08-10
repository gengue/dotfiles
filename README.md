# Dotfiles

This repository contains my personal dotfiles and configuration files for various applications and tools. The goal is to maintain a consistent and efficient development environment across different machines. This is macOS specific, but can be adapted to other systems with some modifications.

## Software and Tools

If this this is a new machine, this is my must-have software to install:

- [Homebrew](https://brew.sh/) - Package manager for macOS, bellow a section for the formulae and casks I use
- [Oh My Zsh](https://ohmyz.sh/#install) - Framework for managing Zsh configuration
- [Warp](https://app.warp.dev/get_warp?package=dmg) - Modern terminal
- [Outer base](https://www.outerbase.com/downloads/) - Database
- [Docker](https://docs.docker.com/desktop/setup/install/mac-install/) - Containerization platform
- [1Password](https://1password.com/downloads/mac) - Password manager
- [Claude Desktop](https://claude.ai/download) - AI assistant
- [ChatGTP Desktop](https://openai.com/chatgpt/desktop/) - AI assistant
- [Cleanshoot](https://licenses.cleanshot.com/download/cleanshotx) - Screenshot tool
- [Bazecor](https://github.com/Dygmalab/Bazecor) - Dygma keyboard configuration tool

### Homebrew

```bash
brew install git neovim go uv sqlite jq lazygit lazysql libpng jpeg ncurses chafa graphviz graphicsmagick tree-sitter fzf ripgrep fd gh glab 
brew install --cask raycast ghostty ngrok font-fira-code-nerd-font font-hack-nerd-font font-meslo-lg-nerd-font font-ibm-plex-mono 

brew tap oven-sh/bun
brew install bun

````

### Agentic AI 

Depending on what's hot at the moment, I use different AI agents. My current favorites are:

- Claude code: `npm install -g @anthropic-ai/claude-code` 
- Opencode: `curl -fsSL https://opencode.ai/install | bash`
- Codex: `brew install codex`

### npm

```
npm install -g typescript-language-server typescript @biomejs/biome
```

### uv

```bash
uv python install
````

## Installation

```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/workspace/dotfiles
cd ~/workspace/dotfiles
./install.sh
```

Then:
1. Edit `secrets.zsh` with your API keys
2. Create `~/.claude/mcpservers.json` if needed (see `mcpservers.example.json`)
3. Restart terminal or run `source ~/.zshrc`

### Scripts

- **`install.sh`** - Sets up symlinks and creates backups
- **`uninstall.sh`** - Removes symlinks, preserves secrets
- **`test-install.sh`** - Test installation in `/tmp` without affecting system

### Configuration Files

Managed configurations:
- **Shell**: `.zshrc`, `.aliases`, `.functions`, `.secrets.zsh`
- **Editors**: Neovim, Zed (settings/keymap/snippets as individual files)
- **Terminals**: Ghostty, Alacritty, Warp
- **Tools**: GitLab CLI, Claude instructions
- **Manual imports**: Raycast, Dygma keyboard settings

### Uninstallation

```bash
./uninstall.sh
```

This will remove all symlinks while preserving your secrets.

### Updating

```bash
cd ~/workspace/dotfiles
git pull
```

Changes will be immediately reflected since everything is symlinked.

### Backups

The installer creates timestamped backups in `~/.dotfiles-backup-YYYYMMDD-HHMMSS/` before creating symlinks. These can be used to restore previous configurations if needed.
