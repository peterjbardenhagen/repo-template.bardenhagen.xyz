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
1.  **List open PRs**
    ```bash
    gh pr list --state open --json number,headRefName
    ```
2.  **For each open PR**, run the following sequence:
    a.  **Approve the PR** (if not own PR)
        ```bash
        gh pr review <PR_NUMBER> --approve || true
        ```
        The `|| true` handles cases where you can't approve your own PR.

    b.  **Checkout the PR branch**
        ```bash
        gh pr checkout <PR_NUMBER>
        ```
    c.  **Merge `main` into the PR branch**
        ```bash
        git merge origin/main --no-commit --no-ff
        ```
    d.  **Resolve conflicts** (if any)
        -   List conflicted files:
            ```bash
            git diff --name-only --diff-filter=U
            ```
        -   Accept `main` branch versions for all conflicts:
            ```bash
            git diff --name-only --diff-filter=U | xargs git checkout --theirs
            ```
        -   Mark all as resolved:
            ```bash
            git diff --name-only --diff-filter=U | xargs git add
            ```
    e.  **Commit the merge**
        ```bash
        git commit -m "Merge branch 'main' into <BRANCH_NAME>"
        ```
    f.  **Push to remote**
        ```bash
        git push origin <BRANCH_NAME>
        ```
    g.  **Merge the PR with squash and delete branch**
        ```bash
        gh pr merge <PR_NUMBER> --squash --delete-branch
        ```
    h.  **Return to main and update**
        ```bash
        git checkout main
        git pull origin main
        ```
3.  **Verify no open PRs remain**
    ```bash
    gh pr list --state open
    ```

## Conflict Resolution Strategy
Default strategy: accept `origin/main` versions for all conflicted files (`git checkout --theirs`). This preserves the canonical main branch state and avoids manual conflict review. If a more nuanced resolution is required, resolve conflicts manually before running `git add`.

## Error Handling
- If PR is not mergeable due to conflicts, this script resolves them locally before merging.
- If approval fails because it's your own PR, the `|| true` allows the script to continue.
- If merge fails, ensure conflicts are fully resolved and committed before retrying.
