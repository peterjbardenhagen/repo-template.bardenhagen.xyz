#!/usr/bin/env bash
# scripts/commit-and-clean.sh
set -e

COMMIT_MSG="${1:-chore: automated commit, build, and branch cleanup}"

echo "=========================================="
echo "🚀 1. Staging and Committing Work-in-Progress"
echo "=========================================="
git add -A
if ! git diff-index --quiet HEAD --; then
  git commit -m "$COMMIT_MSG"
else
  echo "No local uncommitted changes to commit."
fi

echo "=========================================="
echo "🧪 2. Running Verification Suite (Build & Tests)"
echo "=========================================="
echo "Building project..."
npm run build

echo "Running unit and integration tests..."
npm test --if-present

if [ -f "playwright.config.ts" ] || [ -f "playwright.config.js" ]; then
  echo "Running Playwright E2E tests..."
  npx playwright test
fi

echo "=========================================="
echo "🔀 3. Merging Changes into main"
echo "=========================================="
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

if [ "$CURRENT_BRANCH" != "main" ]; then
  echo "Currently on '$CURRENT_BRANCH'. Switching to 'main'..."
  git checkout main
  git pull origin main --rebase || true
  
  echo "Merging '$CURRENT_BRANCH' into 'main'..."
  git merge "$CURRENT_BRANCH" --no-ff -m "merge: incorporate changes from $CURRENT_BRANCH"
fi

echo "=========================================="
echo "🧹 4. Cleaning Up Non-Main Local Branches"
echo "=========================================="
# Get list of local branches except main
OTHER_BRANCHES=$(git branch | grep -v "main" | tr -d ' ' | tr -d '*')

if [ -n "$OTHER_BRANCHES" ]; then
  for branch in $OTHER_BRANCHES; do
    echo "Deleting local branch: $branch"
    git branch -D "$branch"
  done
else
  echo "No additional local branches to delete."
fi

echo "=========================================="
echo "📤 5. Pushing Main to Remote"
echo "=========================================="
git push origin main

echo "=========================================="
echo "✅ Complete! Your project is clean, tested, merged, and pushed."
echo "=========================================="