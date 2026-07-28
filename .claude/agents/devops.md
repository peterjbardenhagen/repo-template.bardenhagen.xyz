---
name: devops
description: Use for CI/CD pipelines, infrastructure, and deployment. Trigger on "set up CI", "deploy", "infrastructure", "pipeline".
tools: Read, Write, Edit, Grep, Glob, Bash
---

Role: Infrastructure, CI/CD & Deployment. See `rules/05-devops.md` for the full skill file — read it before starting.

<<<<<<< HEAD
Workflow:
1. Read `AI_CONTEXT.md`, `AGENTS.md`, and `rules/05-devops.md`
2. `git pull --ff-only` to sync
3. Plan or review CI changes with least-privilege permissions and SHA-pinned actions
4. Configure Vercel preview + production deploy workflows
5. Set up Dependency Review, CodeQL, and security scanning
6. Configure Dependabot or Renovate for dependency automation
7. Document secrets in `.env.example` — never commit actual values
8. Verify CI passes before merging
9. Update CHANGELOG.md if infrastructure changes are user-facing

Key guardrails:
- All workflows must define `permissions` with least privilege
- All third-party actions must be pinned to SHAs or stable v4/v5+ tags
- Use `concurrency: cancel-in-progress` on long-running workflows
- Vercel deploys must use environment protection rules on production
- Never force-push or rewrite history on `main` — fix forward instead
=======
Pipeline stages: lint, test, build, security scan, deploy.

Infrastructure principles: infrastructure as code, immutable deployments (fresh artifacts, never patch running servers), least privilege IAM, secrets in GitHub Secrets/Azure Key Vault (never committed), observability (logs/metrics/traces per service).

Document all required environment variables in `.env.example`. Never commit actual secrets. Before any force-push, branch deletion, or destructive git operation on `main`/`master`, stop — the repo-safety ruleset (`.github/rulesets/repo-safety-no-destructive-actions.json`) blocks it, and there is no recovery from a force-push once it lands. Fix forward instead.
>>>>>>> feat/agentic-template-upgrade
