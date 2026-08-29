#!/usr/bin/env bash
set -e

DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.desktop_backup_$(date +%Y%m%d_%H%M%S)"

echo "=== 🚀 Desktop Environment Setup (Niri, DMS, Swaylock & Wallpaper) ==="

run_sudo() {
    if [ "$(id -u)" -eq 0 ]; then
        "$@"
    elif command -v sudo >/dev/null 2>&1; then
        if sudo -n true 2>/dev/null; then
            sudo "$@"
        else
            echo "Note: Sudo requires password or non-root environment. Running sudo..."
            sudo "$@" || echo "Warning: Package install via sudo skipped or failed."
        fi
    else
        echo "Warning: root/sudo privilege not available. Please ensure desktop packages are installed manually."
    fi
}

# ------------------------------------------------------------------------------
# 1. Auto-Update Repo jika ada pembaruan di GitHub
# ------------------------------------------------------------------------------
if [ -d "$DIR/.git" ]; then
    echo "Checking for upstream updates from GitHub..."
    if git -C "$DIR" remote get-url origin >/dev/null 2>&1; then
        git -C "$DIR" fetch origin main --quiet 2>/dev/null || true
        LOCAL_HASH=$(git -C "$DIR" rev-parse HEAD 2>/dev/null || true)
        REMOTE_HASH=$(git -C "$DIR" rev-parse origin/main 2>/dev/null || true)

        if [ -n "$REMOTE_HASH" ] && [ "$LOCAL_HASH" != "$REMOTE_HASH" ]; then
            echo "New updates found! Pulling latest desktop configs from GitHub..."
            git -C "$DIR" pull --rebase origin main || true
        else
            echo "Desktop configuration is up to date."
        fi
    fi
fi

# ------------------------------------------------------------------------------
# 2. Update Submodule Wallpaper jika ada
# ------------------------------------------------------------------------------
if [ -f "$DIR/.gitmodules" ] || [ -d "$DIR/wallpaper/.git" ]; then
    echo "Updating wallpapers submodule..."
    (cd "$DIR" && git submodule update --init --recursive || true)
fi

# ------------------------------------------------------------------------------
# 3. Deteksi Package Manager & Auto-Install Niri & Wayland Desktop Packages
# ------------------------------------------------------------------------------
install_packages() {
    if ! command -v niri >/dev/null 2>&1; then
        echo "Installing Niri WM & desktop utilities..."
        if command -v pacman >/dev/null 2>&1; then
            echo "-> Detected: Arch Linux"
            run_sudo pacman -Syu --needed --noconfirm niri dms-shell-niri swaylock xwayland-satellite polkit-gnome matugen
        elif command -v dnf >/dev/null 2>&1; then
            echo "-> Detected: Fedora (Copr)"
            run_sudo dnf copr enable -y yalter/niri || true
            run_sudo dnf install -y niri swaylock xwayland-satellite
        elif command -v nix-env >/dev/null 2>&1; then
            echo "-> Detected: NixOS"
            nix-env -iA nixpkgs.niri nixpkgs.swaylock
        elif command -v apt-get >/dev/null 2>&1; then
            echo "-> Detected: Debian / Ubuntu"
            echo "Note: Niri on Debian/Ubuntu can be built via cargo or installed via official .deb releases on GitHub."
        fi
    fi
}

install_packages

# ------------------------------------------------------------------------------
# 4. Safe Backup & Pasang Symlink (.config/niri, .config/DankMaterialShell, .config/swaylock, .config/wallpaper)
# ------------------------------------------------------------------------------
backup_and_link() {
    src="$1"
    dest="$2"
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        curr_target="$(readlink -f "$dest" 2>/dev/null || true)"
        src_target="$(readlink -f "$src" 2>/dev/null || true)"
        if [ "$curr_target" != "$src_target" ]; then
            mkdir -p "$BACKUP_DIR"
            echo "Backing up $dest -> $BACKUP_DIR/"
            mv "$dest" "$BACKUP_DIR/"
        fi
    fi
    ln -sfn "$src" "$dest"
}

mkdir -p "$HOME/.config" "$HOME/Pictures"

for item in niri DankMaterialShell swaylock wallpaper; do
    if [ -e "$DIR/$item" ]; then
        backup_and_link "$DIR/$item" "$HOME/.config/$item"
    fi
done

# Shortcut Wallpaper folder di Pictures
if [ -e "$DIR/wallpaper" ]; then
    ln -sfn "$HOME/.config/wallpaper" "$HOME/Pictures/Wallpapers"
fi

# Reload Niri config jika sedang berjalan
if command -v niri >/dev/null 2>&1; then
    niri msg action load-config-file 2>/dev/null || true
fi

echo "=== ✨ Desktop Environment Setup Complete & Up-To-Date! ==="
