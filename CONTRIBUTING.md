# Contributing

Thank you for your interest in improving this template.

**Before you start:** Read `AGENTS.md` — it's the source of truth for both human and AI-agent contributors: conventions, branch naming, commit format, and the agentic SDLC protocol this repo follows.

## Code of Conduct

Be respectful and inclusive. See `CODE_OF_CONDUCT.md`.

## How to Contribute

1. Open an issue describing the problem or feature
2. Discuss the approach in the issue
3. Branch from `main` and implement the change: `git pull --ff-only origin main`
4. Commit using Conventional Commits: `type(scope): description` (see below)
5. Ensure CI passes (lint, test, build, CodeQL, Dependency Review)
6. Submit a PR using the provided template

## Commit Conventions

All commits must follow [Conventional Commits](https://www.conventionalcommits.org):

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

## Pull Request Checklist

- [ ] Commit message follows conventional commits
- [ ] `CI` workflow passes
- [ ] `CodeQL` scan has no new alerts
- [ ] `Dependency Review` passes (no new high-severity or forbidden licences)
- [ ] `CHANGELOG.md` updated for user-facing changes
- [ ] Documentation updated if behaviour changes

## Branching

- `main` is the default branch and must remain deployable
- Short-lived feature branches: `feat/description`, `fix/description`, `chore/description`, `docs/description`
- Never force-push or rewrite history on `main`

## Human Review Loop

For downstream template propagation, use this flow:

1. **Propagate** — Run `bash scripts/propagate-template.sh --dry-run` to preview changes
2. **Review** — Create a PR in the downstream repo
3. **Approve** — Human reviews the propagation PR
4. **Merge** — Human merges after verifying CI passes

For this repo itself, all PRs require human review before merging.

## Architecture changes

Non-trivial architecture or technology decisions need an ADR in `docs/decisions/` — see `rules/01-architect.md` for the template. Open the ADR in the same PR as the change it justifies.

## Reporting bugs / requesting features

Use the issue templates under `.github/ISSUE_TEMPLATE/`.

## Code of conduct

Be direct, be kind, assume good faith. No harassment, no gatekeeping.
>>>>>>> feat/agentic-template-upgrade
