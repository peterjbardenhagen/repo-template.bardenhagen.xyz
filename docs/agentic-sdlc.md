# Agentic SDLC (Autonomous Development Lifecycle)

Operational protocol for running project development as an unattended, self-checkpointing agent loop. This is the core workflow that all AI agents in this repository follow.

## Operating Principles

- **Single prompt does not survive long runs.** Context windows and rate limits cap any one session. The shell drives the loop; the model is a stateless worker that runs once per iteration.
- **State lives in files, not in model memory.** Every iteration reads `PROGRESS.md`, does one chunk of work, and writes status back. Between iterations the model forgets everything.
- **Checkpoint after every phase.** Commit at least at the end of each logical phase. This keeps `git pull --ff-only` able to fast-forward and gives a recoverable history if an iteration goes wrong.
- **Non-blocking first.** If a task is blocked (missing dependency, needs a human decision, external service), write it to `BLOCKERS.md` and move to the next non-blocking task. Never stall the loop waiting for input.
- **Pull before working.** Sync from origin at the start of every iteration so the tree is current before changes are made.
- **No fake completion.** Never mark a phase done that is not actually complete. Blocked or partial work goes to `BLOCKERS.md` with honest scope.
- **Read context first.** Always read `AGENTS.md`, `CLAUDE.md`, and `AI_CONTEXT.md` at session start.

## Loop Contract

Each iteration performs exactly:

1. `git pull --ff-only origin <default-branch>` — sync; if not fast-forwardable, skip the iteration (do not create merge commits).
2. Read `AGENTS.md`, `AI_CONTEXT.md`, `PROGRESS.md` and `BLOCKERS.md`.
3. Pick the next non-blocked task from the plan.
4. Do the work. Run the relevant checks (linter, tests, build) before considering it done.
5. Write progress to `PROGRESS.md`. If blocked, append to `BLOCKERS.md`.
6. `git add -A && git commit -m "<type>(<scope>): <summary>"`.
7. Push changes.
8. Sleep the configured interval, then repeat until the time budget or the `PROGRESS.md` DONE marker is reached.

## State Files

- **`PROGRESS.md`** — Source of truth. Lists plan phases, status per phase (`pending` / `in_progress` / `done`), and the last completed step. The loop stops when it reads a `DONE` marker.
- **`BLOCKERS.md`** — Tasks that cannot proceed without a human, an external dependency, or a decision out of scope. Re-checked each iteration; cleared when resolved.

## Commit Convention

```
type(scope): description

Types: feat, fix, chore, docs, refactor, test, style, perf, ci, build
```

## Agent Roles

This template defines role-based agent skills in `rules/`:

| Role | File | Focus |
|------|------|-------|
| Architect | `rules/01-architect.md` | System design, technology decisions, ADRs |
| Coder | `rules/02-coder.md` | Feature implementation, bug fixes |
| Reviewer | `rules/03-reviewer.md` | Code review, quality gates |
| Tester | `rules/04-tester.md` | Test strategy, automation |
| DevOps | `rules/05-devops.md` | Infrastructure, CI/CD, deployment |

## Related

- `docs/decisions/` — Architecture Decision Records
- `docs/architecture.md` — System architecture documentation
- `rules/` — Role-specific agent skill files
