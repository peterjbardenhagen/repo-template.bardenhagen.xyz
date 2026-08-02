# AGENTS.md — AI Agent Instructions

This file provides context and instructions for AI coding agents working in this repository. All AI tools (Claude Code, Codex, Cursor, Windsurf, GitHub Copilot, etc.) should read this file at session start.

## Project Orientation

This project is based on the **Repo Template** (`repo-template.bardenhagen.xyz`) — a comprehensive starter template for agentic AI SDLC covering naming conventions, git workflows, and autonomous development lifecycle protocols. Every project generated from this template inherits:

- **Agent instructions** — AI tools know how to operate (AGENTS.md, CLAUDE.md, etc.)
- **Role-based rules** — specialised instructions per agent role (`rules/`)
- **GitHub workflows** — CI/CD, security scanning, auto-assignment
- **Documentation** — conventions, git workflow, ADRs, getting started guides
- **Config files** — editor settings, git attributes, environment templates

## AI Agent Operating Principles

1. **Read context files first** — Check AGENTS.md, CLAUDE.md, AI_CONTEXT.md, and .cursorrules at the start of every session.
2. **Follow the Agentic SDLC** — See the README for the full autonomous development lifecycle protocol.
3. **State lives in files, not in model memory** — Write decisions, progress, and blockers to files. Do not assume the next session has context from this one.
4. **Commit frequently** — After every logical phase of work. Keep history clean and recoverable.
5. **Pull before working** — Always sync from origin before making changes. Use `git pull --ff-only`.
6. **No fake completion** — Never mark work done that isn't actually complete. Report blockers honestly.
7. **Conventional commits** — Use `type(scope): description` (e.g., `feat(auth): add OAuth2 flow`).
8. **Answer both questions** — "Did we build it correctly" *and* "did we build the right thing". The second is the expensive one and no test can check it. Define acceptance criteria before you code and verify against the original request before you call it done (`rules/07-analyst.md`). If it has a user-facing surface, apply `rules/06-ux.md` too.

## Ponytail — Lazy Senior Dev Mode

**Ponytail** (`ponytail.dev`) reduces code bloat by 54% on real AI agent work. Installed globally and included in `.claude/skills/ponytail/`.

**Activation (Claude Code):**
```
/ponytail full
```

**How it works:** Before writing code, stop at the first rung that holds:
1. Does this need to exist? → no: skip it (YAGNI)
2. Already in this codebase? → reuse it, don't rewrite
3. Stdlib does it? → use it
4. Native platform feature? → use it
5. Installed dependency? → use it
6. One line? → one line

This keeps every safety guard while cutting tokens, cost, and latency by ~20-27% vs. baseline.

## File Structure Overview

```
.
├── AGENTS.md              # This file — master agent instructions
├── CAPABILITIES.md        # Enterprise AI capabilities reference (BytePlus ↔ Claude mapping)
├── CLAUDE.md              # Claude-specific configuration
├── CODEX.md               # Codex-specific instructions
├── COPILOT_INSTRUCTIONS.md# GitHub Copilot instructions
├── AI_CONTEXT.md          # Project context summary (all agents)
├── .cursorrules           # Cursor AI rules
├── .windsurfrules         # Windsurf AI rules
├── rules/                 # Role-based agent skill files
│   ├── 01-architect.md    # Architecture agent
│   ├── 02-coder.md        # Coding agent
│   ├── 03-reviewer.md     # Code review agent
│   ├── 04-tester.md       # Testing agent
│   ├── 05-devops.md       # DevOps agent
│   ├── 06-ux.md           # UX/CX & accessibility agent
│   └── 07-analyst.md      # Requirements & acceptance agent
├── .claude/
│   ├── agents/            # Claude Code subagents (mirror rules/ roles)
│   ├── skills/            # Claude Code skills
│   │   └── template-uplift/  # Promote an improvement back into the template
│   └── settings.json      # Committed permission defaults
├── .github/rulesets/      # Branch-protection rules-as-code
├── .github/workflows/     # CI/CD pipelines (ci, deploy, security, stale)
├── CONTRIBUTING.md        # Human + agent contribution guide
├── docs/                  # Documentation
│   ├── agentic-sdlc.md    # Agentic SDLC protocol
│   ├── architecture.md    # Architecture documentation
│   ├── git-workflow.md    # Branching, commits, merging, force-push rules
│   ├── ci-cd.md           # Pipelines, permissions, supply-chain hardening
│   ├── web-standards.md   # Responsive, a11y, SEO — incl. banned patterns
│   ├── component-structure.md # App Router layout, data layer, styling
│   ├── build-versioning.md    # Build provenance in the footer
│   ├── github-standards.md    # Social card, metadata, issue forms, security
│   ├── claude-tooling.md      # .claude/ — agents, skills, hooks, MCP
│   ├── template-lifecycle.md  # Two-way sync with repo-template
│   └── decisions/         # Architecture Decision Records
├── scripts/               # Automation scripts (init, propagate, start-loop)
├── seeds/                 # Template seeds for project types
└── templates/             # Copyable scripts, components, styles
```

