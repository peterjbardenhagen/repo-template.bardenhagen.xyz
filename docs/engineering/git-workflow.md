# Git Workflow

How work moves from a local edit to `main`. Applies to humans and agents alike —
where an agent's obligations differ, it says so.

> Pipelines, permissions, and supply-chain hardening live in [`ci-cd.md`](./ci-cd.md).
> This document is about branches, commits, and merges.

---

## The Model: Trunk-Based

`main` is the trunk. It is always green and always deployable. Everything else
is a short-lived branch off it.

- **Branches live hours or days, never weeks.** A branch older than ~48h is a
  smell: it has drifted from main, its CI signal is stale, and its merge is a
  gamble. Split the work instead.
- **Small PRs.** A 200-line PR gets a real review. A 2,000-line PR gets a rubber
  stamp. Stack changes rather than batching them.
- **Never commit directly to `main`** — even for a one-line fix, even as an
  admin. The ruleset enforces this; do not bypass it.

## Branch Naming

| Kind | Pattern | Example |
|---|---|---|
| Feature | `feat/<description>` | `feat/oauth-login` |
| Fix | `fix/<description>` | `fix/session-timeout` |
| Chore / deps / docs | `chore/<description>` | `chore/bump-eslint` |
| Agent-authored | `claude/<feature>-<short-code>` | `claude/oauth-login-a3f9` |

Agent branches carry the `claude/` (or tool-name) prefix so a glance at the
branch list tells you what was machine-authored — useful when triaging a stale
branch months later. The short code keeps two concurrent agent sessions on the
same feature from colliding.

## Commits

[Conventional Commits](https://www.conventionalcommits.org/): `type(scope): description`.

| Type | Use for |
|---|---|
| `feat` | new user-facing capability |
| `fix` | bug fix |
| `docs` | documentation only |
| `refactor` | behaviour-preserving restructure |
| `perf` | performance |
| `test` | tests only |
| `chore` | tooling, deps, config |
| `ci` | pipeline changes |

Rules:

- **Subject in the imperative**, under ~72 chars: "add retry to webhook sender",
  not "added" or "adds".
- **Explain *why* in the body**, not *what*. The diff already says what changed.
- **One logical change per commit.** If the body needs "and", it is two commits.
- **`feat!:` or a `BREAKING CHANGE:` footer** for anything that breaks a
  consumer.

## The Loop

```bash
# 1. Start from a current trunk — never branch off a stale local main.
git fetch origin
git checkout -B feat/my-change origin/main

# 2. Work. Commit after each logical phase.
git add -A && git commit -m "feat(api): add retry to webhook sender"

# 3. Before pushing, rebase onto trunk so CI tests what will actually land.
git fetch origin
git rebase origin/main

# 4. Push and open a PR.
git push -u origin feat/my-change
```

If the rebase conflicts, resolve it on the branch. Never resolve a conflict by
force-pushing over someone else's work.

## Merging

- **Squash merge** into `main`. One PR becomes one commit, so history is linear
  and `git bisect` is meaningful. The PR title becomes the commit subject —
  write it as a conventional commit.
- **Delete the branch on merge.** Stale branches are noise.
- **Use the merge queue** where enabled. It rebases and re-tests each PR against
  the *future* state of main, which catches the "both PRs pass alone, together
  they break" class of failure that plain branch protection misses.

### Force-push rules

| Target | Allowed? |
|---|---|
| Your own unshared feature branch | Yes — `--force-with-lease`, never bare `--force` |
| A branch someone else has pulled | No. Add a commit instead |
| `main` | Never |

`--force-with-lease` aborts if the remote moved since your last fetch;
bare `--force` silently destroys those commits. There is no case for bare
`--force` in this workflow.

## Branch Protection

Configure via **repository rulesets**, not classic branch protection. Rulesets
apply to admins by default and support per-actor bypass, which classic rules do
not. Rules-as-code lives in [`.github/rulesets/`](../.github/rulesets/).

Minimum for `main`:

- [ ] Require a PR before merging
- [ ] Require status check **`CI Gate`** to pass
- [ ] Require branches to be up to date before merging
- [ ] Block force pushes
- [ ] Block deletions
- [ ] Require conversation resolution

> **Require `CI Gate` and nothing else.** It is a single job in `ci.yml` that
> fails unless every other job succeeded. Adding, renaming, or splitting a CI
> job then never requires touching branch protection — a common source of
> silently-unenforced checks, because a required check that no longer exists is
> simply skipped.

## Agent-Specific Rules

1. **Work only on your designated branch.** Never push to a branch another
   session owns, and never to `main`.
2. **A merged PR is finished.** For follow-up work, restart the branch from the
   current `main` — do not stack commits on merged history.
3. **Report honestly.** If tests fail, say so and show the output. A green
   summary over a red build is worse than no summary.
4. **Never bypass a failing gate.** Do not merge with `--admin`, do not disable
   a check, do not mark a task done because CI is "probably flaky". Fix it or
   escalate it.
5. **Co-author trailer** on every agent commit, so authorship is auditable:

   ```
   Co-Authored-By: Claude <noreply@anthropic.com>
   ```

## Recovery

| Situation | Fix |
|---|---|
| Committed to `main` locally | `git branch feat/x && git reset --hard origin/main` |
| Wrong commit message (unpushed) | `git commit --amend` |
| Need to undo a pushed commit | `git revert <sha>` — never rewrite pushed history |
| Rebase went wrong | `git rebase --abort`, or `git reflog` to find the pre-rebase SHA |
| Committed a secret | Rotate the secret **first**, then purge history. Assume it is compromised the moment it is pushed |

## Reference

- [Conventional Commits](https://www.conventionalcommits.org/)
- [GitHub merge queue](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/configuring-pull-request-merges/managing-a-merge-queue)
- [Repository rulesets](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets)
- [Trunk-based development](https://trunkbaseddevelopment.com/)
