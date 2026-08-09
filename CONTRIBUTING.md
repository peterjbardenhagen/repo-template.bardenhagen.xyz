# Contributing

Thank you for your interest in improving this template. Contributions are welcome
from humans and AI agents alike — this repo follows the **Agentic AI SDLC**
protocol documented in `AGENTS.md`.

## Before You Start

Read `AGENTS.md` first. It is the source of truth for:
- Naming conventions and file structure
- Branch naming and commit format (Conventional Commits)
- The agentic SDLC loop: read → orient → plan → execute → verify → deliver
- Role-based rules in `rules/` and `.claude/agents/`

## Code of Conduct

Be respectful and inclusive. See `CODE_OF_CONDUCT.md`.

## Ways to Contribute

### 1. Report a Bug or Request a Feature

Use the issue templates under `.github/ISSUE_TEMPLATE/`:

- **Bug report** — Include reproduction steps, expected vs actual behaviour, and
  environment details.
- **Feature request** — Describe the problem, proposed solution, and alternatives
  considered.
- **Template uplift** — If you fixed something in a downstream project that every
  project would benefit from, use the uplift template to propose promoting it
  into the template.

### 2. Improve Documentation

Documentation drift is worse than a missing feature. If a change affects anything
user-facing (features, architecture, CI, workflow), update the docs in the same
PR:

- `README.md` — project overview and quick start
- `docs/` — deep-dive guides, ADRs, standards
- `CHANGELOG.md` — user-facing changes

### 3. Fix a Bug or Add a Feature

1. **Open an issue** describing the problem or feature.
2. **Discuss the approach** in the issue thread.
3. **Branch from `main`** and implement the change:
   ```bash
   git pull --ff-only origin main
   git checkout -b feat/description   # or fix/description, docs/description
   ```
4. **Commit using Conventional Commits**:
   ```
   type(scope): description
   ```
   | type | use for |
   |------|---------|
   | `feat` | New feature |
   | `fix` | Bug fix |
   | `docs` | Documentation only |
   | `chore` | Tooling, config, maintenance |
   | `refactor` | Code change that neither fixes nor adds |
   | `test` | Test additions |
   | `ci` | CI/CD changes |
   | `perf` | Performance improvement |
   | `security` | Security hardening |
5. **Ensure CI passes** — lint, test, build, CodeQL, Dependency Review.
6. **Submit a PR** using the provided template.

### 4. Propagate the Template

If you maintain a downstream project built from this template, use the
propagation script to sync changes:

```bash
bash scripts/propagate-template.sh --dry-run   # preview first
bash scripts/propagate-template.sh              # apply
```

Follow the **Human Review Loop** for downstream repos:
1. **Propagate** — preview and apply changes
2. **Review** — create a PR in the downstream repo
3. **Approve** — human reviews the propagation PR
4. **Merge** — human merges after verifying CI passes

## Pull Request Checklist

Every PR must satisfy all of the following:

- [ ] Commit message follows [Conventional Commits](https://www.conventionalcommits.org)
- [ ] `CI` workflow passes (lint, test, build)
- [ ] `CodeQL` scan has no new alerts
- [ ] `Dependency Review` passes (no new high-severity or forbidden licences)
- [ ] `CHANGELOG.md` updated for user-facing changes
- [ ] Documentation updated if behaviour changes
- [ ] Nothing in the original request was silently dropped
- [ ] Nothing unrequested was added (or called out explicitly)
- [ ] Assumptions are stated, including any that turned out wrong

## Branching Model

- `main` is the default branch and must remain deployable at all times
- Short-lived feature branches:
  - `feat/description` — new features
  - `fix/description` — bug fixes
  - `docs/description` — documentation only
  - `chore/description` — tooling, config, maintenance
- Never force-push or rewrite history on `main`
- Rebase onto `origin/main` before pushing

## Architecture Decisions

Non-trivial architecture or technology decisions need an **Architecture Decision
Record (ADR)** in `docs/decisions/` — see `rules/01-architect.md` for the
template. Open the ADR in the same PR as the change it justifies.

## AI Agent Contributors

This template is designed for AI coding agents. If you are an agent:

1. Read `AGENTS.md`, `AI_CONTEXT.md`, and the relevant `rules/` file for your
   role before starting.
2. Write decisions and progress to files (`HANDOFF.md`, `docs/decisions/`,
   specs/). Do not assume the next session has your context.
3. Commit after every logical phase of work.
4. Run `bash scripts/verify-action-pins.sh` before committing if you touched
   any workflow files.
5. Update `CHANGELOG.md` with every significant change.

## Questions?

Open an issue or reach out to the maintainer at
[peterjbardenhagen](https://github.com/peterjbardenhagen).
