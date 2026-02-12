#!/bin/bash

# Ghostty command to open a new window/tab running the nvim cursor command for apps that don't support neovim terminal natively
# open -na Ghostty.app --args -e bash -c "$cmd"
# This script dynamically open ghostty and neovim with the provided file like: open -na Ghostty.app --args -e nvim "/Users/genesis/workspace/dotfiles/README.md"
# export EDITOR="$HOME/.local/bin/react-editor.sh"
# To use it as a mac app:

# 1. Open Automator
# 2. Create new "Application"
# 3. Add "Run Shell Script" action
# 4. Set "Pass input" to "as arguments"
# 5.Paste:
# for f in "$@"; do
#   ~/.local/bin/react-editor "$f"
# done
# 6. Save as NeoVimGhostty.app in /Applications
# Then:
# macOS Gatekeeper is quarantining the unsigned app. Remove the quarantine attribute:
# xattr -cr /Applications/NeoVimGhostty.app
# or try: 
# codesign --force --deep --sign - /Applications/NeoVimGhostty.app


input="$1"

# Parse path:line:column format
path=$(echo "$input" | cut -d: -f1)
line=$(echo "$input" | cut -d: -f2)
column=$(echo "$input" | cut -d: -f3)

# Resolve relative paths
if [[ "$path" != /* ]]; then
  path="$(pwd)/$path"
fi

# Build nvim command
if [[ -n "$column" && "$column" =~ ^[0-9]+$ ]]; then
  cmd="nvim +\"call cursor($line,$column)\" \"$path\""
elif [[ -n "$line" && "$line" =~ ^[0-9]+$ ]]; then
  cmd="nvim +$line \"$path\""
else
  cmd="nvim \"$path\""
fi

open -na Ghostty.app --args -e zsh -l -c "$cmd"
