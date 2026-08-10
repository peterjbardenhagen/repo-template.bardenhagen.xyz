# Changelog

## [2.7.0] — 2026-08-10

### Added
- **Harness Engineering:** Added constraint harness, feedback loop, and quality gate patterns to `docs/agentic-sdlc.md`
- **Plan-Execute-Verify (PEV):** Documented three-phase agent architecture with explicit verification gates
- **Multi-Agent Coordination Taxonomy:** Added 2026 platform patterns (local, managed, cloud) to `docs/agentic-sdlc.md`
- **Context Engineering Best Practices:** Added progressive disclosure, rules files, and context lake guidance
- **AI-Native Documentation Schema:** Updated `docs/structure-for-ai.md` with machine-readable metadata for agent consumption
- **Web Standards 2026:** Updated `docs/web-standards.md` with Core Web Vitals, WCAG 2.2, and AI-content accessibility patterns
- **Kanban Tasks:** Added 6 new high-value tasks covering roadmap cleanup, research, and platform acceleration
- **Skills Pack:** Installed 19 skills from `skills.sh/p/RuPk5l3SiAv8BgSH` across all 76 agents

### Changed
- **Branch Hygiene:** Merged `dependabot/docker/node-26-alpine` and `dependabot/github_actions/github-actions-5e32b1bf7f` into `main`
- **Agentic SDLC:** Enhanced protocol with 2026 production patterns from Anthropic, Deloitte, and Alice Labs research

### Security
- **Supply Chain:** Upstream Dependabot updates merged for Docker base image and GitHub Actions


## [2.6.0] — 2026-08-09

### Added
- **Dockerfile security hardening:** Added non-root user (`nodejs`), installed `jq` in build stage, set proper ownership on `/app`
- **Pre-commit private key detection:** Added `detect-private-key` hook to `.pre-commit-config.yaml`
- **Expanded HANDOFF.md:** Added concrete examples for In Flight, Next Picks, Blockers, and Recent Decisions sections
- **Development docker-compose service:** Added commented `dev` service with bind mounts for live reload
- **Expanded issue template config:** Added contact links for Discussions, Contributing Guide, and Template Uplift

### Changed
- **Vercel CLI pinned to v58:** Changed `vercel@latest` to `vercel@58` in both `deploy-preview.yml` and `deploy-prod.yml` for reproducible deploys
- **docker-compose.yml:** Removed production volume bind-mount anti-pattern; app now runs from image only
- **.devcontainer:** Updated base image from `node:20` to `node:25` to match project baseline
- **.github/ISSUE_TEMPLATE/config.yml:** Added contact links for community resources

### Fixed
- **Dockerfile:** Fixed missing `jq` dependency that would cause `npm run build` check to fail
- **Dockerfile:** Fixed root user execution in production stage (security best practice)

## [2.5.0] — 2026-08-09

### Added
- **Vercel Analytics integration:** Added free Vercel Web Analytics and Speed Insights to `docs/index.html` and documented setup for both static sites and Next.js apps
- **Website enhancements:** Added SEO meta tags (description, Open Graph, Twitter Card), favicon, skip-to-content link, and `aria-label` to navigation
- **Contributing section on landing page:** New "How to Contribute" section in `docs/index.html` with CTAs to the Contributing Guide and GitHub Issues
- **Expanded CONTRIBUTING.md:** Added structured sections for AI agents, architecture decisions, template propagation, and PR checklist
- **How to Contribute in getting-started.md:** Added contribution guidance and template uplift instructions to the quick-start guide

### Changed
- **Canonical URL:** Updated from GitHub repo URL to `https://repo-template.bardenhagen.xyz/`
- **docs/index.html navigation:** Added Contribute link alongside GitHub, Docs, and SDLC links
- **docs/build-versioning.md:** Added Vercel Analytics section with Next.js and static HTML examples
- **docs/website-polishing-standards.md:** Added Analytics section to the polishing standards
- **README.md:** Added Vercel Analytics subsection under Vercel Integration with code examples

