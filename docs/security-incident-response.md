# Security Incident Response (IR) Runbook

## Purpose

This runbook defines the escalation matrix, containment procedures, and post-incident review process for security events affecting this repository, its CI/CD pipelines, and its downstream consumers.

## Severity Levels

| Level | Criteria | Response Time | Escalation |
|-------|----------|---------------|------------|
| **P0 — Critical** | Active exploit, credential leak, supply chain compromise | 15 minutes | On-call + security lead + repo maintainer |
| **P1 — High** | Suspicious PR, workflow permission change, blocked secret scan | 1 hour | Security lead + repo maintainer |
| **P2 — Medium** | Failed dependency review, stale dependabot PR, outdated base image | 4 hours | Repo maintainer |
| **P3 — Low** | Pre-commit hook failure, lint warning, documentation drift | 24 hours | Next scheduled maintenance |

## Incident Taxonomy

### 1. Supply Chain Compromise

**Indicators:**
- Unexpected `package.json`, `requirements.txt`, or `Dockerfile` changes
- New or updated dependencies with no review comment
- Dependabot PRs that modify lockfiles outside the scheduled window

**Containment:**
1. `git checkout` the pre-incident commit and open a revert PR
2. Run `npm audit` / `pip audit` / `trivy fs` against the clean state
3. Rotate any secrets that may have been exposed (Vercel tokens, GitHub secrets, cloud credentials)
4. Enable GitHub's `pull_request_target` checkout protection (already default in `actions/checkout` v7+)

**Post-incident:**
- Update `.github/dependabot.yml` schedule if the window was exploited
- Add the compromised package version to `SECURITY.md` known-vuln table

### 2. Credential Leakage

**Indicators:**
- Gitleaks, truffleHog, or GitHub secret scanning alert
- `.env` file committed without `.gitignore` protection
- Hardcoded API keys in workflow YAML or source code

**Containment:**
1. **Revoke immediately** — use GitHub's credential revocation API or cloud provider console
2. **Rotate** — generate a new secret and update the legitimate consumer (Vercel, AWS, etc.)
3. **Remove from history** — if the leak is in git history, use `git filter-repo` or BFG Repo-Cleaner
4. **Force-push** — only if branch protection rules permit; otherwise open a revert PR

**Post-incident:**
- Add the secret pattern to `.pre-commit-config.yaml` `detect-private-key` rules
- Update `SECURITY.md` with the incident date and remediation steps

### 3. Workflow Permission Drift

**Indicators:**
- PR modifies `permissions:` block in a workflow to grant `write` or `id-token: write` without review
- New third-party action introduced without SHA pin
- Deployment job moved from reusable workflow to inline without security review

**Containment:**
1. Request platform-owner review before merge
2. Validate all action references are SHA-pinned (`scripts/verify-action-pins.sh`)
3. Confirm least-privilege: `contents: read` by default, expanded only where needed

**Post-incident:**
- Update `docs/ci-cd.md` with the new workflow pattern
- Add the permission pattern to `rules/05-devops.md`

### 4. Agent Misbehavior (Autonomous Loop)

**Indicators:**
- Agent commits changes outside the approved scope (e.g., modifies `docs/web-standards.md` during a backend task)
- Agent introduces flaky tests or removes test coverage
- Agent opens PRs from compromised or untrusted sources
- Cost-per-task spikes 3x above rolling median

**Containment:**
1. Kill the loop (`touch STOP` or write `DONE` to `PROGRESS.md`)
2. Revert the agent's last N commits (identify via conventional commit prefix `feat(agent):`)
3. Review `blockers.md` and `PROGRESS.md` for root cause
4. If scope violation: add the forbidden paths to `CLAUDE.md` / `AGENTS.md` `ignored_paths`
5. If flaky tests: quarantine the test, file a bug, and update the test plan

**Post-incident:**
- Update `docs/agentic-sdlc.md` with the new guardrail
- Adjust the agent's role file in `rules/02-coder.md` or `rules/05-devops.md`

### 5. Deployment Compromise

**Indicators:**
- Vercel deployment alert (unexpected domain, rollback, or error rate spike)
- GitHub environment protection bypassed
- Production traffic routed to an unverified version

**Containment:**
1. Trigger rollback via Vercel CLI: `vercel rollback [deployment-url]`
2. Verify the previous good deployment serves correctly
3. Inspect `vercel.json` routing rules for unauthorized changes
4. Notify downstream consumers via GitHub Discussions / status page

**Post-incident:**
- Update `RELEASE_NOTES.md` with the incident summary
- Add canary deployment step to `docs/ci-cd.md` if not already present

## Escalation Matrix

```
P0: on-call (Slack #security-alerts) → security lead (PagerDuty) → repo maintainer
P1: security lead → repo maintainer
P2: repo maintainer → next scheduled maintenance
P3: next scheduled maintenance
```

## Communication Templates

### Internal (Slack / Teams)

```
[P{level}] Security incident in {repo}: {brief description}
Status: {investigating / contained / resolved}
Action: {what was done}
Next: {what remains}
Runbook: https://github.com/{owner}/{repo}/blob/main/docs/security-incident-response.md
```

### External (GitHub Security Advisory)

```
A security vulnerability was identified in {repo} versions {affected}.
The issue has been patched in version {fixed}.
Users should update to {fixed} immediately.
Credit: {discoverer}
```

## Drills

Run a tabletop exercise quarterly:
1. Pick an incident type from the taxonomy above
2. Walk through containment steps without modifying production
3. Time each phase and update target response times
4. Document gaps and update this runbook
