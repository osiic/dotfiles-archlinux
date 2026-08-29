#!/usr/bin/env bash
set -e

DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.vim_backup_$(date +%Y%m%d_%H%M%S)"

echo "=== 🚀 Minimal IDE Vim (Cross-Platform & Auto-Updater) ==="

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
        echo "Warning: root/sudo privilege not available. Please ensure vim & git are installed manually."
    fi
}

# ------------------------------------------------------------------------------
# 1. Auto-Update Repo jika ada koneksi Git ke Remote
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
    NEEDS_INSTALL=0
    if ! command -v vim >/dev/null 2>&1 || ! command -v git >/dev/null 2>&1; then
        NEEDS_INSTALL=1
    fi

    if [ "$NEEDS_INSTALL" -eq 1 ]; then
        echo "Installing required packages (vim, git)..."
        if command -v pkg >/dev/null 2>&1; then
            echo "-> Detected: Termux (Android)"
            pkg update -y && pkg install -y vim git
        elif command -v apt-get >/dev/null 2>&1; then
            echo "-> Detected: Debian / Ubuntu / Mint / PopOS"
            DEBIAN_FRONTEND=noninteractive run_sudo apt-get update -y
            DEBIAN_FRONTEND=noninteractive run_sudo apt-get install -y --no-install-recommends vim git
        elif command -v pacman >/dev/null 2>&1; then
            echo "-> Detected: Arch Linux / Manjaro / EndeavourOS"
            run_sudo pacman -Syu --needed --noconfirm vim git
        elif command -v emerge >/dev/null 2>&1; then
            echo "-> Detected: Gentoo"
            run_sudo emerge --ask=n app-editors/vim dev-vcs/git
        elif command -v dnf >/dev/null 2>&1; then
            echo "-> Detected: Fedora / RHEL / CentOS"
            run_sudo dnf install -y vim git
        elif command -v zypper >/dev/null 2>&1; then
            echo "-> Detected: openSUSE"
            run_sudo zypper --non-interactive install -y vim git
        elif command -v apk >/dev/null 2>&1; then
            echo "-> Detected: Alpine Linux"
            run_sudo apk add vim git
        elif command -v xbps-install >/dev/null 2>&1; then
            echo "-> Detected: Void Linux"
            run_sudo xbps-install -Sy vim git
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
