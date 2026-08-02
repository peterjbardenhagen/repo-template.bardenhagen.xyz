#!/usr/bin/env bash
# scripts/open-repo.sh
#
# Prepares the workspace, installs dependencies if needed, opens VS Code,
# and prints agent guidance.

set -euo pipefail

echo "=========================================="
echo "📂 Opening Project Workspace"
echo "=========================================="

# Ensure Git Bash handles Windows paths smoothly
export MSYS_NO_PATHCONV=1

# Check node & npm dependencies
if [ -f "package.json" ] && [ ! -d "node_modules" ]; then
  echo "Installing npm dependencies..."
  npm install
fi

echo ""
echo "🤖 Workspace Ready."
echo "------------------------------------------"
echo "Available Commands in Terminal / Agent Prompt:"
echo "1. Run full automated delivery:"
echo "   ./scripts/commit-and-clean.sh \"your commit message\""
echo ""
echo "2. Ask your coding agent:"
echo "   \"Build, test, open a PR, and drive CI to green.\""
echo "------------------------------------------"

# Open current directory in VS Code if installed
if command -v code &> /dev/null; then
  code .
fi
