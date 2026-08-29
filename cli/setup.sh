#!/usr/bin/env sh
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
echo "Setting up CLI tools configs..."
[ -f "$DIR/.gitconfig" ] && ln -sfn "$DIR/.gitconfig" "$HOME/.gitconfig"
mkdir -p "$HOME/.config"
for item in btop cava fastfetch; do
    [ -e "$DIR/$item" ] && ln -sfn "$DIR/$item" "$HOME/.config/$item"
done
echo "CLI tools configs linked."
