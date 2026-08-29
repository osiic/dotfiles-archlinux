#!/usr/bin/env sh
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DOTFILES_DIR"

echo "=== Syncing Dotfiles ==="

# Check git status
if [ -n "$(git status --porcelain)" ]; then
    echo "Changes detected in dotfiles:"
    git status --short
    git add -A
    COMMIT_MSG="${1:-dotfiles update: $(date '+%Y-%m-%d %H:%M:%S') on $(hostname)}"
    git commit -m "$COMMIT_MSG"
    echo "Committed: $COMMIT_MSG"
else
    echo "No local changes in dotfiles."
fi

# Push/Pull if remote is configured
if git remote get-url origin >/dev/null 2>&1; then
    echo "Fetching & pulling upstream with rebase..."
    git pull --rebase origin $(git branch --show-current) || true
    echo "Pushing to remote origin..."
    git push origin $(git branch --show-current) || true
fi

echo "=== Sync complete! ==="
