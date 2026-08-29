#!/usr/bin/env sh
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

link_file() {
    src="$1"
    dest="$2"

    mkdir -p "$(dirname "$dest")"

    # If destination exists and is not already the right symlink
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        current_target="$(readlink -f "$dest" 2>/dev/null || true)"
        real_src="$(readlink -f "$src" 2>/dev/null || true)"

        if [ "$current_target" != "$real_src" ]; then
            mkdir -p "$BACKUP_DIR"
            echo "Backing up $dest -> $BACKUP_DIR/"
            mv "$dest" "$BACKUP_DIR/"
            ln -sfn "$src" "$dest"
            echo "Linked $dest -> $src"
        else
            echo "Already linked: $dest"
        fi
    else
        ln -sfn "$src" "$dest"
        echo "Linked $dest -> $src"
    fi
}

echo "=== Installing Dotfiles Symlinks ==="

# Link home files
if [ -d "$DOTFILES_DIR/home" ]; then
    for item in "$DOTFILES_DIR/home"/.[!.]* "$DOTFILES_DIR/home"/*; do
        [ -e "$item" ] || continue
        base="$(basename "$item")"
        link_file "$item" "$HOME/$base"
    done
fi

# Link config directories/files
if [ -d "$DOTFILES_DIR/config" ]; then
    for item in "$DOTFILES_DIR/config"/*; do
        [ -e "$item" ] || continue
        base="$(basename "$item")"
        link_file "$item" "$HOME/.config/$base"
    done
fi

echo "=== Dotfiles link setup complete! ==="
