#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET="${1:-all}"

run_module() {
    mod="$1"
    if [ -f "$DOTFILES_DIR/$mod/setup.sh" ]; then
        echo "--> Running setup for [$mod]..."
        sh "$DOTFILES_DIR/$mod/setup.sh"
    elif [ "$mod" = "nvim" ] && [ -d "$DOTFILES_DIR/nvim" ]; then
        echo "--> Running setup for [nvim]..."
        mkdir -p "$HOME/.config"
        ln -sfn "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
    else
        echo "Warning: Module [$mod] not found or has no setup.sh"
    fi
}

install_configs() {
    echo "=== Linking Modular Dotfiles Configurations ==="
    for mod in shell ghostty desktop cli vim nvim; do
        run_module "$mod"
    done
    echo "=== All Configuration Symlinks Active! ==="
}

case "$TARGET" in
    packages)
        echo "=== Installing All System Packages (Pacman, Paru/AUR, Flatpak) ==="
        "$DOTFILES_DIR/packages/install-packages.sh"
        ;;
    system)
        echo "=== Configuring System Tweaks & Battery Limits ==="
        "$DOTFILES_DIR/system/install-system.sh"
        ;;
    configs)
        install_configs
        ;;
    all)
        echo "=========================================================="
        echo "🚀 FULL PLUG & PLAY ARCH LINUX PROVISIONING & DOTFILES 🚀"
        echo "=========================================================="
        "$DOTFILES_DIR/packages/install-packages.sh"
        "$DOTFILES_DIR/system/install-system.sh"
        install_configs
        echo "=========================================================="
        echo "✨ Setup Complete! Please restart your graphical session."
        echo "=========================================================="
        ;;
    *)
        # Specific single module, e.g., ./install.sh shell
        if [ -d "$DOTFILES_DIR/$TARGET" ]; then
            run_module "$TARGET"
        else
            echo "Usage: $0 [all | packages | system | configs | <module_name>]"
            echo "Modules: shell, desktop, ghostty, nvim, vim, cli"
            exit 1
        fi
        ;;
esac
