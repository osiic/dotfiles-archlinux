#!/usr/bin/env sh
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
echo "Setting up Neovim config..."
mkdir -p "$HOME/.config"
ln -sfn "$DIR" "$HOME/.config/nvim"
echo "Neovim config linked."
