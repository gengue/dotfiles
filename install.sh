#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script is located
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

echo -e "${BLUE}==================================${NC}"
echo -e "${BLUE}     Dotfiles Installation        ${NC}"
echo -e "${BLUE}==================================${NC}"
echo ""

# Create backup directory
echo -e "${YELLOW}Creating backup directory: $BACKUP_DIR${NC}"
mkdir -p "$BACKUP_DIR"

# Function to create a symlink with backup
create_symlink() {
    local source="$1"
    local target="$2"
    
    # Create parent directory if it doesn't exist
    local parent_dir=$(dirname "$target")
    if [ ! -d "$parent_dir" ]; then
        echo -e "${YELLOW}Creating directory: $parent_dir${NC}"
        mkdir -p "$parent_dir"
    fi
    
    # If target exists and is not a symlink, back it up
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo -e "${YELLOW}Backing up existing $target${NC}"
        cp -r "$target" "$BACKUP_DIR/$(basename "$target")"
        rm -rf "$target"
    elif [ -L "$target" ]; then
        echo -e "${YELLOW}Removing existing symlink $target${NC}"
        rm "$target"
    fi
    
    # Create symlink
    ln -s "$source" "$target"
    echo -e "${GREEN}✓ Linked $source → $target${NC}"
}

# Handle secrets file
echo -e "\n${BLUE}Setting up secrets...${NC}"
if [ ! -f "$DOTFILES_DIR/secrets.zsh" ]; then
    cp "$DOTFILES_DIR/secrets.example.zsh" "$DOTFILES_DIR/secrets.zsh"
    echo -e "${GREEN}✓ Created secrets.zsh from secrets.example.zsh${NC}"
    echo -e "${YELLOW}⚠ Please edit secrets.zsh and add your API keys${NC}"
else
    echo -e "${GREEN}✓ secrets.zsh already exists${NC}"
fi

# Handle mcpservers.json
echo -e "\n${BLUE}Setting up MCP servers configuration...${NC}"
if [ ! -f "$DOTFILES_DIR/mcpservers.json" ]; then
    cp "$DOTFILES_DIR/mcpservers.example.json" "$DOTFILES_DIR/mcpservers.json"
    echo -e "${GREEN}✓ Created mcpservers.json from mcpservers.example.json${NC}"
    echo -e "${YELLOW}⚠ Please edit mcpservers.json if you need to configure MCP servers${NC}"
else
    echo -e "${GREEN}✓ mcpservers.json already exists${NC}"
fi

# Shell configuration files
echo -e "\n${BLUE}Setting up shell configuration...${NC}"
create_symlink "$DOTFILES_DIR/zshrc" "$HOME/.zshrc"
create_symlink "$DOTFILES_DIR/aliases" "$HOME/.aliases"
create_symlink "$DOTFILES_DIR/functions" "$HOME/.functions"
create_symlink "$DOTFILES_DIR/secrets.zsh" "$HOME/.secrets.zsh"

# Neovim configuration
echo -e "\n${BLUE}Setting up Neovim configuration...${NC}"
create_symlink "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

# Terminal emulators
echo -e "\n${BLUE}Setting up terminal emulator configurations...${NC}"
create_symlink "$DOTFILES_DIR/ghostty" "$HOME/.config/ghostty"
create_symlink "$DOTFILES_DIR/alacritty" "$HOME/.config/alacritty"

# Warp terminal
echo -e "\n${BLUE}Setting up Warp terminal configuration...${NC}"
if [ ! -d "$HOME/.warp" ]; then
    mkdir -p "$HOME/.warp"
fi
create_symlink "$DOTFILES_DIR/warp/keybindings.yaml" "$HOME/.warp/keybindings.yaml"
create_symlink "$DOTFILES_DIR/warp/themes" "$HOME/.warp/themes"

# Zed editor
echo -e "\n${BLUE}Setting up Zed editor configuration...${NC}"
create_symlink "$DOTFILES_DIR/zed" "$HOME/.config/zed"

# GitLab CLI
echo -e "\n${BLUE}Setting up GitLab CLI configuration...${NC}"
create_symlink "$DOTFILES_DIR/glab-cli" "$HOME/.config/glab-cli"

# Claude configuration
echo -e "\n${BLUE}Setting up Claude configuration...${NC}"
if [ ! -d "$HOME/.claude" ]; then
    mkdir -p "$HOME/.claude"
fi
create_symlink "$DOTFILES_DIR/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
create_symlink "$DOTFILES_DIR/mcpservers.json" "$HOME/.claude/mcpservers.json"

# Raycast (optional - only if installed)
if command -v raycast &> /dev/null; then
    echo -e "\n${BLUE}Setting up Raycast configuration...${NC}"
    echo -e "${YELLOW}To import Raycast settings, open Raycast and import: $DOTFILES_DIR/Raycast.rayconfig${NC}"
fi

# Dygma keyboard (optional - only if needed)
if [ -d "/Applications/Bazecor.app" ]; then
    echo -e "\n${BLUE}Dygma keyboard configuration available...${NC}"
    echo -e "${YELLOW}Import settings from: $DOTFILES_DIR/dygama-raise-settings.json${NC}"
fi

echo -e "\n${GREEN}==================================${NC}"
echo -e "${GREEN}     Installation Complete!       ${NC}"
echo -e "${GREEN}==================================${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo -e "1. Edit ${BLUE}$DOTFILES_DIR/secrets.zsh${NC} and add your API keys"
echo -e "2. Restart your terminal or run: ${BLUE}source ~/.zshrc${NC}"
echo -e "3. If something went wrong, backups are in: ${BLUE}$BACKUP_DIR${NC}"
echo ""
echo -e "${GREEN}Happy coding! 🚀${NC}"