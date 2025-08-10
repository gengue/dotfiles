#!/bin/bash

# Backup Mac Settings
# This script backs up the current Mac settings before applying new ones

BACKUP_DIR="$HOME/.dotfiles-backup"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DIR/mac-settings-backup-$TIMESTAMP.txt"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

echo "Backing up current Mac settings to: $BACKUP_FILE"
echo "Backup created on: $(date)" > "$BACKUP_FILE"
echo "================================" >> "$BACKUP_FILE"
echo "" >> "$BACKUP_FILE"

# Backup Neovim keyboard settings
echo "# Neovim Keyboard Settings" >> "$BACKUP_FILE"
echo "InitialKeyRepeat: $(defaults read -g InitialKeyRepeat 2>/dev/null || echo 'not set')" >> "$BACKUP_FILE"
echo "KeyRepeat: $(defaults read -g KeyRepeat 2>/dev/null || echo 'not set')" >> "$BACKUP_FILE"
echo "ApplePressAndHoldEnabled: $(defaults read -g ApplePressAndHoldEnabled 2>/dev/null || echo 'not set')" >> "$BACKUP_FILE"
echo "" >> "$BACKUP_FILE"

# Backup Animation Settings
echo "# Animation Settings" >> "$BACKUP_FILE"
echo "NSScrollViewRubberbanding: $(defaults read -g NSScrollViewRubberbanding 2>/dev/null || echo 'not set')" >> "$BACKUP_FILE"
echo "NSAutomaticWindowAnimationsEnabled: $(defaults read -g NSAutomaticWindowAnimationsEnabled 2>/dev/null || echo 'not set')" >> "$BACKUP_FILE"
echo "NSScrollAnimationEnabled: $(defaults read -g NSScrollAnimationEnabled 2>/dev/null || echo 'not set')" >> "$BACKUP_FILE"
echo "NSWindowResizeTime: $(defaults read -g NSWindowResizeTime 2>/dev/null || echo 'not set')" >> "$BACKUP_FILE"
echo "QLPanelAnimationDuration: $(defaults read -g QLPanelAnimationDuration 2>/dev/null || echo 'not set')" >> "$BACKUP_FILE"
echo "NSDocumentRevisionsWindowTransformAnimation: $(defaults read -g NSDocumentRevisionsWindowTransformAnimation 2>/dev/null || echo 'not set')" >> "$BACKUP_FILE"
echo "NSToolbarFullScreenAnimationDuration: $(defaults read -g NSToolbarFullScreenAnimationDuration 2>/dev/null || echo 'not set')" >> "$BACKUP_FILE"
echo "NSBrowserColumnAnimationSpeedMultiplier: $(defaults read -g NSBrowserColumnAnimationSpeedMultiplier 2>/dev/null || echo 'not set')" >> "$BACKUP_FILE"
echo "" >> "$BACKUP_FILE"

# Backup Dock Animation Settings
echo "# Dock Animation Settings" >> "$BACKUP_FILE"
echo "com.apple.dock.autohide-time-modifier: $(defaults read com.apple.dock autohide-time-modifier 2>/dev/null || echo 'not set')" >> "$BACKUP_FILE"
echo "com.apple.dock.autohide-delay: $(defaults read com.apple.dock autohide-delay 2>/dev/null || echo 'not set')" >> "$BACKUP_FILE"
echo "com.apple.dock.expose-animation-duration: $(defaults read com.apple.dock expose-animation-duration 2>/dev/null || echo 'not set')" >> "$BACKUP_FILE"
echo "com.apple.dock.springboard-show-duration: $(defaults read com.apple.dock springboard-show-duration 2>/dev/null || echo 'not set')" >> "$BACKUP_FILE"
echo "com.apple.dock.springboard-hide-duration: $(defaults read com.apple.dock springboard-hide-duration 2>/dev/null || echo 'not set')" >> "$BACKUP_FILE"
echo "com.apple.dock.springboard-page-duration: $(defaults read com.apple.dock springboard-page-duration 2>/dev/null || echo 'not set')" >> "$BACKUP_FILE"
echo "" >> "$BACKUP_FILE"

# Backup App-specific Animation Settings
echo "# App Animation Settings" >> "$BACKUP_FILE"
echo "com.apple.finder.DisableAllAnimations: $(defaults read com.apple.finder DisableAllAnimations 2>/dev/null || echo 'not set')" >> "$BACKUP_FILE"
echo "com.apple.Mail.DisableSendAnimations: $(defaults read com.apple.Mail DisableSendAnimations 2>/dev/null || echo 'not set')" >> "$BACKUP_FILE"
echo "com.apple.Mail.DisableReplyAnimations: $(defaults read com.apple.Mail DisableReplyAnimations 2>/dev/null || echo 'not set')" >> "$BACKUP_FILE"
echo "" >> "$BACKUP_FILE"

echo "✅ Backup completed: $BACKUP_FILE"
echo ""
echo "To restore these settings, run:"
echo "  ./restore-mac-settings.sh $BACKUP_FILE"