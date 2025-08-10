#!/bin/bash

# Restore Mac Settings
# This script restores Mac settings from a backup file

if [ -z "$1" ]; then
    echo "Usage: $0 <backup-file>"
    echo ""
    echo "Available backups:"
    ls -la ~/.dotfiles-backup/mac-settings-backup-*.txt 2>/dev/null
    exit 1
fi

BACKUP_FILE="$1"

if [ ! -f "$BACKUP_FILE" ]; then
    echo "Error: Backup file not found: $BACKUP_FILE"
    exit 1
fi

echo "Restoring Mac settings from: $BACKUP_FILE"
echo ""

# Helper function to restore a setting
restore_setting() {
    local key="$1"
    local domain="$2"
    local type="$3"
    local grep_pattern="$4"
    
    local value=$(grep "$grep_pattern" "$BACKUP_FILE" | sed 's/.*: //')
    
    if [ "$value" != "not set" ] && [ -n "$value" ]; then
        case "$type" in
            "int")
                echo "  Restoring $key to: $value"
                if [ -z "$domain" ]; then
                    defaults write -g "$key" -int "$value"
                else
                    defaults write "$domain" "$key" -int "$value"
                fi
                ;;
            "float")
                echo "  Restoring $key to: $value"
                if [ -z "$domain" ]; then
                    defaults write -g "$key" -float "$value"
                else
                    defaults write "$domain" "$key" -float "$value"
                fi
                ;;
            "bool")
                if [ "$value" = "1" ] || [ "$value" = "true" ]; then
                    echo "  Restoring $key to: true"
                    if [ -z "$domain" ]; then
                        defaults write -g "$key" -bool true
                    else
                        defaults write "$domain" "$key" -bool true
                    fi
                else
                    echo "  Restoring $key to: false"
                    if [ -z "$domain" ]; then
                        defaults write -g "$key" -bool false
                    else
                        defaults write "$domain" "$key" -bool false
                    fi
                fi
                ;;
        esac
    else
        echo "  Removing $key setting (was not set)"
        if [ -z "$domain" ]; then
            defaults delete -g "$key" 2>/dev/null
        else
            defaults delete "$domain" "$key" 2>/dev/null
        fi
    fi
}

echo "📝 Restoring Neovim keyboard settings..."
restore_setting "InitialKeyRepeat" "" "int" "^InitialKeyRepeat:"
restore_setting "KeyRepeat" "" "int" "^KeyRepeat:"
restore_setting "ApplePressAndHoldEnabled" "" "bool" "^ApplePressAndHoldEnabled:"
echo ""

echo "🚀 Restoring animation settings..."
restore_setting "NSScrollViewRubberbanding" "" "int" "^NSScrollViewRubberbanding:"
restore_setting "NSAutomaticWindowAnimationsEnabled" "" "bool" "^NSAutomaticWindowAnimationsEnabled:"
restore_setting "NSScrollAnimationEnabled" "" "bool" "^NSScrollAnimationEnabled:"
restore_setting "NSWindowResizeTime" "" "float" "^NSWindowResizeTime:"
restore_setting "QLPanelAnimationDuration" "" "float" "^QLPanelAnimationDuration:"
restore_setting "NSDocumentRevisionsWindowTransformAnimation" "" "bool" "^NSDocumentRevisionsWindowTransformAnimation:"
restore_setting "NSToolbarFullScreenAnimationDuration" "" "float" "^NSToolbarFullScreenAnimationDuration:"
restore_setting "NSBrowserColumnAnimationSpeedMultiplier" "" "float" "^NSBrowserColumnAnimationSpeedMultiplier:"
echo ""

echo "🎯 Restoring Dock animation settings..."
restore_setting "autohide-time-modifier" "com.apple.dock" "float" "com.apple.dock.autohide-time-modifier:"
restore_setting "autohide-delay" "com.apple.dock" "float" "com.apple.dock.autohide-delay:"
restore_setting "expose-animation-duration" "com.apple.dock" "float" "com.apple.dock.expose-animation-duration:"
restore_setting "springboard-show-duration" "com.apple.dock" "float" "com.apple.dock.springboard-show-duration:"
restore_setting "springboard-hide-duration" "com.apple.dock" "float" "com.apple.dock.springboard-hide-duration:"
restore_setting "springboard-page-duration" "com.apple.dock" "float" "com.apple.dock.springboard-page-duration:"
echo ""

echo "📂 Restoring app-specific animation settings..."
restore_setting "DisableAllAnimations" "com.apple.finder" "bool" "com.apple.finder.DisableAllAnimations:"
restore_setting "DisableSendAnimations" "com.apple.Mail" "bool" "com.apple.Mail.DisableSendAnimations:"
restore_setting "DisableReplyAnimations" "com.apple.Mail" "bool" "com.apple.Mail.DisableReplyAnimations:"
echo ""

# Restart Dock if any dock settings were changed
if grep -q "com.apple.dock" "$BACKUP_FILE"; then
    echo "Restarting Dock to apply changes..."
    killall Dock 2>/dev/null || true
fi

echo ""
echo "✅ Settings restored successfully!"
echo "Note: You may need to restart your applications or log out for all changes to take effect."