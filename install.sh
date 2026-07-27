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

# link <source> <destination>
#   Works for both files and directories. An existing real (non-symlink)
#   target is moved aside to <destination>.bak instead of being clobbered.
link() {
    local src="$1" dst="$2"
    if [ ! -e "$src" ]; then
        warn "Skipping (missing in repo): $src"
        return
    fi
    mkdir -p "$(dirname "$dst")"
    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        warn "Backing up existing: $dst → $dst.bak"
        mv "$dst" "$dst.bak"
    fi
    ln -sfn "$src" "$dst"
    info "Linked: $dst"
}

# ── Whole directories ────────────────────────────────────
# Safe to link wholesale: nothing else writes into these.
link "$CONFIG_DIR/sway"           ~/.config/sway
link "$CONFIG_DIR/swaylock"       ~/.config/swaylock
link "$CONFIG_DIR/foot"           ~/.config/foot
link "$CONFIG_DIR/fish"           ~/.config/fish
link "$CONFIG_DIR/fuzzel"         ~/.config/fuzzel
link "$CONFIG_DIR/btop"           ~/.config/btop
link "$CONFIG_DIR/environment.d"  ~/.config/environment.d

# ── Individual files ─────────────────────────────────────
# These directories also collect runtime-generated files (GTK bookmarks,
# swaync's own config.json, fcitx5's layout cache …), so only the tracked
# files get linked — linking the whole directory would drag that generated
# state into the repo.
link "$CONFIG_DIR/starship.toml"        ~/.config/starship.toml
link "$CONFIG_DIR/mimeapps.list"        ~/.config/mimeapps.list

link "$CONFIG_DIR/swaync/style.css"     ~/.config/swaync/style.css

link "$CONFIG_DIR/gtk-3.0/settings.ini" ~/.config/gtk-3.0/settings.ini
link "$CONFIG_DIR/gtk-3.0/gtk.css"      ~/.config/gtk-3.0/gtk.css
link "$CONFIG_DIR/gtk-4.0/settings.ini" ~/.config/gtk-4.0/settings.ini
link "$CONFIG_DIR/gtk-4.0/gtk.css"      ~/.config/gtk-4.0/gtk.css

link "$CONFIG_DIR/fcitx5/config"                  ~/.config/fcitx5/config
link "$CONFIG_DIR/fcitx5/profile"                 ~/.config/fcitx5/profile
link "$CONFIG_DIR/fcitx5/conf/hangul.conf"        ~/.config/fcitx5/conf/hangul.conf
link "$CONFIG_DIR/fcitx5/conf/notifications.conf" ~/.config/fcitx5/conf/notifications.conf

# ── 2b. Autostart entries ────────────────────────────────
# XDG autostart launcher, not a config file — copied, not linked.
mkdir -p ~/.config/sway/conf.d

section "Installing autostart entries"
mkdir -p ~/.config/autostart
if [ -f /usr/share/applications/org.fcitx.Fcitx5.desktop ]; then
    cp -n /usr/share/applications/org.fcitx.Fcitx5.desktop \
          ~/.config/autostart/fcitx5.desktop || true
    info "Autostart: fcitx5"
else
    warn "fcitx5 desktop entry not found — skipped"
fi

# ── 3. Script permissions ────────────────────────────────
section "Setting script permissions"
chmod +x "$CONFIG_DIR/sway/scripts/"*.sh 2>/dev/null || true

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
echo "  → Wallpaper: place your own at ~/.config/sway/wallpaper"
echo "  → Host-specific tweaks go in ~/.config/sway/conf.d/*.conf"
