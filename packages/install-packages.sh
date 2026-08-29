#!/usr/bin/env bash
set -e

DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== [1/3] Installing Pacman Native Packages ==="
if [ -f "$DIR/pacman.txt" ]; then
    sudo pacman -Syu --needed --noconfirm - < "$DIR/pacman.txt"
fi

echo "=== [2/3] Checking & Installing Paru (AUR Helper) & AUR Packages ==="
if ! command -v paru >/dev/null 2>&1; then
    echo "Installing paru from AUR..."
    TEMP_DIR=$(mktemp -d)
    git clone https://aur.archlinux.org/paru-bin.git "$TEMP_DIR/paru-bin"
    (cd "$TEMP_DIR/paru-bin" && makepkg -si --noconfirm)
    rm -rf "$TEMP_DIR"
fi

if [ -f "$DIR/aur.txt" ]; then
    paru -S --needed --noconfirm - < "$DIR/aur.txt"
fi

echo "=== [3/3] Installing Flatpak Packages ==="
if command -v flatpak >/dev/null 2>&1 && [ -f "$DIR/flatpak.txt" ]; then
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo || true
    while IFS= read -r app || [ -n "$app" ]; do
        [ -z "$app" ] && continue
        echo "Installing Flatpak app: $app"
        flatpak install -y flathub "$app" || true
    done < "$DIR/flatpak.txt"
fi

echo "=== All Packages Installed Successfully! ==="
