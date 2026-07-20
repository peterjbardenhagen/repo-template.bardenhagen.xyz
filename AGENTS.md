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
├── .github/workflows/     # CI/CD pipelines
├── docs/                  # Documentation
│   ├── agentic-sdlc.md    # Agentic SDLC protocol
│   ├── architecture.md    # Architecture documentation
│   └── decisions/         # Architecture Decision Records
├── scripts/               # Automation scripts
├── seeds/                 # Template seeds for project types
└── templates/             # Config file templates
```

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

## Version

This template is versioned. See `CHANGELOG.md` for the current version and release history.
