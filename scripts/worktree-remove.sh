#!/bin/env bash
# worktree-remove.sh — Remove a worktree and delete its branch
# Usage: ./scripts/worktree-remove.sh <worktree-path>

set -e

WORKTREE_DIR="${1:-}"
if [ -z "$WORKTREE_DIR" ]; then
  echo "Usage: $0 <worktree-path>"
  exit 1
fi

BRANCH=$(git -C "$WORKTREE_DIR" rev-parse --abbrev-ref HEAD)
git worktree remove "$WORKTREE_DIR"
git branch -d "$BRANCH"
echo "Removed worktree: $WORKTREE_DIR (branch: $BRANCH)"
