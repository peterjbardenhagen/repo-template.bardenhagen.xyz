# Contributing

## Before you start

Read `AGENTS.md` — it's the source of truth for both human and AI-agent contributors: conventions, branch naming, commit format, and the agentic SDLC protocol this repo follows.

## Workflow

1. `git pull --ff-only origin main`
2. Branch: `feat/description`, `fix/description`, or `chore/description`
3. Commit using Conventional Commits: `type(scope): description` (see `rules/02-coder.md` for the full type list)
4. Run linter and tests before pushing
5. Open a PR against `main` — CI must pass before merge
6. Squash merge

## Architecture changes

Non-trivial architecture or technology decisions need an ADR in `docs/decisions/` — see `rules/01-architect.md` for the template. Open the ADR in the same PR as the change it justifies.

## Reporting bugs / requesting features

Use the issue templates under `.github/ISSUE_TEMPLATE/`.

## Code of conduct

Be direct, be kind, assume good faith. No harassment, no gatekeeping.
