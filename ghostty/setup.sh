#!/usr/bin/env sh
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
echo "Setting up Ghostty config..."
mkdir -p "$HOME/.config"
ln -sfn "$DIR/config" "$HOME/.config/ghostty"
echo "Ghostty config linked."
