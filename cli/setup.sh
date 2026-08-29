#!/usr/bin/env sh
set -e

DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.cli_backup_$(date +%Y%m%d_%H%M%S)"

echo "=== 🚀 CLI Tools & Dev Runtimes Setup (Cross-Platform & Auto-Updater) ==="

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
            echo "New updates found! Pulling latest CLI configs from GitHub..."
            git -C "$DIR" pull --rebase origin main || true
        else
            echo "CLI configuration is up to date."
        fi
    fi
fi

# ------------------------------------------------------------------------------
# 2. Deteksi Package Manager & Auto-Install CLI Tools jika belum ada
# ------------------------------------------------------------------------------
install_cli_tools() {
    NEEDS_INSTALL=0
    if ! command -v btop >/dev/null 2>&1 || ! command -v fastfetch >/dev/null 2>&1 || ! command -v git >/dev/null 2>&1; then
        NEEDS_INSTALL=1
    fi

    if [ "$NEEDS_INSTALL" -eq 1 ]; then
        echo "Installing CLI utilities (btop, fastfetch, eza, bat, fzf, jq, cava)..."
        if command -v pkg >/dev/null 2>&1; then
            echo "-> Detected: Termux (Android)"
            pkg update -y && pkg install -y git btop fastfetch eza bat fzf jq curl wget
        elif command -v apt-get >/dev/null 2>&1; then
            echo "-> Detected: Debian / Ubuntu / Mint / PopOS"
            sudo apt-get update -y && sudo apt-get install -y git btop bat fzf jq curl wget eza fastfetch || sudo apt-get install -y git btop fzf jq curl wget
        elif command -v pacman >/dev/null 2>&1; then
            echo "-> Detected: Arch Linux / Manjaro / EndeavourOS"
            sudo pacman -Syu --needed --noconfirm git btop fastfetch eza bat fzf jq cava curl wget
        elif command -v emerge >/dev/null 2>&1; then
            echo "-> Detected: Gentoo"
            sudo emerge --ask=n sys-process/btop app-misc/fastfetch app-shells/fzf app-misc/jq
        elif command -v dnf >/dev/null 2>&1; then
            echo "-> Detected: Fedora / RHEL / CentOS"
            sudo dnf install -y git btop fastfetch eza bat fzf jq curl wget
        elif command -v brew >/dev/null 2>&1; then
            echo "-> Detected: macOS (Homebrew)"
            brew install git btop fastfetch eza bat fzf jq cava
        fi
    fi
}

install_cli_tools

# ------------------------------------------------------------------------------
# 3. Setup NVM & Node.js jika belum ada
# ------------------------------------------------------------------------------
if [ ! -d "$HOME/.nvm" ]; then
    echo "Installing NVM (Node Version Manager)..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash || true
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm install --lts || true
fi

# ------------------------------------------------------------------------------
# 4. Setup Bun Runtime jika belum ada
# ------------------------------------------------------------------------------
if ! command -v bun >/dev/null 2>&1 && [ ! -d "$HOME/.bun" ]; then
    echo "Installing Bun Runtime..."
    curl -fsSL https://bun.sh/install | bash || true
fi

# ------------------------------------------------------------------------------
# 5. Safe Backup & Pasang Symlink (.gitconfig, btop, cava, fastfetch)
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

# Link .gitconfig
[ -f "$DIR/.gitconfig" ] && backup_and_link "$DIR/.gitconfig" "$HOME/.gitconfig"

# Link config directories
mkdir -p "$HOME/.config"
for item in btop cava fastfetch; do
    [ -e "$DIR/$item" ] && backup_and_link "$DIR/$item" "$HOME/.config/$item"
done

echo "=== ✨ CLI Tools & Dev Runtimes Setup Complete! ==="
