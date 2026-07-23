---
name: github-cleanup
description: Clean up GitHub repositories by ensuring main is the default branch, merging master/Main/Master into main, deleting stale branches, and other repository hygiene tasks.
---
# GitHub Cleanup

Clean up GitHub repositories by standardizing branches, merging duplicates, and removing stale work.

## Prerequisites
- `gh` CLI authenticated with repo permissions
- `git` configured with user name/email
- Working directory is the repository root

## Workflow

### 1. Ensure `main` branch exists locally and remotely
```bash
git branch -m main 2>/dev/null || true
git push -u origin main 2>/dev/null || true
```

### 2. Check and set default branch to `main`
```bash
CURRENT_DEFAULT=$(gh repo view --json defaultBranchRef --jq '.defaultBranchRef.name')
if [ "$CURRENT_DEFAULT" != "main" ]; then
  gh repo edit --default-branch main
fi
```

### 3. Merge other default branches into `main`
For each of `master`, `Main`, `Master`:
```bash
# Check if branch exists remotely
if git ls-remote --heads origin master | grep -q 'refs/heads/master'; then
  git checkout main
  git pull origin main
  git merge origin/master --no-commit --no-ff || true
  # Resolve conflicts by accepting main versions
  git diff --name-only --diff-filter=U | xargs git checkout --theirs 2>/dev/null || true
  git diff --name-only --diff-filter=U | xargs git add 2>/dev/null || true
  git commit -m "Merge master into main" 2>/dev/null || true
  git push origin main
  # Delete merged branch
  gh api repos/$(gh repo view --json owner,name --jq '.owner.login + "/" + .name')/branches/master -X DELETE 2>/dev/null || true
fi
```
(Repeat logic for `Main` and `Master`).

### 4. Delete stale branches
```bash
# List branches merged into main and delete them
git branch -r --merged origin/main | grep -v 'origin/main' | grep -v 'origin/HEAD' | while read branch; do
  BRANCH_NAME=$(echo $branch | sed 's/origin\///')
  gh api repos/$(gh repo view --json owner,name --jq '.owner.login + "/" + .name')/branches/$BRANCH_NAME -X DELETE 2>/dev/null || true
done
```

### 5. Verify
```bash
gh repo view --json defaultBranchRef --jq '.defaultBranchRef.name'
gh pr list --state open
```

## Notes
- Always enforce lowercase `main`.
- Never create branches named `Master`, `Main`, or `master`.
- This skill enforces the golden rule defined in `AGENTS.md`.