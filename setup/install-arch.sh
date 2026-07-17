#!/usr/bin/env bash
#
# Arch Linux (CachyOS) installer — mirrors the macOS setup on Arch.
# Two independent phases: (1) install missing packages/tools, (2) link the
# dotfiles. The package phase is optional — decline the prompt or pass
# --links-only to just copy the configs. Anything already on your PATH is
# skipped. Every step is best-effort: a missing package warns and continues.
#
# Usage:  ./setup/install-arch.sh              # prompt, then install + link
#         ./setup/install-arch.sh -y           # install without prompting
#         ./setup/install-arch.sh --links-only # skip installs, just link configs
#
# ponytail: reuses the mac install.sh symlink logic verbatim; only the package
# manager, lazygit path, and shell-framework bootstrap differ per-platform.

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; NC='\033[0m'
info() { echo -e "${BLUE}$*${NC}"; }
ok()   { echo -e "${GREEN}✓ $*${NC}"; }
warn() { echo -e "${YELLOW}⚠ $*${NC}"; }
err()  { echo -e "${RED}✗ $*${NC}"; }

SETUP_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOTFILES_DIR="$(dirname "$SETUP_DIR")"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
LINKS_ONLY=0
ASSUME_YES=0
for arg in "$@"; do
    case "$arg" in
        --links-only|--no-install) LINKS_ONLY=1 ;;
        -y|--yes)                  ASSUME_YES=1 ;;
        -h|--help)
            echo "Usage: $(basename "$0") [--links-only] [-y]"
            echo "  (default)      prompt, then install missing packages and link configs"
            echo "  --links-only   skip all installs — just copy/link the configs"
            echo "  -y, --yes      install without prompting"
            exit 0 ;;
        *) warn "unknown option: $arg" ;;
    esac
done

if ! command -v pacman >/dev/null 2>&1; then
    err "pacman not found — this script targets Arch Linux / CachyOS."
    exit 1
fi

echo -e "${BLUE}==================================${NC}"
echo -e "${BLUE}  Dotfiles Installation (Arch)    ${NC}"
echo -e "${BLUE}==================================${NC}\n"

# ---------------------------------------------------------------------------
# Symlink helper (identical to setup/install.sh)
# ---------------------------------------------------------------------------
create_symlink() {
    local source="$1" target="$2"
    local parent_dir; parent_dir=$(dirname "$target")
    [ -d "$parent_dir" ] || { info "Creating directory: $parent_dir"; mkdir -p "$parent_dir"; }

    if [ -e "$target" ] && [ ! -L "$target" ]; then
        warn "Backing up existing $target"
        mkdir -p "$BACKUP_DIR"
        cp -r "$target" "$BACKUP_DIR/$(basename "$target")"
        rm -rf "$target"
    elif [ -L "$target" ]; then
        rm "$target"
    fi
    ln -s "$source" "$target"
    ok "Linked $source → $target"
}

# ---------------------------------------------------------------------------
# Packages (optional phase)
# ---------------------------------------------------------------------------
INSTALL_PKGS=1
[ "$LINKS_ONLY" -eq 1 ] && INSTALL_PKGS=0
# Interactive opt-out (skipped when piped/non-interactive or -y was passed).
if [ "$INSTALL_PKGS" -eq 1 ] && [ "$ASSUME_YES" -eq 0 ] && [ -t 0 ]; then
    read -r -p "$(echo -e "${YELLOW}Install missing packages/tools with pacman? [Y/n] ${NC}")" _ans
    [[ "$_ans" =~ ^[Nn] ]] && INSTALL_PKGS=0
fi
[ "$INSTALL_PKGS" -eq 0 ] && info "Skipping package installation — linking configs only.\n"

