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

### Quick Start

1. **Clone this repository:**
   ```bash
   git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/workspace/dotfiles
   cd ~/workspace/dotfiles
   ```

2. **Run the installation script:**
   ```bash
   ./install.sh
   ```

3. **Configure your secrets:**
   - Edit `secrets.zsh` and add your API keys
   - Edit `mcpservers.json` if you need MCP server configuration

4. **Restart your terminal or reload configuration:**
   ```bash
   source ~/.zshrc
   ```

### What the installer does

The `install.sh` script will:
- Create timestamped backups of any existing configurations
- Create symlinks from this repository to the appropriate locations
- Copy `secrets.example.zsh` to `secrets.zsh` if it doesn't exist
- Copy `mcpservers.example.json` to `mcpservers.json` if it doesn't exist

### Configuration Files

The following configurations are managed by this repository:

#### Shell Configuration
- `.zshrc` - Zsh configuration
- `.aliases` - Shell aliases
- `.functions` - Shell functions
- `.secrets.zsh` - API keys and tokens (not tracked in git)

#### Editor Configurations
- `.config/nvim/` - Neovim configuration
- `.config/zed/` - Zed editor settings

#### Terminal Emulators
- `.config/ghostty/` - Ghostty terminal configuration
- `.config/alacritty/` - Alacritty terminal configuration
- `.warp/` - Warp terminal themes and keybindings

#### Other Tools
- `.config/glab-cli/` - GitLab CLI configuration
- `.claude/CLAUDE.md` - Claude AI instructions
- `.claude/mcpservers.json` - MCP server configuration (not tracked in git)
- `Raycast.rayconfig` - Raycast configuration (import manually)
- `dygama-raise-settings.json` - Dygma keyboard settings (import manually)

### Uninstallation

To remove all symlinks created by the installer:

```bash
./uninstall.sh
```

This will:
- Remove all symlinks pointing to this repository
- Preserve your `secrets.zsh` and `mcpservers.json` files
- Keep any backups that were created during installation

### Updating

To update your configurations:

```bash
cd ~/workspace/dotfiles
git pull
```

Changes will be immediately reflected since everything is symlinked.

### Backups

The installer creates timestamped backups in `~/.dotfiles-backup-YYYYMMDD-HHMMSS/` before creating symlinks. These can be used to restore previous configurations if needed.