**Before writing code, read the standard that governs it** — `web-standards.md`
for anything with a UI, `component-structure.md` for React/Next work,
`git-workflow.md` before your first commit. Each carries a banned-patterns table
or checklist that is faster to scan than the bug it prevents is to debug.

## Anti-Patterns

- **Don't create a parallel implementation.** If similar functionality already exists, extend it. If this repo has a documented history of duplicate/abandoned implementations, it lives in `archive/README.md` — read it before starting new work in a mature area of the codebase.
- **Don't let docs drift from shipped state.** If a change affects anything user-facing (features, architecture, pricing, roadmap) and this project has a marketing site or public docs, update them in the *same* change — not a follow-up. Documentation drift is worse than a missing feature.

## Architecture Decisions

*Document each major stack/framework choice here with a one-line "why" — a lightweight alternative to a full ADR for decisions that don't need one:*

| Choice | Why |
|---|---|
| *[e.g. Postgres over SQLite]* | *[e.g. concurrent writes from day one]* |

## Performance Targets

*Add concrete numeric targets once known — forces "fast enough" into something checkable:*

| Metric | Target |
|---|---|
| *[e.g. p95 API latency]* | *[e.g. < 200ms]* |

## Manual Testing Checklist

*Things automated tests don't cover — update as the project grows:*

- [ ] *[e.g. cross-browser check on the checkout flow]*

## Release Process

*Numbered steps per deployable artifact:*

1. *[e.g. bump version, tag, `npm publish`]*

## Conventions

- `main` is the trunk — always green, always deployable. **Never commit to it directly.**
- Project-wide naming conventions are documented in the README. Follow them.
- Commit messages: `type(scope): description` (e.g., `feat(auth): add MFA support`).
- Branch from a current trunk: `git fetch origin && git checkout -B <branch> origin/main`.
  Rebase onto `origin/main` before pushing.
- PR branches: `feat/description`, `fix/description`, `chore/description`.
  Agent-authored: `claude/<feature>-<short-code>`.
- Squash merge, then delete the branch. `--force-with-lease` on your own branch
  only; never force-push `main`.
- Keep `.env` in `.gitignore`; document required variables in `.env.example`.
- Architecture decisions go in `docs/decisions/` as ADR files.
- Update `CHANGELOG.md` with every significant change.

Full branching, commit, and merge rules: [`docs/git-workflow.md`](docs/git-workflow.md).

## Agentic SDLC Protocol

1. **Read context** — AGENTS.md → CLAUDE.md → AI_CONTEXT.md → .cursorrules
2. **Orient** — `git fetch origin`, branch off `origin/main`, check issues/PRs/task
3. **Plan** — State approach before coding. Write/update ADR if architect role.
4. **Execute** — One logical change, run linters, commit.
5. **Verify** — Full tests + build. Update CHANGELOG.md.
6. **Deliver** — Rebase on `origin/main`, push branch, open PR.
7. **Land** — Drive CI to green. Never bypass a failing check; fix it or escalate it.

## Naming Standards (Quick Reference)

