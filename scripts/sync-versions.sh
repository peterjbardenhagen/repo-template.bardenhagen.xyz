#!/usr/bin/env bash
# sync-versions.sh — Synchronize version numbers across project files
# Usage: ./scripts/sync-versions.sh [version]
# If no version provided, reads the latest version from CHANGELOG.md.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Read target version from CHANGELOG.md if not provided
if [ $# -ge 1 ]; then
    VERSION="$1"
else
    VERSION=$(grep -m 1 '^## \[' "$REPO_ROOT/CHANGELOG.md" | sed -E 's/^## \[([^]]+)\].*/\1/')
    if [ -z "$VERSION" ]; then
        echo "ERROR: Could not determine version from CHANGELOG.md. Provide version as argument."
        exit 1
    fi
fi

echo "Syncing version to: $VERSION"

# Update README.md
if [ -f "$REPO_ROOT/README.md" ]; then
    sed -i.bak -E "s/\*\*Version:\*\* [0-9]+\.[0-9]+\.[0-9]+/**Version:** $VERSION/" "$REPO_ROOT/README.md"
    rm -f "$REPO_ROOT/README.md.bak"
    echo "Updated README.md"
fi

# Update docs/index.html (meta generator tag or version comment)
if [ -f "$REPO_ROOT/docs/index.html" ]; then
    sed -i.bak -E "s/<!-- version: [0-9]+\.[0-9]+\.[0-9]+ -->/<!-- version: $VERSION -->/" "$REPO_ROOT/docs/index.html" 2>/dev/null || true
    rm -f "$REPO_ROOT/docs/index.html.bak" 2>/dev/null || true
    echo "Updated docs/index.html"
fi

# Verify
echo "--- Verification ---"
echo "README.md:"
grep -n "Version:" "$REPO_ROOT/README.md" | head -1
echo "CHANGELOG.md:"
grep -m 1 '^## \[' "$REPO_ROOT/CHANGELOG.md"

echo "Version sync complete."
