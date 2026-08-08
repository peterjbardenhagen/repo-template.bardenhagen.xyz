# CI/CD Reference

This document explains every CI/CD workflow in this template and how to customise them.

## Workflow Index

| File | Purpose | Trigger |
|------|---------|---------|
| `.github/workflows/ci.yml` | Lint, test, build | push + PR to main |
| `.github/workflows/codeql-analysis.yml` | Semantic code analysis | push + PR + weekly |
| `.github/workflows/security-scan.yml` | Container / dependency scan | push + PR + weekly |
| `.github/workflows/deploy-preview.yml` | Vercel preview deployment | PR opened/updated |
| `.github/workflows/deploy-prod.yml` | Vercel production deploy | push to main + manual |
| `.github/workflows/ghcr-push.yml` | Multi-arch Docker push to GHCR | push to main + tags |
| `.github/workflows/dependency-review.yml` | Dependency vulnerability + licence check | PR with lockfile changes |
| `.github/workflows/dependabot-auto-merge.yml` | Auto-merge Dependabot PRs | Dependabot PRs |
| `.github/workflows/stale.yml` | Close stale issues/PRs | nightly |

## Permissions Model

This template follows **least privilege** for `GITHUB_TOKEN`:
- `ci.yml`, `security-scan.yml`, `codeql-analysis.yml`: `contents: read`
- `deploy-preview.yml`, `deploy-prod.yml`: `contents: read`, `id-token: write`
- `ghcr-push.yml`: `contents: read`, `packages: write`
- `dependency-review.yml`: `contents: read`, `pull-requests: write`
- `stale.yml`: `contents: read`, `issues: write`, `pull-requests: write`

## Path Filtering

To reduce CI minutes, add `paths` / `paths-ignore` to workflow triggers. For example:

```yaml
on:
  push:
    branches: [main]
    paths:
      - 'src/**'
      - 'tests/**'
      - 'package.json'
      - 'pnpm-lock.yaml'
```

## Supply-Chain Hardening

Every third-party action is pinned to a full commit SHA with the version in a
trailing comment. The comment is not decoration — Dependabot needs it to bump
the pin, and `verify-action-pins.sh` needs it to check the pin is real:

```yaml
uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7.0.1
```

### Never invent a SHA

Resolve it from the live repo:

```bash
git ls-remote https://github.com/OWNER/REPO 'refs/tags/TAG^{}' refs/tags/TAG \
  | sort -k2 | tail -1 | cut -f1
```

The `^{}` matters. For an *annotated* tag, `refs/tags/vX` is the tag object, not
the commit, and a pin to the tag object does not resolve.

A made-up SHA is worse than a floating tag. The job does not run degraded — it
never starts, failing with `Unable to resolve action ... unable to find version`,
and the workflow file looks completely correct because one 40-hex string is
indistinguishable from another. This is a mistake both humans and agents make
easily.

### The guard

`scripts/verify-action-pins.sh` runs as the **Verify action pins** CI job and
fails the build on any of:

| Failure | Why it matters |
|---|---|
| SHA does not match its comment tag | The job cannot start |
| Comment tag does not exist upstream | The pin can never be verified or bumped |
| Pinned SHA with no version comment | Unverifiable; Dependabot cannot bump it |
| Floating tag (`@v4`) | The thing pinning exists to prevent |

Run it locally before pushing a workflow change:

```bash
./scripts/verify-action-pins.sh
```

Also enable Dependabot alerts for `github-actions` (already configured in
`.github/dependabot.yml`) — it updates SHA pins in place and keeps the comment
in sync.

## Prerequisite: enable Code scanning

CodeQL analyses successfully but **cannot upload its results** until code
scanning is switched on for the repository. The job fails with:

```
Code scanning is not enabled for this repository.
Please enable code scanning in the repository settings.
```

This is a repository setting, not a workflow bug — no change to
`codeql-analysis.yml` can fix it. Enable it once per repo:

**Settings → Code security → Code scanning → Set up → Advanced**

(Free on public repositories; requires GitHub Advanced Security on private ones.)

The workflow is deliberately left strict rather than tolerating the upload
failure: a CodeQL job that passes without publishing results looks like working
security coverage while providing none.

## Environment Protection

Production deploys are gated by GitHub environment protection rules:
1. Go to **Settings → Environments → New environment → `production`**
2. Enable **Required reviewers** (select team members)
3. Optionally wait timer (e.g., 5 minutes) for safety

## Customising for Your Stack

Each workflow contains placeholder commands (e.g., `echo "Add your linter command here"`). Replace them with the appropriate commands for your language and framework. See `seeds/` for stack-specific hints.

## Troubleshooting

| Symptom | Cause | Fix |
|---------|-------|-----|
| CI fails on checkout | Private repo without token scope | Add `permissions: contents: read` |
| Preview deploy not posting URL | Missing `issues: write` | Add `issues: write` to permissions |
| Dependency Review blocks PR | High-severity vulnerability | Inspect alert, update dep, or adjust `fail-on-severity` |
| Stale bot closing too fast | Default thresholds lenient | Adjust `days-before-stale` / `days-before-close` |