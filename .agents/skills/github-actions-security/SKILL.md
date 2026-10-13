---
name: github-actions-security
description: Design, review and harden GitHub Actions CI/CD and agentic automation using least privilege, trusted event boundaries and reproducible artifacts.
---

# GitHub Actions Security Skill

## Workflow

1. Identify triggers, untrusted event payloads, required permissions, secrets, environments, artifacts and deployment side effects.
2. Default workflow permissions to read-only and grant write scopes only at the job that needs them.
3. Pin actions to verified full commit SHAs; confirm version comments against the source tag.
4. Treat `pull_request_target`, `workflow_run`, deployment jobs and any write-enabled token as privileged. Never execute untrusted PR code with privileged credentials.
5. Use OIDC and short-lived cloud credentials where supported; scope secrets to protected environments.
6. Add timeouts, safe concurrency, bounded retries, cache isolation and artifact provenance checks.
7. Lint workflows and validate action pins, permissions, trigger behavior and failure paths.
8. Ensure required checks cover PRs and the default branch; include `merge_group` when using merge queues.
9. Require independent review for changes to security workflows, branch rules, deployment permissions and auto-merge policy.
10. Report residual risks and exact verification evidence; never claim checks passed without observing successful runs.

## Review checklist

- [ ] `permissions: contents: read` at workflow level unless evidence requires more.
- [ ] Job-level permissions are minimal and documented.
- [ ] Third-party actions use verified full-length SHAs.
- [ ] Shell commands do not interpolate untrusted event fields directly.
- [ ] Fork PR workflows cannot access secrets or write tokens.
- [ ] Caches and artifacts do not cross untrusted/trusted boundaries.
- [ ] Production environment has branch restrictions and approval controls as appropriate.
- [ ] Concurrency cannot cancel the only release/merge-queue gate.
- [ ] Secrets are never printed or uploaded.
- [ ] Security scans, dependency review and test gates are required and observable.
- [ ] Auto-merge cannot bypass branch protection or review policy.

## References

- https://docs.github.com/en/actions/security-for-github-actions/security-guides/security-hardening-for-github-actions
- https://docs.github.com/en/actions/reference/security/secure-use
- https://docs.github.com/en/actions/security-for-github-actions/security-guides/automatic-token-authentication
