# Contributing

Thank you for your interest in improving this template.

## Code of Conduct

Be respectful and inclusive. See `CODE_OF_CONDUCT.md`.

## How to Contribute

1. Open an issue describing the problem or feature
2. Discuss the approach in the issue
3. Branch from `main` and implement the change
4. Ensure CI passes (lint, test, build, CodeQL, Dependency Review)
5. Submit a PR using the provided template

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
- Short-lived feature branches: `feat/description`
- Bug fixes: `fix/description`
- Docs: `docs/description`
- Never force-push or rewrite history on `main`

## Human Review Loop

For downstream template propagation, use this flow:

1. **Propagate** — Run `bash scripts/propagate-template.sh --dry-run` to preview changes
2. **Review** — Create a PR in the downstream repo
3. **Approve** — Human reviews the propagation PR
4. **Merge** — Human merges after verifying CI passes

For this repo itself, all PRs require human review before merging.
