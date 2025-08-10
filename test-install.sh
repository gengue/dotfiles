#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

# Get the directory where this script is located
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TEST_HOME="/tmp/dotfiles-test-home"
BACKUP_DIR="$TEST_HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

echo -e "${MAGENTA}==================================${NC}"
echo -e "${MAGENTA}   Dotfiles TEST Installation     ${NC}"
echo -e "${MAGENTA}==================================${NC}"
echo -e "${YELLOW}Testing in: $TEST_HOME${NC}"
echo ""

# Create test environment
echo -e "${BLUE}Setting up test environment...${NC}"
rm -rf "$TEST_HOME"
mkdir -p "$TEST_HOME"
mkdir -p "$TEST_HOME/.config"
mkdir -p "$TEST_HOME/.warp"
mkdir -p "$TEST_HOME/.claude"

# Create some fake existing configs to test backup
echo "existing zshrc" > "$TEST_HOME/.zshrc"
echo "existing aliases" > "$TEST_HOME/.aliases"
mkdir -p "$TEST_HOME/.config/nvim"
echo "existing nvim config" > "$TEST_HOME/.config/nvim/init.lua"

echo -e "${GREEN}✓ Test environment created${NC}"

# Create backup directory
echo -e "${YELLOW}Creating backup directory: $BACKUP_DIR${NC}"
mkdir -p "$BACKUP_DIR"

# Function to create a symlink with backup (TEST VERSION)
create_symlink() {
    local source="$1"
    local target="$2"
    
    # Replace $HOME with $TEST_HOME for testing
    target="${target/$HOME/$TEST_HOME}"
    
    echo -e "${BLUE}Would create symlink:${NC}"
    echo -e "  Source: ${GREEN}$source${NC}"
    echo -e "  Target: ${GREEN}$target${NC}"
    
    # Create parent directory if it doesn't exist
    local parent_dir=$(dirname "$target")
    if [ ! -d "$parent_dir" ]; then
        echo -e "  ${YELLOW}Would create directory: $parent_dir${NC}"
        mkdir -p "$parent_dir"
    fi
    
    # If target exists and is not a symlink, back it up
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo -e "  ${YELLOW}Would backup existing: $target${NC}"
        cp -r "$target" "$BACKUP_DIR/$(basename "$target")"
        echo -e "  ${YELLOW}Would remove: $target${NC}"
        rm -rf "$target"
    elif [ -L "$target" ]; then
        echo -e "  ${YELLOW}Would remove existing symlink: $target${NC}"
        rm "$target"
    fi
    
    # Create symlink
    ln -s "$source" "$target"
    if [ -L "$target" ]; then
        echo -e "  ${GREEN}✓ Created test symlink${NC}"
    fi
    echo ""
}

# Handle secrets file
echo -e "\n${BLUE}Testing secrets setup...${NC}"
if [ ! -f "$DOTFILES_DIR/secrets.zsh" ]; then
    echo -e "${YELLOW}Would copy secrets.example.zsh to secrets.zsh${NC}"
    echo -e "${YELLOW}⚠ User would need to edit secrets.zsh and add API keys${NC}"
else
    echo -e "${GREEN}✓ secrets.zsh already exists${NC}"
fi

# Handle mcpservers.json
echo -e "\n${BLUE}Testing MCP servers configuration...${NC}"
if [ ! -f "$DOTFILES_DIR/mcpservers.json" ]; then
    echo -e "${YELLOW}Would copy mcpservers.example.json to mcpservers.json${NC}"
else
    echo -e "${GREEN}✓ mcpservers.json already exists${NC}"
fi

# Test all symlinks
echo -e "\n${BLUE}Testing symlink creation...${NC}"
echo -e "${MAGENTA}---Shell Configuration---${NC}"
create_symlink "$DOTFILES_DIR/zshrc" "$HOME/.zshrc"
create_symlink "$DOTFILES_DIR/aliases" "$HOME/.aliases"
create_symlink "$DOTFILES_DIR/functions" "$HOME/.functions"
create_symlink "$DOTFILES_DIR/secrets.zsh" "$HOME/.secrets.zsh"

echo -e "${MAGENTA}---Application Configurations---${NC}"
create_symlink "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
create_symlink "$DOTFILES_DIR/ghostty" "$HOME/.config/ghostty"
create_symlink "$DOTFILES_DIR/alacritty" "$HOME/.config/alacritty"
create_symlink "$DOTFILES_DIR/warp/keybindings.yaml" "$HOME/.warp/keybindings.yaml"
create_symlink "$DOTFILES_DIR/warp/themes" "$HOME/.warp/themes"
create_symlink "$DOTFILES_DIR/zed" "$HOME/.config/zed"
create_symlink "$DOTFILES_DIR/glab-cli" "$HOME/.config/glab-cli"
create_symlink "$DOTFILES_DIR/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
create_symlink "$DOTFILES_DIR/mcpservers.json" "$HOME/.claude/mcpservers.json"

# Verify test results
echo -e "\n${MAGENTA}==================================${NC}"
echo -e "${MAGENTA}        Test Results              ${NC}"
echo -e "${MAGENTA}==================================${NC}"

echo -e "\n${BLUE}Created symlinks in test environment:${NC}"
find "$TEST_HOME" -type l -exec ls -la {} \; 2>/dev/null | while read line; do
    echo -e "  ${GREEN}$line${NC}"
done

echo -e "\n${BLUE}Backed up files:${NC}"
if [ -d "$BACKUP_DIR" ] && [ "$(ls -A $BACKUP_DIR)" ]; then
    ls -la "$BACKUP_DIR" | tail -n +2 | while read line; do
        echo -e "  ${YELLOW}$line${NC}"
    done
else
    echo -e "  ${YELLOW}No files backed up (none existed)${NC}"
fi

echo -e "\n${GREEN}==================================${NC}"
echo -e "${GREEN}      Test Complete!              ${NC}"
echo -e "${GREEN}==================================${NC}"
echo -e "${YELLOW}Test environment location: $TEST_HOME${NC}"
echo -e "${YELLOW}You can inspect the test setup before cleaning up${NC}"
echo -e "${YELLOW}To clean up: rm -rf $TEST_HOME${NC}"
echo ""
echo -e "${GREEN}If everything looks good, run: ./install.sh${NC}"