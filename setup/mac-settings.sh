#!/bin/bash

# Mac Settings Configuration
# This script applies custom Mac settings with backup functionality

# Configuration flags (set to "true" to enable, "false" to disable)
ENABLE_NEOVIM_KEYBOARD_SETTINGS="true"
DISABLE_ANIMATIONS="true"

echo "Mac Settings Configuration"
echo "=========================="
echo ""

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --no-keyboard)
            ENABLE_NEOVIM_KEYBOARD_SETTINGS="false"
            shift
            ;;
        --no-animations)
            DISABLE_ANIMATIONS="false"
            shift
            ;;
        --help)
            echo "Usage: $0 [options]"
            echo ""
            echo "Options:"
            echo "  --no-keyboard    Skip Neovim keyboard settings"
            echo "  --no-animations  Skip disabling animations"
            echo "  --help          Show this help message"
            echo ""
            echo "By default, all settings are applied."
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
done

# Check if backup script exists and run it
if [ -f "./backup-mac-settings.sh" ]; then
    echo "Creating backup of current settings..."
    ./backup-mac-settings.sh
    echo ""
else
    echo "Warning: backup-mac-settings.sh not found. Proceeding without backup."
    echo ""
fi

echo "Applying new Mac settings..."
echo ""

# Neovim Keyboard Settings Block
if [ "$ENABLE_NEOVIM_KEYBOARD_SETTINGS" = "true" ]; then
    echo "📝 Applying Neovim keyboard settings..."
    defaults write -g InitialKeyRepeat -int 11
    defaults write -g KeyRepeat -int 1
    defaults write -g ApplePressAndHoldEnabled -bool false
    echo "   ✓ Keyboard repeat rates optimized for Neovim"
    echo ""
fi

# Disable Animations Block
if [ "$DISABLE_ANIMATIONS" = "true" ]; then
    echo "🚀 Disabling system animations..."
    
    # Global animation settings
    defaults write -g NSScrollViewRubberbanding -int 0
    defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
    defaults write -g NSScrollAnimationEnabled -bool false
    defaults write -g NSWindowResizeTime -float 0.001
    defaults write -g QLPanelAnimationDuration -float 0
    defaults write -g NSScrollViewRubberbanding -bool false
    defaults write -g NSDocumentRevisionsWindowTransformAnimation -bool false
    defaults write -g NSToolbarFullScreenAnimationDuration -float 0
    defaults write -g NSBrowserColumnAnimationSpeedMultiplier -float 0
    defaults write NSGlobalDomain NSWindowResizeTime .001
    
    # Dock animations
    defaults write com.apple.dock autohide-time-modifier -float 0
    defaults write com.apple.dock autohide-delay -float 0
    defaults write com.apple.dock expose-animation-duration -float 0.1
    defaults write com.apple.dock springboard-show-duration -float 0
    defaults write com.apple.dock springboard-hide-duration -float 0
    defaults write com.apple.dock springboard-page-duration -float 0
    
    # Finder animations
    defaults write com.apple.finder DisableAllAnimations -bool true
    
    # Mail animations
    defaults write com.apple.Mail DisableSendAnimations -bool true
    defaults write com.apple.Mail DisableReplyAnimations -bool true
    
    # Restart Dock to apply changes
    killall Dock 2>/dev/null || true
    
    echo "   ✓ System animations disabled"
    echo ""
fi

echo "✅ Mac settings applied successfully!"
echo ""
echo "Note: You may need to restart your applications or log out for all changes to take effect."
echo ""
echo "To rollback these changes, use the restore script with your backup file:"
echo "  ./restore-mac-settings.sh ~/.dotfiles-backup/mac-settings-backup-<timestamp>.txt"