if [ "$INSTALL_PKGS" -eq 1 ]; then
    # Official repos → pacman. The few AUR-only extras are built with makepkg
    # directly, so no AUR helper (paru/yay) is required. Anything already on
    # PATH (or installed via pacman) is skipped.
    pkg_install() {  # official repos
        for p in "$@"; do
            if pacman -Qq "$p" &>/dev/null || command -v "$p" &>/dev/null; then
                ok "$p (already present)"; continue
            fi
            sudo pacman -S --needed --noconfirm "$p" && ok "$p" || warn "could not install $p (skipped)"
        done
    }

    aur_install() {  # build straight from the AUR, no helper needed
        for p in "$@"; do
            if pacman -Qq "$p" &>/dev/null || command -v "$p" &>/dev/null; then
                ok "$p (already present)"; continue
            fi
            local tmp; tmp=$(mktemp -d)
            if git clone --depth=1 "https://aur.archlinux.org/$p.git" "$tmp/$p" \
                && ( cd "$tmp/$p" && makepkg -si --noconfirm ); then
                ok "$p (AUR)"
            else
                warn "could not build $p — by hand: git clone https://aur.archlinux.org/$p.git && cd $p && makepkg -si"
            fi
            rm -rf "$tmp"
        done
    }

    # Full sync+upgrade first — partial upgrades (-Sy then -S) can break Arch.
    info "\nUpdating system (pacman -Syu)..."
    sudo pacman -Syu --noconfirm

    info "\nInstalling core packages (pacman)..."
    # brew formulae → official Arch packages. base-devel/git are needed for AUR builds.
    pkg_install base-devel git zsh neovim zellij nodejs npm go uv sqlite jq \
        lazygit bat lsd mosh ripgrep fd fzf github-cli glab chafa graphviz graphicsmagick \
        tree-sitter tree-sitter-cli ncurses libpng libjpeg-turbo wget curl unzip \
        wl-clipboard xclip tailscale ghostty ttf-firacode-nerd ttf-hack-nerd ttf-meslo-nerd ttf-ibm-plex

    # Tailscale needs its daemon running; enable it, then `sudo tailscale up`.
    if pacman -Qq tailscale &>/dev/null; then
        sudo systemctl enable --now tailscaled \
            && ok "tailscaled enabled (run: sudo tailscale up)" \
            || warn "enable it manually: sudo systemctl enable --now tailscaled"
    fi

    info "\nInstalling extras (AUR via makepkg)..."
    # Not in official repos; built directly — no paru/yay needed.
    aur_install lazysql bun-bin ngrok tinty pyenv

    # -- AI agents ----------------------------------------------------------
    info "\nInstalling AI coding agents..."
    if command -v npm >/dev/null 2>&1; then
        # keep global npm installs in ~/.local (already on PATH in zshrc), no sudo
        npm config set prefix "$HOME/.local" >/dev/null 2>&1
        npm install -g @anthropic-ai/claude-code && ok "claude-code" || warn "claude-code npm install failed"
    else
        warn "npm not available — skipping claude-code"
    fi
    if command -v opencode >/dev/null 2>&1; then
        ok "opencode (already installed)"
    else
        curl -fsSL https://opencode.ai/install | bash && ok "opencode" || warn "opencode install failed"
    fi
    warn "codex: install manually — 'npm i -g @openai/codex' or the AUR (brew has no Arch analog)"
    command -v herdr >/dev/null 2>&1 && ok "herdr (already installed)" \
        || warn "herdr: install separately (see herdr.dev); its config is linked either way"

    # -- Oh My Zsh + plugins ------------------------------------------------
    info "\nSetting up Oh My Zsh..."
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        RUNZSH=no CHSH=no sh -c \
            "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
            && ok "oh-my-zsh" || warn "oh-my-zsh install failed"
    else
        ok "oh-my-zsh (already installed)"
    fi

    ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
    clone_if_absent() {  # url  dest
        [ -d "$2" ] && { ok "$(basename "$2") (present)"; return; }
        git clone --depth=1 "$1" "$2" && ok "$(basename "$2")" || warn "clone failed: $1"
    }
    # zshrc loads these: zsh-autosuggestions + nx-completion as OMZ plugins,
    # zsh-syntax-highlighting sourced directly from ~/.config.
    clone_if_absent https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
    clone_if_absent https://github.com/zsh-users/zsh-syntax-highlighting "$HOME/.config/zsh-syntax-highlighting"
    clone_if_absent https://github.com/jscutlery/nx-completion "$ZSH_CUSTOM/plugins/nx-completion"

    # -- Default shell ------------------------------------------------------
    if command -v zsh >/dev/null 2>&1 && [ "$SHELL" != "$(command -v zsh)" ]; then
        info "\nSetting zsh as default shell..."
        chsh -s "$(command -v zsh)" && ok "default shell → zsh" \
            || warn "run manually: chsh -s $(command -v zsh)"
    fi