| Context | Convention | Example |
|---------|-----------|---------|
| GitHub repos | `kebab-case` | `repo-template.bardenhagen.xyz` |
| Folders | `kebab-case` | `src/features/` |
| Components (JS/TS/C#) | `PascalCase` | `UserProfile.tsx` |
| Utilities | `camelCase` | `formatDate.ts` |
| Python modules | `snake_case` | `data_loader.py` |
| CSS modules | `kebab-case` | `button.module.css` |
| Config files | `kebab-case` | `tailwind.config.js` |
| Environment vars | `UPPER_SNAKE` | `DATABASE_URL` |

## Pre-Commit Hooks

A `.pre-commit-config.yaml` is included to catch merge conflict markers before they're committed. Install and activate it:

```bash
pip install pre-commit
pre-commit install
pre-commit run --all-files  # Validate existing files
```

This prevents accidentally committing files with `<<<<<<< HEAD` markers and catches other common issues (trailing whitespace, YAML/JSON syntax errors, etc.).

## Before You Finish

- [ ] Read the relevant READMEs and `docs/` before making assumptions
- [ ] Followed existing patterns rather than introducing a new style
- [ ] Wrote/updated tests
- [ ] Updated docs (including this file's sections above, if they went stale)
- [ ] Ran the full build
- [ ] Tested manually if the change has a UI or user-facing surface
- [ ] For tool/config changes: reviewed `docs/TOOL-FILE-STRUCTURE.md` to ensure consistency

## Version

This template is versioned. See `CHANGELOG.md` for the current version and release history.

## Available Skills

- **template-uplift**: Promote an improvement from this project back into `repo-template.bardenhagen.xyz` so every future project inherits it. Use when told "add this to the template" / "every project should do this", or after fixing a bug whose root cause would recur in any project built from the template. See `.claude/skills/template-uplift/SKILL.md`.
- **kilo-config**: Guide for Kilo configuration: config paths, kilo.json fields, commands, agents, skills, permissions, MCPs, providers, TUI settings, plus Agent Manager worktree setup/run scripts, workflows, and state. Use for Kilo config questions, locating loaded config, changing settings, or Agent Manager questions about run/setup scripts, worktree setup/workflows, apply/merge/PR/conflicts, missing sessions/worktrees, and agent-manager.json recovery. See `.kilo/skills/kilo-config/SKILL.md`.
- **pr-auto-merge**: Automatically resolve merge conflicts, approve, merge, and delete branches for open pull requests. See `.kilo/skills/pr-auto-merge/SKILL.md`.
- **github-cleanup**: Clean up GitHub repositories by ensuring main branch is default, merging legacy master/Main/Master branches into main, and removing stale branches. See `.kilo/skills/github-cleanup/SKILL.md`.
- **vercel-deploy**: Deploy to Vercel with environment switching (prod/dev/preview). Creates site if needed, ensures build works, and verifies accessibility. Installs Vercel CLI if missing. See `.kilo/skills/vercel-deploy/SKILL.md`.

## 9Router AI Infrastructure

The repo template includes a comprehensive setup script for 9Router and related AI infrastructure components:

### Setup Script
```powershell
# Full installation with all components
.\scripts\setup-9router.ps1

# Selective installation
.\scripts\setup-9router.ps1 -SkipRTK
.\scripts\setup-9router.ps1 -SkipCLIProxy
.\scripts\setup-9router.ps1 -SkipCaveman
.\scripts\setup-9router.ps1 -SkipPonytail
```

### Components Installed

| Component | Description | Purpose |
|-----------|-------------|---------|
| **9Router** | AI Gateway with OpenAI-compatible endpoints | Routes requests to 40+ providers, auto-fallback, quota tracking |
| **CLIProxyAPI** | CLI proxy for OAuth-based providers | Connects Claude Code, Codex, Gemini subscriptions |
| **RTK** | Rust Token Killer - bash output compression | Saves 60-90% tokens on dev commands |
| **Caveman** | Terseness prompt injection | Cuts output tokens by ~65% |
| **Ponytail** | Lazy senior dev prompt injection | YAGNI-first code, 54% code reduction |

### Quick Start
1. Run `.\scripts\setup-9router.ps1`
2. Start 9Router: `cd ~/.ai-infrastructure/9router-source && npm run dev`
3. Open http://localhost:20128/dashboard
4. Configure AI tools: `http://localhost:20128/v1` with API key

### Environment Variables
```powershell
$env:NINEROUTER_URL = "http://localhost:20128"
$env:NINEROUTER_KEY = "sk-..."  # From dashboard
```

### Hermes Integration
Profiles updated automatically:
- `.hermes/profiles/default-profile.json` - Uses 9router as primary
- `.hermes/profiles/omniroute-profile.json` - OmniRoute with 9router fallback
