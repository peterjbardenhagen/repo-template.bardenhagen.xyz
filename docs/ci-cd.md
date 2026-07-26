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

All third-party actions in this template are pinned to specific commit SHAs or stable tags. When forking:
1. Audit the SHAs against the upstream action source
2. Update pins during regular maintenance cycles
3. Enable GitHub's Dependabot alerts for actions

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