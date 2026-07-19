# AGENTS.md — AI Agent Instructions

This file provides context and instructions for AI coding agents working in this repository. All AI tools (Claude Code, Codex, Cursor, Windsurf, GitHub Copilot, etc.) should read this file at session start.

## Project Orientation

This project is based on the **Perfect Repo Template** — a comprehensive starter template for agentic AI SDLC. Every project generated from this template inherits:

- **Agent instructions** — AI tools know how to operate (AGENTS.md, CLAUDE.md, etc.)
- **Role-based rules** — specialized instructions per agent role (rules/)
- **GitHub workflows** — CI/CD, security scanning, auto-assignment
- **Documentation** — architecture, ADRs, getting started guides
- **Config files** — editor settings, git attributes, environment templates

## AI Agent Operating Principles

1. **Read context files first** — Check AGENTS.md, CLAUDE.md, AI_CONTEXT.md, and .cursorrules at the start of every session.
2. **Follow the Agentic SDLC** — See `docs/agentic-sdlc.md` for the full autonomous development lifecycle protocol.
3. **State lives in files, not in model memory** — Write decisions, progress, and blockers to files. Do not assume the next session has context from this one.
4. **Commit frequently** — After every logical phase of work. Keep history clean and recoverable.
5. **Pull before working** — Always sync from origin before making changes.
6. **No fake completion** — Never mark work done that isn't actually complete.

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

- Use the default branch (`main` or `master`) for all work unless a feature branch is explicitly specified.
- Commit messages: `type(scope): description` (e.g., `feat(auth): add OAuth2 flow`).
- Run `git pull --ff-only` before starting work and before pushing.
- Keep `.env` in `.gitignore`; document required variables in `.env.example`.
- Architecture decisions go in `docs/decisions/` as ADR files.
- Update `CHANGELOG.md` with every significant change.

## Version

This template is versioned. See `CHANGELOG.md` for the current version and release history.
