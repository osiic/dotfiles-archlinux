#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

echo "=========================================================="
echo "🚀 FULL HYPRLAND PROVISIONING & CLEAN MIGRATION 🚀"
echo "=========================================================="

echo "--> [1/5] Installing Pacman Native Packages..."
sudo pacman -Syu --needed --noconfirm - < "$DOTFILES_DIR/packages/pacman.txt"

echo "--> [2/5] Installing AUR Packages via Paru (wlogout, etc.)..."
if command -v paru >/dev/null 2>&1; then
    paru -S --needed --noconfirm - < "$DOTFILES_DIR/packages/aur.txt" || true
fi

echo "--> [3/5] Removing Old Niri & DMS Packages..."
sudo pacman -Rns --noconfirm niri dms-shell-niri xwayland-satellite xdg-desktop-portal-gnome 2>/dev/null || true
sudo pacman -Rns --noconfirm $(pacman -Qdtq) 2>/dev/null || true

echo "--> [4/5] Cleaning Up Old Niri Config Folders..."
rm -rf "$CONFIG_HOME/niri" "$CONFIG_HOME/DankMaterialShell"

echo "--> [5/5] Deploying All Modular Dotfiles Symlinks..."
"$DOTFILES_DIR/setup.sh" configs

echo "=========================================================="
echo "✨ All Done! System is 100% clean and ready."
echo "👉 Run: sudo reboot"
echo "=========================================================="
