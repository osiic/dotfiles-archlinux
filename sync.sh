#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DOTFILES_DIR"

echo "=== Syncing Master Dotfiles & Submodules ==="

# 1. Update submodules
if [ -f .gitmodules ]; then
    echo "Updating git submodules..."
    git submodule update --init --recursive
fi

# 2. Check git status
if [ -n "$(git status --porcelain)" ]; then
    echo "Changes detected in dotfiles:"
    git status --short
    git add -A
    COMMIT_MSG="${1:-dotfiles update: $(date '+%Y-%m-%d %H:%M:%S') on $(hostname)}"
    git commit -m "$COMMIT_MSG"
    echo "Committed: $COMMIT_MSG"
else
    echo "No local changes in root dotfiles."
fi

# 3. Push/Pull if remote is configured
if git remote get-url origin >/dev/null 2>&1; then
    echo "Pulling latest changes with rebase..."
    git pull --rebase origin "$(git branch --show-current)" || true
    echo "Pushing changes to remote origin..."
    git push origin "$(git branch --show-current)" || true
fi

echo "=== Sync Complete! ==="
