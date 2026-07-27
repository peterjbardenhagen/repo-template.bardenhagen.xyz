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
│   └── 05-devops.md       # DevOps agent
├── .claude/
│   ├── agents/            # Claude Code subagents (mirror rules/ roles)
│   ├── skills/            # Claude Code skills (empty by default)
│   └── settings.json      # Committed permission defaults
├── .github/rulesets/      # Branch-protection rules-as-code
├── .github/workflows/     # CI/CD pipelines (ci, deploy, security, stale)
├── scripts/               # Automation scripts (init, propagate, start-loop)
├── seeds/                 # Template seeds for project types
└── templates/             # Config file templates
```

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

- Default branch is `main` for all work unless a feature branch is explicitly specified.
- Project-wide naming conventions are documented in the README. Follow them.
- Commit messages: `type(scope): description` (e.g., `feat(auth): add MFA support`).
- Run `git pull --ff-only` before starting work and before pushing.
- Keep `.env` in `.gitignore`; document required variables in `.env.example`.
- Architecture decisions go in `docs/decisions/` as ADR files.
- Update `CHANGELOG.md` with every significant change.
- PR branches: `feat/description`, `fix/description`, `chore/description`.

## Agentic SDLC Protocol

1. **Read context** — AGENTS.md → CLAUDE.md → AI_CONTEXT.md → .cursorrules
2. **Orient** — `git pull --ff-only`, check issues/PRs/task
3. **Plan** — State approach before coding. Write/update ADR if architect role.
4. **Execute** — One logical change, run linters, commit.
5. **Verify** — Full tests + build. Update CHANGELOG.md.
6. **Deliver** — Push branch, create PR (if multi-agent) or merge (if solo + CI passing).

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

## Before You Finish

- [ ] Read the relevant READMEs and `docs/` before making assumptions
- [ ] Followed existing patterns rather than introducing a new style
- [ ] Wrote/updated tests
- [ ] Updated docs (including this file's sections above, if they went stale)
- [ ] Ran the full build
- [ ] Tested manually if the change has a UI or user-facing surface

## Version

This template is versioned. See `CHANGELOG.md` for the current version and release history.

## Available Skills

- **kilo-config**: Guide for Kilo configuration: config paths, kilo.json fields, commands, agents, skills, permissions, MCPs, providers, TUI settings, plus Agent Manager worktree setup/run scripts, workflows, and state. Use for Kilo config questions, locating loaded config, changing settings, or Agent Manager questions about run/setup scripts, worktree setup/workflows, apply/merge/PR/conflicts, missing sessions/worktrees, and agent-manager.json recovery. See `.kilo/skills/kilo-config/SKILL.md`.
- **pr-auto-merge**: Automatically resolve merge conflicts, approve, merge, and delete branches for open pull requests. See `.kilo/skills/pr-auto-merge/SKILL.md`.
- **github-cleanup**: Clean up GitHub repositories by ensuring main branch is default, merging legacy master/Main/Master branches into main, and removing stale branches. See `.kilo/skills/github-cleanup/SKILL.md`.
- **vercel-deploy**: Deploy to Vercel with environment switching (prod/dev/preview). Creates site if needed, ensures build works, and verifies accessibility. Installs Vercel CLI if missing. See `.kilo/skills/vercel-deploy/SKILL.md`.
