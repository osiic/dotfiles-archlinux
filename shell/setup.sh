#!/usr/bin/env bash
set -e

DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.shell_backup_$(date +%Y%m%d_%H%M%S)"

echo "=== 🚀 Shell Environment Setup (Cross-Platform & Auto-Updater) ==="

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
            echo "New updates found! Pulling latest shell configs from GitHub..."
            git -C "$DIR" pull --rebase origin main || true
        else
            echo "Shell configuration is up to date."
        fi
    fi
fi

# ------------------------------------------------------------------------------
# 2. Deteksi Package Manager & Auto-Install Zsh, Starship, Plugins jika belum ada
# ------------------------------------------------------------------------------
install_packages() {
    NEEDS_INSTALL=0
    if ! command -v zsh >/dev/null 2>&1 || ! command -v starship >/dev/null 2>&1; then
        NEEDS_INSTALL=1
    fi

    if [ "$NEEDS_INSTALL" -eq 1 ]; then
        echo "Installing required packages (zsh, starship, git)..."
        if command -v pkg >/dev/null 2>&1; then
            echo "-> Detected: Termux (Android)"
            pkg update -y && pkg install -y zsh starship git eza bat fzf
        elif command -v apt-get >/dev/null 2>&1; then
            echo "-> Detected: Debian / Ubuntu / Mint / PopOS"
            DEBIAN_FRONTEND=noninteractive run_sudo apt-get update -y
            DEBIAN_FRONTEND=noninteractive run_sudo apt-get install -y --no-install-recommends zsh git curl bat eza fzf || DEBIAN_FRONTEND=noninteractive run_sudo apt-get install -y zsh git curl
            if ! command -v starship >/dev/null 2>&1; then
                curl -sS https://starship.rs/install.sh | sh -s -- -y
            fi
        elif command -v pacman >/dev/null 2>&1; then
            echo "-> Detected: Arch Linux / Manjaro / EndeavourOS"
            run_sudo pacman -Syu --needed --noconfirm zsh starship git eza bat fzf zsh-autosuggestions zsh-syntax-highlighting
        elif command -v emerge >/dev/null 2>&1; then
            echo "-> Detected: Gentoo"
            run_sudo emerge --ask=n app-shells/zsh app-shells/starship dev-vcs/git
        elif command -v dnf >/dev/null 2>&1; then
            echo "-> Detected: Fedora / RHEL / CentOS"
            run_sudo dnf install -y zsh starship git eza bat fzf
        elif command -v zypper >/dev/null 2>&1; then
            echo "-> Detected: openSUSE"
            run_sudo zypper --non-interactive install -y zsh starship git
        elif command -v apk >/dev/null 2>&1; then
            echo "-> Detected: Alpine Linux"
            run_sudo apk add zsh starship git
        elif command -v xbps-install >/dev/null 2>&1; then
            echo "-> Detected: Void Linux"
            run_sudo xbps-install -Sy zsh starship git
        elif command -v nix-env >/dev/null 2>&1; then
            echo "-> Detected: NixOS"
            nix-env -iA nixpkgs.zsh nixpkgs.starship nixpkgs.git
        elif command -v brew >/dev/null 2>&1; then
            echo "-> Detected: macOS (Homebrew)"
            brew install zsh starship git eza bat fzf
        else
            echo "Warning: No supported package manager found. Please install zsh & starship manually."
        fi
    fi
}

install_packages

# ------------------------------------------------------------------------------
# 3. Safe Backup File Shell Lama jika ada file non-symlink
# ------------------------------------------------------------------------------
backup_and_link() {
    src="$1"
    dest="$2"
    if [ -f "$dest" ] || [ -L "$dest" ]; then
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

# ------------------------------------------------------------------------------
# 4. Pasang Symlink Home Shell, Profile & Starship
# ------------------------------------------------------------------------------
for f in .zshrc .bashrc .bash_profile .zprofile .zshenv; do
    if [ -f "$DIR/$f" ]; then
        backup_and_link "$DIR/$f" "$HOME/$f"
    fi
done

if [ -f "$DIR/starship.toml" ]; then
    mkdir -p "$HOME/.config"
    backup_and_link "$DIR/starship.toml" "$HOME/.config/starship.toml"
fi

echo "=== ✨ Shell Environment Setup Complete & Up-To-Date! ==="
echo "Restart your terminal or run 'zsh' to apply."
