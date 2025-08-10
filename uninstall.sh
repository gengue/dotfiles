#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script is located
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo -e "${BLUE}==================================${NC}"
echo -e "${BLUE}     Dotfiles Uninstallation      ${NC}"
echo -e "${BLUE}==================================${NC}"
echo ""

# Function to remove symlink if it points to our dotfiles
remove_symlink() {
    local target="$1"
    
    if [ -L "$target" ]; then
        # Check if symlink points to our dotfiles directory
        local link_target=$(readlink "$target")
        if [[ "$link_target" == "$DOTFILES_DIR"* ]]; then
            rm "$target"
            echo -e "${GREEN}✓ Removed symlink: $target${NC}"
        else
            echo -e "${YELLOW}⚠ Skipping $target (points elsewhere)${NC}"
        fi
    elif [ -e "$target" ]; then
        echo -e "${YELLOW}⚠ Skipping $target (not a symlink)${NC}"
    fi
}

# Ask for confirmation
echo -e "${YELLOW}This will remove all symlinks created by the install script.${NC}"
echo -e "${YELLOW}Your secrets.zsh and mcpservers.json will be preserved.${NC}"
read -p "Are you sure you want to continue? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${RED}Uninstallation cancelled.${NC}"
    exit 1
fi

# Shell configuration files
echo -e "\n${BLUE}Removing shell configuration symlinks...${NC}"
remove_symlink "$HOME/.zshrc"
remove_symlink "$HOME/.aliases"
remove_symlink "$HOME/.functions"
remove_symlink "$HOME/.secrets.zsh"

# Neovim configuration
echo -e "\n${BLUE}Removing Neovim configuration symlink...${NC}"
remove_symlink "$HOME/.config/nvim"

# Terminal emulators
echo -e "\n${BLUE}Removing terminal emulator configuration symlinks...${NC}"
remove_symlink "$HOME/.config/ghostty"
remove_symlink "$HOME/.config/alacritty"

# Warp terminal
echo -e "\n${BLUE}Removing Warp terminal configuration symlinks...${NC}"
remove_symlink "$HOME/.warp/keybindings.yaml"
remove_symlink "$HOME/.warp/themes"

# Zed editor
echo -e "\n${BLUE}Removing Zed editor configuration symlink...${NC}"
remove_symlink "$HOME/.config/zed"

# GitLab CLI
echo -e "\n${BLUE}Removing GitLab CLI configuration symlink...${NC}"
remove_symlink "$HOME/.config/glab-cli"

# Claude configuration
echo -e "\n${BLUE}Removing Claude configuration symlinks...${NC}"
remove_symlink "$HOME/.claude/CLAUDE.md"
remove_symlink "$HOME/.claude/mcpservers.json"

# Preserve local files
echo -e "\n${BLUE}Preserved files:${NC}"
if [ -f "$DOTFILES_DIR/secrets.zsh" ]; then
    echo -e "${GREEN}✓ $DOTFILES_DIR/secrets.zsh (contains your API keys)${NC}"
fi
if [ -f "$DOTFILES_DIR/mcpservers.json" ]; then
    echo -e "${GREEN}✓ $DOTFILES_DIR/mcpservers.json (contains your MCP config)${NC}"
fi

echo -e "\n${GREEN}==================================${NC}"
echo -e "${GREEN}    Uninstallation Complete!      ${NC}"
echo -e "${GREEN}==================================${NC}"
echo ""

# Check for backup directories
BACKUP_COUNT=$(ls -d $HOME/.dotfiles-backup-* 2>/dev/null | wc -l)
if [ "$BACKUP_COUNT" -gt 0 ]; then
    echo -e "${YELLOW}Found $BACKUP_COUNT backup(s):${NC}"
    ls -d $HOME/.dotfiles-backup-* | while read backup; do
        echo -e "  ${BLUE}$backup${NC}"
    done
    echo ""
    echo -e "${YELLOW}To restore from a backup, manually copy files from the backup directory.${NC}"
fi

echo -e "${GREEN}Done! Your dotfiles have been unlinked.${NC}"