# Changelog

## [Unreleased]

### Added
- `/kilo-config` skill description in AGENTS.md
- Hardened GitHub Actions workflows: least-privilege permissions, SHA-pinned actions, concurrency cancellation
- New workflows: `dependency-review.yml`, `deploy-prod.yml`, `ghcr-push.yml`, `stale.yml`
- Security docs: `SECURITY.md`, `CODE_OF_CONDUCT.md`
- Autonomous loop scripts: `scripts/start-loop.sh`, `scripts/start-loop.ps1`
- Loop state files: `PROGRESS.md`, `blockers.md`
- `.devcontainer/devcontainer.json` for GitHub Codespaces
- `.github/renovate.json` as alternative dependency automation
- Expanded `dependabot.yml` to cover npm, pip, cargo, gomod, nuget
- `docs/vercel-oidc.md` — Vercel OIDC Federation setup guide
- `docs/ci-cd.md` — Workflow index, permissions model, and troubleshooting
- Enhanced seeds for Next.js, Python, and .NET with checklists and recommended packages
- Improved `docs/getting-started.md` with template clone, GitHub setup, and Vercel steps
- Expanded `docs/architecture.md` with observability section
- Rewrote `CONTRIBUTING.md` with PR checklist and commit conventions

### Changed
- All GitHub Actions references pinned to SHAs or stable v4/v5+ tags
- CI, security, and deploy workflows now cancel in-progress runs on re-runs
- Dependabot auto-merge workflow upgraded to `v2.5.0`
- CodeQL analysis upgraded to `v3.27.1`
- README.md restructured with new GitHub Actions & Vercel Integration sections
- AI_CONTEXT.md updated with GH Actions and Vercel conventions
- AGENTS.md file structure overview updated for new files

## [2.0.0] — 2026-07-21

### Added
- Comprehensive naming conventions guide (file, folder, repo, env vars, AI/ML)
- Git workflow documentation (trunk-based dev, Vercel vs non-Vercel deploy strategy)
- Agentic AI SDLC expansion: multi-agent handoff pipeline, error recovery, kanban integration
- AI/ML specific extensions (experiment tracking, model weights, data versioning)
- Repository organization guidance (monorepo vs separate repos)

### Changed
- Renamed from `perfect-repo-template-pjb` to `repo-template.bardenhagen.xyz`
- Default branch switched from `master` to `main`
- Updated all references throughout agent configs, scripts, and workflows
- README rewritten with table of contents and expanded across 5 major sections
- AGENTS.md updated with naming standards quick-reference table

### Fixed
- All branch references updated from `master` to `main` in workflows and scripts

## [1.0.0] — 2026-07-20

### Added
- Initial template structure: AI agent configs, role-based rules, GitHub workflows
- AGENTS.md, CLAUDE.md, CODEX.md, COPILOT_INSTRUCTIONS.md, AI_CONTEXT.md
- Role-based agent skill files (architect, coder, reviewer, tester, devops)
- CI/CD workflows, issue/PR templates, dependabot config
- Documentation structure with ADR support
- Project seeds for dotnet, nextjs, python
- Init and propagate scripts
- Dockerfile and docker-compose.yml
