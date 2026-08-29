#!/usr/bin/env sh
set -e

DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.ghostty_backup_$(date +%Y%m%d_%H%M%S)"

echo "=== 🚀 Ghostty Terminal Setup (Cross-Platform & Auto-Updater) ==="

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
            echo "New updates found! Pulling latest ghostty configs from GitHub..."
            git -C "$DIR" pull --rebase origin main || true
        else
            echo "Ghostty configuration is up to date."
        fi
    fi
fi

# ------------------------------------------------------------------------------
# 2. Deteksi Package Manager & Auto-Install Ghostty jika belum ada
# ------------------------------------------------------------------------------
install_packages() {
    if ! command -v ghostty >/dev/null 2>&1; then
        echo "Installing ghostty terminal..."
        if command -v pacman >/dev/null 2>&1; then
            echo "-> Detected: Arch Linux"
            sudo pacman -Syu --needed --noconfirm ghostty git
        elif command -v brew >/dev/null 2>&1; then
            echo "-> Detected: macOS (Homebrew)"
            brew install --cask ghostty
        elif command -v dnf >/dev/null 2>&1; then
            echo "-> Detected: Fedora (Copr)"
            sudo dnf copr enable -y pgdev/ghostty || true
            sudo dnf install -y ghostty git
        elif command -v nix-env >/dev/null 2>&1; then
            echo "-> Detected: NixOS"
            nix-env -iA nixpkgs.ghostty
        else
            echo "Note: Please install ghostty package for your OS if not already available."
        fi
    fi
}

install_packages

# ------------------------------------------------------------------------------
# 3. Safe Backup & Pasang Symlink ~/.config/ghostty
# ------------------------------------------------------------------------------
DEST="$HOME/.config/ghostty"
SRC="$DIR/config"
mkdir -p "$HOME/.config"

if [ -e "$DEST" ] || [ -L "$DEST" ]; then
    curr_target="$(readlink -f "$DEST" 2>/dev/null || true)"
    src_target="$(readlink -f "$SRC" 2>/dev/null || true)"
    if [ "$curr_target" != "$src_target" ]; then
        mkdir -p "$BACKUP_DIR"
        echo "Backing up $DEST -> $BACKUP_DIR/"
        mv "$DEST" "$BACKUP_DIR/"
    fi
fi

ln -sfn "$SRC" "$DEST"

echo "=== ✨ Ghostty Terminal Setup Complete & Up-To-Date! ==="
