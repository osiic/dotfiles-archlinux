#!/usr/bin/env bash
set -e

DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.nvim_backup_$(date +%Y%m%d_%H%M%S)"

echo "=== 🚀 Neovim IDE Setup (Cross-Platform & Auto-Updater) ==="

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
        echo "Warning: root/sudo privilege not available. Please ensure packages are installed manually."
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
            echo "New updates found! Pulling latest config from GitHub..."
            git -C "$DIR" pull --rebase origin main || true
        else
            echo "Neovim configuration is up to date."
        fi
    fi
fi

# ------------------------------------------------------------------------------
# 2. Deteksi Package Manager & Auto-Install Neovim + Tools jika belum ada
# ------------------------------------------------------------------------------
install_packages() {
    NEEDS_INSTALL=0
    if ! command -v nvim >/dev/null 2>&1 || ! command -v git >/dev/null 2>&1; then
        NEEDS_INSTALL=1
    fi

    if [ "$NEEDS_INSTALL" -eq 1 ]; then
        echo "Installing required packages..."
        if command -v pkg >/dev/null 2>&1; then
            echo "-> Detected: Termux (Android)"
            pkg update -y && pkg install -y neovim git ripgrep fd nodejs-lts python
        elif command -v apt-get >/dev/null 2>&1; then
            echo "-> Detected: Debian / Ubuntu / Mint / PopOS"
            DEBIAN_FRONTEND=noninteractive run_sudo apt-get update -y
            DEBIAN_FRONTEND=noninteractive run_sudo apt-get install -y --no-install-recommends neovim git ripgrep fd-find nodejs npm python3-pip luarocks
        elif command -v pacman >/dev/null 2>&1; then
            echo "-> Detected: Arch Linux / Manjaro / EndeavourOS"
            run_sudo pacman -Syu --needed --noconfirm neovim git ripgrep fd nodejs npm python-pip luarocks
        elif command -v emerge >/dev/null 2>&1; then
            echo "-> Detected: Gentoo"
            run_sudo emerge --ask=n app-editors/neovim dev-vcs/git sys-apps/ripgrep sys-apps/fd net-libs/nodejs
        elif command -v dnf >/dev/null 2>&1; then
            echo "-> Detected: Fedora / RHEL / CentOS"
            run_sudo dnf install -y neovim git ripgrep fd-find nodejs npm
        elif command -v zypper >/dev/null 2>&1; then
            echo "-> Detected: openSUSE"
            run_sudo zypper --non-interactive install -y neovim git ripgrep fd nodejs npm
        elif command -v apk >/dev/null 2>&1; then
            echo "-> Detected: Alpine Linux"
            run_sudo apk add neovim git ripgrep fd nodejs npm
        elif command -v xbps-install >/dev/null 2>&1; then
            echo "-> Detected: Void Linux"
            run_sudo xbps-install -Sy neovim git ripgrep fd nodejs
        elif command -v nix-env >/dev/null 2>&1; then
            echo "-> Detected: NixOS"
            nix-env -iA nixpkgs.neovim nixpkgs.git nixpkgs.ripgrep nixpkgs.fd nixpkgs.nodejs
        elif command -v brew >/dev/null 2>&1; then
            echo "-> Detected: macOS (Homebrew)"
            brew install neovim git ripgrep fd node
        else
            echo "Warning: No supported package manager found. Please install neovim & git manually."
        fi
    fi
}

install_packages

# ------------------------------------------------------------------------------
# 3. Safe Backup ~/.config/nvim jika ada folder non-symlink
# ------------------------------------------------------------------------------
DEST="$HOME/.config/nvim"
mkdir -p "$HOME/.config"

if [ -e "$DEST" ] || [ -L "$DEST" ]; then
    CURRENT_TARGET="$(readlink -f "$DEST" 2>/dev/null || true)"
    SRC_TARGET="$(readlink -f "$DIR" 2>/dev/null || true)"
    if [ "$CURRENT_TARGET" != "$SRC_TARGET" ]; then
        mkdir -p "$BACKUP_DIR"
        echo "Backing up existing ~/.config/nvim -> $BACKUP_DIR/"
        mv "$DEST" "$BACKUP_DIR/"
    fi
fi

# ------------------------------------------------------------------------------
# 4. Pasang Symlink ~/.config/nvim
# ------------------------------------------------------------------------------
ln -sfn "$DIR" "$DEST"

# ------------------------------------------------------------------------------
# 5. Auto sync plugin via lazy.nvim (Headless)
# ------------------------------------------------------------------------------
if command -v nvim >/dev/null 2>&1; then
    echo "Syncing plugins via lazy.nvim..."
    nvim --headless "+Lazy! sync" +qa 2>/dev/null || true
fi

echo "=== ✨ Neovim IDE Ready & Up-To-Date! ==="
echo "Run 'nvim' | File Tree: <Space>e | Telescope: <Space>ff"
