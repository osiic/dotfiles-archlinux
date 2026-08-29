#!/usr/bin/env sh
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
echo "Setting up Shell configs..."
for f in .zshrc .bashrc .bash_profile; do
    [ -f "$DIR/$f" ] && ln -sfn "$DIR/$f" "$HOME/$f"
done
if [ -f "$DIR/starship.toml" ]; then
    mkdir -p "$HOME/.config"
    ln -sfn "$DIR/starship.toml" "$HOME/.config/starship.toml"
fi
echo "Shell configs linked."
