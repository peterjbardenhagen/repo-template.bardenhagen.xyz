# Tool File Structure & Source of Truth

This document clarifies which AI tool configuration files are the source of truth and how they relate to each other.

## File Organization

### Claude Code (Primary)
**Location:** `./.claude/`

- **`.claude/agents/`** — Claude Code agent definitions (5 files)
  - `architect.md`, `coder.md`, `reviewer.md`, `tester.md`, `devops.md`
  - **Source of truth** for Claude Code's agent behavior
  - Used when invoking Claude Code from the CLI or web app
  - Loaded automatically at session start

- **`.claude/settings.json`** — Committed Claude Code configuration
  - Default permission allowlist (read-only operations, git status, etc.)
  - Used across all Claude Code sessions in this repo

- **`.claude/settings.local.json`** — User-specific overrides (`.gitignore`d)
  - Per-developer permission preferences
  - Never committed; `.gitignore` entry enforces this

### Rule Files (Shared Definitions)
**Location:** `./rules/`

- **`rules/01-architect.md` through `rules/05-devops.md`** — Full role skill files
  - **Source of truth** for detailed agent instructions
  - Mirrors `.claude/agents/` but with more context and examples
  - Updated when agent behavior needs to change
  - Read by `.claude/agents/*.md` via frontmatter reference

### Legacy/Alternative Tool Support
**Locations:** `./.hermes/`, `./.kilo/`, `./.opencode/`

- **Not the source of truth** for new projects
- These exist for historical multi-tool support (GitHub Copilot, alternative AI tools)
- If your project uses multiple AI tools, keep these in sync with `.claude/`
- New projects should focus on `.claude/` and `rules/`

### IDE/Editor Rules
**Files at repo root:**

- **`.cursorrules`** — Cursor AI integration
- **`.windsurfrules`** — Windsurf AI integration
- **`COPILOT_INSTRUCTIONS.md`** — GitHub Copilot instructions

**Source of truth:** Each tool maintains its own file for instructions specific to that tool's capabilities and constraints. Do not rely on cross-tool copying — each tool has unique features and limitations.

## Sync Strategy

When updating agent instructions:

1. **Always update `.claude/agents/` first** — this is the primary source for Claude Code
2. **Update `rules/` alongside** — the detailed version with examples and context
3. **Update IDE/editor rules only if the tool is actively used** in your team
4. **Do not update `.hermes/`, `.kilo/`, or `.opencode/`** unless explicitly supporting those tools

## Anti-Pattern

❌ Don't maintain multiple conflicting versions of the same instruction  
✅ Do maintain a single source (`.claude/` + `rules/`) and extend as needed for specific tools

## Pre-commit Hooks

A `.pre-commit-config.yaml` is included to detect merge conflict markers in all these files, preventing accidentally committed conflicts like `<<<<<<< HEAD`.

To use:

```bash
pip install pre-commit
pre-commit install
pre-commit run --all-files  # Test on existing files
```

Once installed, merge conflict markers will block commits automatically.
