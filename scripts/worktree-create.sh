#!/bin/env bash
# worktree-create.sh — Create an isolated worktree for parallel feature work
# Usage: ./scripts/worktree-create.sh <feature-name>

set -e

FEATURE="${1:-}"
if [ -z "$FEATURE" ]; then
  echo "Usage: $0 <feature-name>"
  exit 1
fi

BRANCH="feat/${FEATURE}-$(date +%Y%m%d)"
WORKTREE_DIR="../$(basename "$PWD")-wt-${FEATURE}"

git worktree add "$WORKTREE_DIR" -b "$BRANCH"
echo "Created worktree: $WORKTREE_DIR (branch: $BRANCH)"
