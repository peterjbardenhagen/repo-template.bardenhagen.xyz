---
name: github-cleanup
description: Clean up GitHub repositories by ensuring main branch is default, merging legacy master/Main/Master branches into main, and removing stale branches.
---

# GitHub Cleanup

Clean up repository branch hygiene, default branch naming, and stale branches.

## Prerequisites

- `gh` CLI authenticated with repo permissions
- `git` configured with user name/email
- Working directory is the repository root

## Workflow

1. **Get repository default branch**
   ```bash
   gh repo view --json defaultBranchRef --jq '.defaultBranchRef.name'
   ```

2. **Ensure `main` is the default branch**
   - If default branch is not `main`, rename it:
     ```bash
     git branch -m <OLD_DEFAULT> main
     git push origin main
     gh repo edit --default-branch main
     ```
   - If the old default still exists remotely, delete it:
     ```bash
     git push origin --delete <OLD_DEFAULT>
     ```

3. **Merge legacy branches into `main`**
   - Check for branches named `master`, `Master`, or `Mai` (case-insensitive variants):
     ```bash
     git ls-remote --heads origin | awk '{print $2}' | grep -E 'refs/heads/(master|Master|Mai)$'
     ```
   - For each legacy branch found:
     a. **Checkout main**
        ```bash
        git checkout main
        ```
     b. **Pull latest main**
        ```bash
        git pull origin main
        ```
     c. **Merge legacy branch**
        ```bash
        git merge origin/<LEGACY_BRANCH> --no-commit --no-ff
        ```
     d. **Resolve conflicts** (if any)
        - List conflicted files:
          ```bash
          git diff --name-only --diff-filter=U
          ```
        - Accept main branch versions for all conflicts:
          ```bash
          git checkout --theirs <file1> <file2> ...
          ```
        - Mark all as resolved:
          ```bash
          git add <file1> <file2> ...
          ```
     e. **Commit the merge**
        ```bash
        git commit -m "Merge <LEGACY_BRANCH> into main"
        ```
     f. **Push to remote**
        ```bash
        git push origin main
        ```
     g. **Delete legacy branch**
        ```bash
        git push origin --delete <LEGACY_BRANCH>
        ```

4. **Clean up stale branches**
   - List merged branches:
     ```bash
     git branch -r --merged main | grep -vE 'origin/(main|HEAD)' | sed 's/origin\///'
     ```
   - For each stale merged branch (exclude protected branches), delete:
     ```bash
     git push origin --delete <BRANCH_NAME>
     ```
   - Also delete local tracking refs:
     ```bash
     git branch -d <BRANCH_NAME>
     ```

5. **Verify cleanup**
   ```bash
   gh repo view --json defaultBranchRef --jq '.defaultBranchRef.name'
   git ls-remote --heads origin | grep -iE 'refs/heads/(master|main|Mai)$' || echo "No legacy branches"
   ```

## Error Handling

- If a legacy branch cannot be merged due to conflicts, resolve them using the same strategy as `pr-auto-merge` (accept main versions).
- If the default branch rename fails, check for branch protection rules and disable them temporarily if needed.
- If deletion fails due to branch protection, skip and report.
