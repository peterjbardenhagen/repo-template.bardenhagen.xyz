---

## 3. Repository Onboarding & Launch Script
Place this script in `scripts/open-repo.sh`. It prepares your Git Bash / Windows workspace, opens VS Code, and displays agent guidance.

```bash
#!/usr/bin/env bash
# scripts/open-repo.sh

echo "=========================================="
echo "📂 Opening Project Workspace for Vibe Kanban & OpenCode"
echo "=========================================="

# Ensure Git Bash handles Windows paths smoothly
export MSYS_NO_PATHCONV=1

# Check node & npm dependencies
if [ -f "package.json" ] && [ ! -d "node_modules" ]; then
  echo "Installing npm dependencies..."
  npm install
fi

echo ""
echo "🤖 OpenCode / Vibe Kanban Workspace Ready."
echo "------------------------------------------"
echo "Available Commands in Terminal / Agent Prompt:"
echo "1. Run full automated delivery:"
echo "   ./scripts/commit-and-clean.sh \"your commit message\""
echo ""
echo "2. Ask OpenCode Agent:"
echo "   \"Use the committer agent to build, test, merge into main, clean branches, and push.\""
echo "------------------------------------------"

# Open current directory in VS Code if installed
if command -v code &> /dev/null; then
  code .
fi