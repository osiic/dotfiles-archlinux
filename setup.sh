#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET="${1:-all}"

# If user passed a custom commit message string (or 'sync' command)
case "$TARGET" in
    packages)
        echo "=== Installing All System Packages (Pacman, Paru/AUR, Flatpak) ==="
        "$DOTFILES_DIR/packages/install-packages.sh"
        exit 0
        ;;
    system)
        echo "=== Configuring System Tweaks & Battery Limits ==="
        "$DOTFILES_DIR/system/install-system.sh"
        exit 0
        ;;
    configs)
        echo "=== Linking Modular Dotfiles Configurations ==="
        for mod in shell ghostty cli vim nvim; do
            if [ -f "$DOTFILES_DIR/$mod/setup.sh" ]; then
                echo "--> Running setup for [$mod]..."
                sh "$DOTFILES_DIR/$mod/setup.sh"
            fi
        done
        echo "=== All Configuration Symlinks Active! ==="
        exit 0
        ;;
    all)
        echo "=========================================================="
        echo "🚀 FULL PLUG & PLAY ARCH LINUX PROVISIONING & DOTFILES 🚀"
        echo "=========================================================="
        "$DOTFILES_DIR/packages/install-packages.sh"
        "$DOTFILES_DIR/system/install-system.sh"
        for mod in shell ghostty cli vim nvim; do
            if [ -f "$DOTFILES_DIR/$mod/setup.sh" ]; then
                echo "--> Running setup for [$mod]..."
                sh "$DOTFILES_DIR/$mod/setup.sh"
            fi
        done
        echo "=========================================================="
        echo "✨ Setup Complete! Please restart your graphical session."
        echo "=========================================================="
        exit 0
        ;;
    shell|ghostty|desktop|cli|vim|nvim)
        if [ -f "$DOTFILES_DIR/$TARGET/setup.sh" ]; then
            sh "$DOTFILES_DIR/$TARGET/setup.sh"
        fi
        exit 0
        ;;
    *)
        # Treat any other parameter as git auto-sync / commit message
        cd "$DOTFILES_DIR"
        echo "=== 🔄 Syncing Master Dotfiles & Submodules ==="

        if [ -f .gitmodules ]; then
            echo "Updating git submodules..."
            git submodule update --init --recursive
        fi

        if [ -n "$(git status --porcelain)" ]; then
            echo "Changes detected in dotfiles:"
            git status --short
            git add -A
            COMMIT_MSG="${TARGET:-dotfiles update: $(date '+%Y-%m-%d %H:%M:%S') on $(hostname)}"
            git commit -m "$COMMIT_MSG"
            echo "Committed: $COMMIT_MSG"
        else
            echo "No local changes in root dotfiles."
        fi

        if git remote get-url origin >/dev/null 2>&1; then
            echo "Pulling latest changes with rebase..."
            git pull --rebase origin "$(git branch --show-current)" || true
            echo "Pushing changes to remote origin..."
            git push origin "$(git branch --show-current)" || true
        fi
        echo "=== Sync Complete! ==="
        exit 0
        ;;
esac
