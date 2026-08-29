#!/usr/bin/env sh
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
echo "Setting up Desktop (Niri, DMS, Swaylock, Wallpaper)..."
mkdir -p "$HOME/.config" "$HOME/Pictures"
for item in niri DankMaterialShell swaylock wallpaper; do
    [ -e "$DIR/$item" ] && ln -sfn "$DIR/$item" "$HOME/.config/$item"
done
[ -e "$DIR/wallpaper" ] && ln -sfn "$HOME/.config/wallpaper" "$HOME/Pictures/Wallpapers"
echo "Desktop configs linked."
