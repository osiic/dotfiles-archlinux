#!/usr/bin/env sh
set -e

DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.vim_backup_$(date +%Y%m%d_%H%M%S)"

echo "=== 🚀 Minimal IDE Vim (Cross-Platform & Auto-Updater) ==="

# ------------------------------------------------------------------------------
# 1. Update Repo jika sudah ada koneksi Git ke Remote
# ------------------------------------------------------------------------------
if [ -d "$DIR/.git" ]; then
    echo "Checking for upstream updates from GitHub..."
    if git -C "$DIR" remote get-url origin >/dev/null 2>&1; then
        git -C "$DIR" fetch origin main --quiet 2>/dev/null || true
        LOCAL_HASH=$(git -C "$DIR" rev-parse HEAD 2>/dev/null || true)
        REMOTE_HASH=$(git -C "$DIR" rev-parse origin/main 2>/dev/null || true)

        if [ -n "$REMOTE_HASH" ] && [ "$LOCAL_HASH" != "$REMOTE_HASH" ]; then
            echo "New updates found! Pulling latest config from GitHub..."
            git -C "$DIR" pull --rebase origin main || true
        else
            echo "Vim configuration is up to date."
        fi
    fi
fi

# ------------------------------------------------------------------------------
# 2. Deteksi Package Manager & Auto-Install Vim + Git
# ------------------------------------------------------------------------------
install_packages() {
    if ! command -v vim >/dev/null 2>&1 || ! command -v git >/dev/null 2>&1; then
        echo "Installing required packages (vim, git)..."
        if command -v pkg >/dev/null 2>&1; then
            echo "-> Detected: Termux (Android)"
            pkg update -y && pkg install -y vim git
        elif command -v apt-get >/dev/null 2>&1; then
            echo "-> Detected: Debian / Ubuntu / Mint / PopOS"
            sudo apt-get update -y && sudo apt-get install -y vim git
        elif command -v pacman >/dev/null 2>&1; then
            echo "-> Detected: Arch Linux / Manjaro / EndeavourOS"
            sudo pacman -Syu --needed --noconfirm vim git
        elif command -v emerge >/dev/null 2>&1; then
            echo "-> Detected: Gentoo"
            sudo emerge --ask=n app-editors/vim dev-vcs/git
        elif command -v dnf >/dev/null 2>&1; then
            echo "-> Detected: Fedora / RHEL / CentOS"
            sudo dnf install -y vim git
        elif command -v zypper >/dev/null 2>&1; then
            echo "-> Detected: openSUSE"
            sudo zypper install -y vim git
        elif command -v apk >/dev/null 2>&1; then
            echo "-> Detected: Alpine Linux"
            sudo apk add vim git
        elif command -v xbps-install >/dev/null 2>&1; then
            echo "-> Detected: Void Linux"
            sudo xbps-install -Sy vim git
        elif command -v nix-env >/dev/null 2>&1; then
            echo "-> Detected: NixOS"
            nix-env -iA nixpkgs.vim nixpkgs.git
        elif command -v brew >/dev/null 2>&1; then
            echo "-> Detected: macOS (Homebrew)"
            brew install vim git
        else
            echo "Warning: No supported package manager found. Please ensure vim & git are installed."
        fi
    fi
}

install_packages

# ------------------------------------------------------------------------------
# 3. Direktori Undo History
# ------------------------------------------------------------------------------
mkdir -p "$HOME/.vim/undo"

# ------------------------------------------------------------------------------
# 4. Safe Backup .vimrc lama jika ada file non-symlink
# ------------------------------------------------------------------------------
if [ -f "$HOME/.vimrc" ] || [ -L "$HOME/.vimrc" ]; then
    CURRENT_TARGET="$(readlink -f "$HOME/.vimrc" 2>/dev/null || true)"
    SRC_TARGET="$(readlink -f "$DIR/.vimrc" 2>/dev/null || true)"
    if [ "$CURRENT_TARGET" != "$SRC_TARGET" ]; then
        mkdir -p "$BACKUP_DIR"
        echo "Backing up existing ~/.vimrc -> $BACKUP_DIR/"
        mv "$HOME/.vimrc" "$BACKUP_DIR/"
    fi
fi

# ------------------------------------------------------------------------------
# 5. Pasang Symlink .vimrc
# ------------------------------------------------------------------------------
ln -sfn "$DIR/.vimrc" "$HOME/.vimrc"

echo "=== ✨ Vim Minimal IDE Ready & Up-To-Date! ==="
echo "Run 'vim' | Open File Tree: <Space>e"