## [2.4.0] — 2026-08-09

### Added
- **Landing page:** New `docs/index.html` with dark theme, hero, feature grid, and explore pills for repo-template.bardenhagen.xyz
- **GitHub Repo Hygiene section:** 5-step cleanup checklist in `README.md` covering default branch enforcement, legacy branch merging, stale branch deletion, issue triage, and clean-state verification
- **`github-cleanup` Claude skill:** New `.claude/skills/github-cleanup/SKILL.md` enabling agents to run repo cleanup workflows directly

### Changed
- **README.md:** Restructured duplicate sections, expanded Project Structure diagram to reflect actual repository contents, updated TOC numbering
- **docs/index.html:** Bumped browser tab title to `Repo Template — AI Agentic SDLC`

## [2.3.0] — 2026-08-08

### Added
- **Supply chain security hardening:** OpenSSF Scorecard, Gitleaks, actionlint, SBOM generation, and SLSA provenance workflows
- **Structured content for AI:** `docs/structure-for-ai.md` defines machine-readable context schema for agents
- **Spec-driven development:** `docs/spec-driven-development.md` with lightweight SDD methodology and two-way door test
- **MCP configuration:** `.mcp.json` with Context7, GitHub, and Playwright MCP servers pre-configured
- **PR body validation:** Enforces Conventional Commits format and linked issues on pull requests
- **CODEOWNERS:** Automatic review assignment for key directories
- **Worktree scripts:** `scripts/worktree-create.sh`, `worktree-list.sh`, `worktree-remove.sh` for parallel agent development
- **Harden-Runner:** Runtime security hardening added to CI and deploy workflows
- **HANDOFF.md:** Live working state template for agent session continuity
- **specs/ directory:** Constitution scaffold (`mission.md`, `tech-stack.md`, `initiatives/`) for spec-driven development
- **docs/supply-chain-hardening.md:** Comprehensive supply chain security reference

### Changed
- **CI workflow:** Added Harden-Runner step, updated node baseline from 20 to 25, added YAML anchors for reusable steps
- **Deploy workflows:** Added Harden-Runner, fixed bare expressions in job-level `if:` conditions, added per-step `if:` guards for VERCEL_TOKEN configuration
- **Dependabot:** Updated Docker base image from `node:20-alpine` to `node:25-alpine`
- **All GitHub Actions:** SHA pins verified against live upstream tags
- **AGENTS.md:** Added structured context loading principle, progressive disclosure guidance, and references to new files

### Fixed
- **Merge conflict resolution:** Resolved all `<<<<<<< HEAD` markers from prior branch merges
- **Dockerfile:** Bumped Node.js base image to current stable (`node:25-alpine`)

## [2.2.0] — 2026-08-08

### Fixed
- **Merge conflict resolution:** Resolved all `<<<<<<< HEAD` markers from `feat/agentic-template-upgrade` branch merge
  - Hardened `.github/workflows/deploy-preview.yml` and `security-scan.yml` with SHA-pinned actions and proper permissions
  - Unified CONTRIBUTING.md with both human and AI contribution workflows
  - Enhanced agent configs in `.claude/agents/` with more detailed principles (security by design, property-based testing, etc.)
  - Cleaned up `.gitignore` to remove duplicate entries

### Added
- `.pre-commit-config.yaml` with hooks to detect merge conflicts, YAML/JSON validation, trailing whitespace, and Markdown linting
- `docs/TOOL-FILE-STRUCTURE.md` — clarifies source of truth for AI tool configurations (.claude/ vs rules/ vs IDE-specific files)
- Pre-commit installation instructions in AGENTS.md

### Changed
- Upgraded GitHub Actions: `actions/checkout` to v7.0.1, `docker/build-push-action` to v7.3.0
- Dependabot configuration deduplicated and standardised to weekly Monday 09:00 AEST
- Docker base image moved from `node:26-alpine` to `node:20-alpine` (current LTS)
- All SHA pins verified against live upstream tags

## [2.0.0] — 2026-07-21
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
