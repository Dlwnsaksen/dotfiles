#!/bin/bash
# ============================================================
# Dotfiles Install Script
# Usage: ./install.sh
# ============================================================
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$DOTFILES_DIR/config"

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'
info()    { echo -e "${GREEN}[INFO]${NC} $1"; }
warn()    { echo -e "${YELLOW}[WARN]${NC} $1"; }
section() { echo -e "\n${GREEN}══ $1 ══${NC}"; }

# ── 1. Packages ───────────────────────────────────────────
section "Installing pacman packages"
grep -v '^#' "$DOTFILES_DIR/packages.txt" | grep -v '^$' | \
    sudo pacman -S --needed --noconfirm -

section "Installing AUR packages"
if ! command -v paru &>/dev/null; then
    warn "paru not found — installing..."
    tmpdir=$(mktemp -d)
    git clone https://aur.archlinux.org/paru.git "$tmpdir/paru"
    (cd "$tmpdir/paru" && makepkg -si --noconfirm)
    rm -rf "$tmpdir"
fi
grep -v '^#' "$DOTFILES_DIR/aur-packages.txt" | grep -v '^$' | \
    paru -S --needed --noconfirm -

# ── 2. Link configs ───────────────────────────────────────
section "Linking config files"

link() {
    local src="$1" dst="$2"
    mkdir -p "$(dirname "$dst")"
    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        warn "Backing up existing: $dst → $dst.bak"
        mv "$dst" "$dst.bak"
    fi
    ln -sfn "$src" "$dst"
    info "Linked: $dst"
}

link "$CONFIG_DIR/sway"      ~/.config/sway
link "$CONFIG_DIR/waybar"    ~/.config/waybar
link "$CONFIG_DIR/wofi"      ~/.config/wofi
link "$CONFIG_DIR/swaylock"  ~/.config/swaylock
link "$CONFIG_DIR/swaync"    ~/.config/swaync
link "$CONFIG_DIR/foot"      ~/.config/foot
link "$CONFIG_DIR/fish"      ~/.config/fish
link "$CONFIG_DIR/btop"      ~/.config/btop
link "$CONFIG_DIR/fastfetch" ~/.config/fastfetch

if [ -f "$CONFIG_DIR/starship.toml" ]; then
    link "$CONFIG_DIR/starship.toml" ~/.config/starship.toml
fi

# ── 3. Script permissions ────────────────────────────────
section "Setting script permissions"
chmod +x "$CONFIG_DIR/sway/scripts/"*.sh

# ── 4. Services ──────────────────────────────────────────
section "Enabling system services"
sudo systemctl enable --now NetworkManager
sudo systemctl enable --now bluetooth

systemctl --user enable --now pipewire pipewire-pulse wireplumber

# ── 5. User dirs ─────────────────────────────────────────
section "Setting up user directories"
xdg-user-dirs-update

# ── 6. Fish as default shell ─────────────────────────────
section "Setting fish as default shell"
FISH_PATH=$(which fish)
if ! grep -q "$FISH_PATH" /etc/shells; then
    echo "$FISH_PATH" | sudo tee -a /etc/shells
fi
if [ "$SHELL" != "$FISH_PATH" ]; then
    chsh -s "$FISH_PATH"
    info "Default shell set to fish (re-login to apply)"
fi

echo -e "\n${GREEN}✓ Install complete!${NC}"
echo "  → Log in to Sway via your display manager"
echo "  → Edit ~/.config/sway/config to customize"
