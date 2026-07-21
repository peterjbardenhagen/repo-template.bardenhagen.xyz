---
name: pr-auto-merge
description: Automatically resolve merge conflicts, approve, merge, and delete branches for open pull requests.
---

# PR Auto-Merge

Automatically resolve merge conflicts, approve, merge, and delete branches for open pull requests.

## Prerequisites

- `gh` CLI authenticated with repo permissions
- `git` configured with user name/email
- Working directory is the repository root

## Workflow

1. **List open PRs**
   ```bash
   gh pr list --state open
   ```

2. **For each open PR**, run the following sequence:

   a. **Approve the PR** (if not own PR)
      ```bash
      gh pr review <PR_NUMBER> --approve
      ```
      Skip if GraphQL returns: `Review Can not approve your own pull request`

   b. **Checkout the PR branch**
      ```bash
      gh pr checkout <PR_NUMBER>
      ```

   c. **Merge main into the PR branch**
      ```bash
      git merge origin/main --no-commit --no-ff
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
      git commit -m "Merge branch 'main' into <BRANCH_NAME>"
      ```

   f. **Push to remote**
      ```bash
      git push origin <BRANCH_NAME>
      ```

   g. **Merge the PR with squash and delete branch**
      ```bash
      gh pr merge <PR_NUMBER> --squash --delete-branch
      ```

   h. **Return to main**
      ```bash
      git checkout main
      ```

3. **Verify no open PRs remain**
   ```bash
   gh pr list --state open
   ```

## Conflict Resolution Strategy

Default strategy: accept `origin/main` versions for all conflicted files (`git checkout --theirs`). This preserves the canonical main branch state and avoids manual conflict review.

If a more nuanced resolution is required, resolve conflicts manually before running `git add`.

## Error Handling

- If PR is not mergeable due to conflicts, resolve them locally before merging.
- If approval fails because it's your own PR, skip approval and proceed to merge.
- If merge fails, ensure conflicts are fully resolved and committed before retrying.
