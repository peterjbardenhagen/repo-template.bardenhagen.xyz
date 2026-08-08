# Release Notes

## v2.1.0 — 2026-08-08

### Summary
Hardened supply-chain security and cleaned up long-standing template debt.

### Highlights
- Resolved all merge conflict markers from prior branch merges
- Upgraded `actions/checkout` to v7.0.1 and `docker/build-push-action` to v7.3.0
- Deduplicated and standardised Dependabot config (weekly Monday 09:00 AEST)
- Replaced bleeding-edge `node:26-alpine` base image with current LTS `node:20-alpine`
- Removed duplicate `.gitignore` entries
- Added `.pre-commit-config.yaml` with merge-conflict detection, YAML/JSON validation, and Markdown linting
- Fixed CONTRIBUTING.md merge conflict markers

## v2.0.0 — 2026-07-21

### Summary
Major rewrite consolidating naming conventions, git workflows, and the Agentic AI SDLC protocol into a single reusable template.

### Highlights
- Renamed from `perfect-repo-template-pjb` to `repo-template.bardenhagen.xyz`
- Default branch switched from `master` to `main`
- Comprehensive naming conventions guide (files, folders, repos, env vars, AI/ML)
- Expanded Agentic AI SDLC: multi-agent handoff pipeline, error recovery, kanban integration
- AI/ML extensions (experiment tracking, model weights, data versioning)
- Repository organisation guidance (monorepo vs separate repos)
- All GitHub Actions references pinned to SHAs or stable v4/v5+ tags
- Least-privilege permissions model across all workflows
- New workflows: dependency-review, deploy-prod, ghcr-push, stale
- Security docs: SECURITY.md, CODE_OF_CONDUCT.md
- Autonomous loop scripts: start-loop.sh, start-loop.ps1
- Loop state files: PROGRESS.md, blockers.md
- .devcontainer config for GitHub Codespaces
- Renovate config as alternative to Dependabot
- Expanded Dependabot config (npm, pip, cargo, gomod, nuget)
- Vercel OIDC setup guide
- CI/CD workflow index and troubleshooting doc
- Enhanced project seeds (Next.js, Python, .NET)
- Rewritten CONTRIBUTING.md with PR checklist and commit conventions

## v1.0.0 — 2026-07-20

### Summary
Initial template structure with AI agent configs, role-based rules, GitHub workflows, and propagation scripts.

### What's New
- AGENTS.md, CLAUDE.md, CODEX.md, COPILOT_INSTRUCTIONS.md, AI_CONTEXT.md
- Role-based agent skill files (architect, coder, reviewer, tester, devops)
- CI/CD workflows, issue/PR templates, Dependabot config
- Documentation structure with ADR support
- Project seeds for dotnet, nextjs, python
- Init and propagate scripts
- Dockerfile and docker-compose.yml

## Origin

Synthesised from patterns and configs across:
- AI-agent projects (AGENTS.md, agentic-sdlc.md, CI workflows, Docker configs)
- ai-test-orchestrator (CLAUDE.md, Windsurf workflows)
- apartment-1507 (AI/ documentation directory)
- mydesk.digitalresponse.com.au (GitHub workflows)
- Various other repos (naming conventions, deployment patterns, CI templates)
