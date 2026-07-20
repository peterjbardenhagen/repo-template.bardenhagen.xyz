#!/usr/bin/env bash
# ============================================================================
# init-project.sh — Initialise a new project from Repo Template
# ============================================================================
# Usage: ./scripts/init-project.sh <project-name> [project-directory]
#
# Creates a new project directory, copies the template, resets git history,
# and guides you through initial setup.
# ============================================================================

set -euo pipefail

PROJECT_NAME="${1:-}"
PROJECT_DIR="${2:-$PROJECT_NAME}"

if [ -z "$PROJECT_NAME" ]; then
  echo "Usage: $0 <project-name> [project-directory]"
  echo "Example: $0 my-awesome-project"
  exit 1
fi

echo "=== Initialising new project: $PROJECT_NAME ==="

# Copy template (assumes we're in the template repo)
TEMPLATE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TARGET_DIR="$(cd "$(dirname "$PROJECT_DIR")" && pwd)/$(basename "$PROJECT_DIR")" 2>/dev/null || TARGET_DIR="$PWD/$PROJECT_DIR"

if [ -d "$TARGET_DIR" ]; then
  echo "Error: Target directory '$TARGET_DIR' already exists."
  exit 1
fi

echo "Copying template..."
cp -r "$TEMPLATE_DIR" "$TARGET_DIR"

echo "Resetting git history..."
cd "$TARGET_DIR"
rm -rf .git
git init
git checkout -b main

# Add all files
git add -A
git commit -m "chore: initialise project from repo-template"

echo ""
echo "=== Project '$PROJECT_NAME' initialised at $TARGET_DIR ==="
echo ""
echo "Next steps:"
echo "  1. cd $PROJECT_DIR"
echo "  2. Update AI_CONTEXT.md with your project details"
echo "  3. Create your repo on GitHub and push:"
echo "     git remote add origin <your-repo-url>"
echo "     git push -u origin main"
echo ""
