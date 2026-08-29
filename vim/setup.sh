#!/usr/bin/env sh
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
echo "Setting up Vim config..."
[ -f "$DIR/.vimrc" ] && ln -sfn "$DIR/.vimrc" "$HOME/.vimrc"
echo "Vim config linked."