fi

# ---------------------------------------------------------------------------
# Secrets
# ---------------------------------------------------------------------------
info "\nSetting up secrets..."
if [ ! -f "$DOTFILES_DIR/shell/secrets.zsh" ]; then
    cp "$DOTFILES_DIR/shell/secrets.example.zsh" "$DOTFILES_DIR/shell/secrets.zsh"
    ok "Created secrets.zsh from example"
    warn "Edit shell/secrets.zsh and add your API keys"
else
    ok "secrets.zsh already exists"
fi

# ---------------------------------------------------------------------------
# Symlinks (Linux paths — lazygit differs from macOS)
# ---------------------------------------------------------------------------
info "\nSetting up shell configuration..."
create_symlink "$DOTFILES_DIR/shell/zshrc"       "$HOME/.zshrc"
create_symlink "$DOTFILES_DIR/shell/aliases"     "$HOME/.aliases"
create_symlink "$DOTFILES_DIR/shell/functions"   "$HOME/.functions"
create_symlink "$DOTFILES_DIR/shell/secrets.zsh" "$HOME/.secrets.zsh"

info "\nSetting up editors and terminals..."
create_symlink "$DOTFILES_DIR/nvim"      "$HOME/.config/nvim"
create_symlink "$DOTFILES_DIR/ghostty"   "$HOME/.config/ghostty"
create_symlink "$DOTFILES_DIR/alacritty" "$HOME/.config/alacritty"

# Warp (Linux uses ~/.warp, same as macOS)
mkdir -p "$HOME/.warp"
create_symlink "$DOTFILES_DIR/warp/keybindings.yaml" "$HOME/.warp/keybindings.yaml"
create_symlink "$DOTFILES_DIR/warp/themes"           "$HOME/.warp/themes"

# Zed
mkdir -p "$HOME/.config/zed/snippets"
create_symlink "$DOTFILES_DIR/zed/settings.json"            "$HOME/.config/zed/settings.json"
create_symlink "$DOTFILES_DIR/zed/keymap.json"              "$HOME/.config/zed/keymap.json"
create_symlink "$DOTFILES_DIR/zed/snippets/javascript.json" "$HOME/.config/zed/snippets/javascript.json"

# GitLab CLI
create_symlink "$DOTFILES_DIR/glab-cli/config.yml" "$HOME/.config/glab-cli/config.yml"

# Claude
create_symlink "$DOTFILES_DIR/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"

# Lazygit — Linux path is ~/.config/lazygit (vs macOS ~/Library/Application Support)
create_symlink "$DOTFILES_DIR/lazygit/config.yml" "$HOME/.config/lazygit/config.yml"

# herdr (terminal workspace manager) — link config + plugin settings only,
# leaving herdr's runtime sockets/logs and downloaded plugins/github untouched.
create_symlink "$DOTFILES_DIR/herdr/config.toml"    "$HOME/.config/herdr/config.toml"
create_symlink "$DOTFILES_DIR/herdr/plugins/config" "$HOME/.config/herdr/plugins/config"

echo -e "\n${GREEN}==================================${NC}"
echo -e "${GREEN}     Installation Complete!       ${NC}"
echo -e "${GREEN}==================================${NC}\n"
echo -e "${YELLOW}Next steps:${NC}"
echo -e "1. Edit ${BLUE}$DOTFILES_DIR/shell/secrets.zsh${NC} and add your API keys"
echo -e "2. Create ${BLUE}~/.claude/mcpservers.json${NC} if you use MCP servers"
echo -e "3. Restart your terminal (or run: ${BLUE}exec zsh${NC})"
[ -d "$BACKUP_DIR" ] && echo -e "4. Backups of replaced files are in: ${BLUE}$BACKUP_DIR${NC}"
echo -e "\n${GREEN}Happy coding on Arch! 🐧${NC}"
