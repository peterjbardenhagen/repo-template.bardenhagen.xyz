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
## 2026 CI/CD Best Practices

### Immutable OIDC Subject Claims

GitHub Actions OIDC tokens now support immutable subject claims (opt-in available since April 2026, automatic for repos created after July 15, 2026). This prevents repository-recycling attacks where a renamed repo could mint tokens trusted by the old identity.

**Action:** Opt in at the organization level:
```bash
gh api --method PUT /orgs/{org}/actions/oidc/settings/customizations/issuer \
  -f include_enterprise_slug=false \
  -f include_immutable_sub=true
```

Or via repository settings UI: **Settings → Actions → OIDC → Subject claim customization**.

### Actions Checkout Safety Defaults

As of June 2026, `actions/checkout` defaults to blocking untrusted code from forks in `pull_request_target` and similar triggers. Review your workflows for explicit opt-outs:

```yaml
# Only use if you understand the risk
- uses: actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1 # v7.0.1
  with:
    persist-credentials: false
    # fetch-depth: 0  # Only if you need full history
```

### Eval Gates for Agentic Changes

If your repository is modified by AI agents, add eval gates before merging:

```yaml
# Conceptual: agent eval gate
- name: Agent eval gate
  if: contains(github.event.pull_request.changed_files, 'prompts/') || contains(github.event.pull_request.changed_files, 'tools/')
  run: |
    # 1. Prompt lint (seconds)
    npx prompt-lint prompts/
    # 2. Offline eval on golden dataset (minutes)
    npm run eval:offline -- --dataset tests/golden.json
    # 3. Cost gate: block if cost per request increased >15%
    npm run eval:cost -- --threshold 0.15
```

### Deployment Verification

Always verify production health after deploy. Use `scripts/verify-deployment.sh` or inline checks:

```yaml
- name: Verify deployment
  run: |
    url=$(vercel ls --prod --token="${{ secrets.VERCEL_TOKEN }}" | head -n 1 | awk '{print $2}')
    status=$(curl -s -o /dev/null -w "%{http_code}" "$url")
    if [ "$status" != "200" ]; then
      echo "Deployment verification failed: HTTP $status"
      exit 1
    fi
```

### Network Firewall for Actions (Preview)

GitHub Actions network firewall logs all outbound traffic from workflow runs. Enable it to detect unusual behavior:

```yaml
- uses: step-security/harden-runner@b09bb98e06d4d774595224525879c09bc6e98c40 # v2.20.1
  with:
    egress-policy: block
    allow-same-org: true
    # egress-policy: audit  # Use 'audit' to log without blocking during migration
```

### Cost Tracking for Agent Runs

Log Actions minutes and token estimates per workflow run. Set budget alerts in GitHub Settings → Billing.

### Workflow Execution Policies

GitHub now supports enterprise/org/repo-level policies controlling who can trigger workflows and what trigger types are allowed. Enable them to reduce attack surface:

```bash
# Example: restrict workflow triggers to maintainers only
gh api --method PUT /repos/{owner}/{repo}/actions/permissions/workflow \
  -f enabled=true \
  -f allowed_actions=selected
```
