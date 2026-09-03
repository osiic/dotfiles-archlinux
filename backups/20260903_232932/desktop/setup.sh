#!/usr/bin/env bash
set -e

DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

echo "--> Linking Desktop (Hyprland & Waybar) configs..."
mkdir -p "$CONFIG_HOME"

if [ -d "$DIR/config/hypr" ]; then
    rm -rf "$CONFIG_HOME/hypr"
    ln -sf "$DIR/config/hypr" "$CONFIG_HOME/hypr"
    echo "    Linked hypr -> $CONFIG_HOME/hypr"
fi

if [ -d "$DIR/config/waybar" ]; then
    rm -rf "$CONFIG_HOME/waybar"
    ln -sf "$DIR/config/waybar" "$CONFIG_HOME/waybar"
    echo "    Linked waybar -> $CONFIG_HOME/waybar"
fi
