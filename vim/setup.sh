#!/usr/bin/env sh
set -e

DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.vim_backup_$(date +%Y%m%d_%H%M%S)"

echo "=== 🚀 Installing Minimal IDE Vim (Cross-Platform / Multi-Distro) ==="

# 1. Deteksi Package Manager & Install Vim jika belum ada
if ! command -v vim >/dev/null 2>&1; then
    echo "Vim not found. Attempting to install..."
    if command -v pkg >/dev/null 2>&1; then
        echo "Detected Termux (Android). Installing vim..."
        pkg update -y && pkg install -y vim git
    elif command -v apt-get >/dev/null 2>&1; then
        echo "Detected Debian/Ubuntu/Mint. Installing vim..."
        sudo apt-get update -y && sudo apt-get install -y vim git
    elif command -v pacman >/dev/null 2>&1; then
        echo "Detected Arch Linux. Installing vim..."
        sudo pacman -Syu --needed --noconfirm vim git
    elif command -v emerge >/dev/null 2>&1; then
        echo "Detected Gentoo. Installing vim..."
        sudo emerge --ask=n app-editors/vim
    elif command -v dnf >/dev/null 2>&1; then
        echo "Detected Fedora/RHEL. Installing vim..."
        sudo dnf install -y vim git
    elif command -v zypper >/dev/null 2>&1; then
        echo "Detected openSUSE. Installing vim..."
        sudo zypper install -y vim git
    elif command -v apk >/dev/null 2>&1; then
        echo "Detected Alpine Linux. Installing vim..."
        sudo apk add vim git
    elif command -v brew >/dev/null 2>&1; then
        echo "Detected macOS (Homebrew). Installing vim..."
        brew install vim git
    else
        echo "Warning: Package manager not recognized. Please install vim manually."
    fi
fi

# 2. Buat direktori undo history
mkdir -p "$HOME/.vim/undo"

# 3. Backup .vimrc lama jika ada dan bukan symlink yang sama
if [ -f "$HOME/.vimrc" ] || [ -L "$HOME/.vimrc" ]; then
    CURRENT_TARGET="$(readlink -f "$HOME/.vimrc" 2>/dev/null || true)"
    SRC_TARGET="$(readlink -f "$DIR/.vimrc" 2>/dev/null || true)"
    if [ "$CURRENT_TARGET" != "$SRC_TARGET" ]; then
        mkdir -p "$BACKUP_DIR"
        echo "Backing up existing ~/.vimrc to $BACKUP_DIR/"
        mv "$HOME/.vimrc" "$BACKUP_DIR/"
    fi
fi

# 4. Pasang Symlink .vimrc
ln -sfn "$DIR/.vimrc" "$HOME/.vimrc"

echo "=== ✨ Vim Minimal IDE setup complete! ==="
echo "Run 'vim' and enjoy! Press <Space>e to open file tree."
