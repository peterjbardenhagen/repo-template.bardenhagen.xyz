# Agent tooling

## Claude and agent tooling

What lives in `.claude/`, and which pieces are worth adding to a project
inheriting this template.

---

### What's in the box

```
.claude/
├── agents/          # Subagents — delegated roles with their own tool access
│   ├── architect.md   coder.md   reviewer.md   tester.md   devops.md
│   └── ux.md         analyst.md
├── skills/          # Packaged repeatable workflows
│   └── template-uplift/SKILL.md
└── settings.json    # Committed permission defaults
```

### The four mechanisms, and when each is right

Picking the wrong one is the usual mistake — most often a skill written where a
line in `AGENTS.md` would have done.

| Mechanism | Use when | Loaded |
|---|---|---|
| **`AGENTS.md` / `CLAUDE.md`** | A rule that applies to *everything* | Every session |
| **`rules/` + `.claude/agents/`** | A distinct role with its own judgement and checklist | When that role is invoked |
| **`.claude/skills/`** | A repeatable multi-step workflow with a clear trigger phrase | When its description matches |
| **Hooks** (`settings.json`) | Something that must happen deterministically, every time | On the matching event |

**Budget matters.** Everything in `AGENTS.md` is read on every session of every
project. Put the one-line rule there and the explanation in a doc. A skill costs
only its name and description (~100 tokens) until it fires — which is why a
sharp description matters more than the body.

#### Agents vs skills

- **Agent** = *who* — a role with a perspective. "Review this like a UX
  specialist would."
- **Skill** = *how* — a procedure. "Promote this improvement into the template."

If you find yourself writing "first do X, then Y, then Z", that is a skill. If
you are writing "care about these things, block on those", that is an agent.

### Writing a skill that actually fires

The description is the only part loaded at startup, so it is a **routing rule,
not a summary**. It must answer *when to fire*, name the trigger phrases people
actually say, and state what it produces.

```yaml
---
name: deploy-staging
description: "Deploy the current branch to staging. Use when the user says
  'deploy to staging', 'push this to staging', or 'can I see this on staging'.
  Produces a deployed URL and a smoke-test result. Do NOT use for production
  deploys — those require the release checklist."
---
```

Rules of thumb:

- Keep `SKILL.md` under ~500 lines; split into referenced files beyond that
- Say what it is **not** for — negative triggers prevent misfires
- Encode the *failure modes*, not just the happy path. The value is in "this
  looks right but breaks because…"
- Verify anything the skill tells an agent to run. A command shipped in a skill
  gets executed verbatim and trusted

### Worth adding to most projects

| Skill | Why |
|---|---|
| `template-uplift` | Shipped. Promotes improvements back upstream |
| `deploy` | Encodes the deploy sequence and its pre-flight checks |
| `release` | Version bump, changelog, tag, notes — easy to do inconsistently |
| `db-migration` | Migrations are high-risk and benefit from a fixed procedure |
| `incident` | What to check, in what order, when production is broken |
| `onboard` | Gets a fresh session productive without re-reading everything |

Add them **as the project accumulates the workflow**, not upfront. A skill for a
procedure nobody has performed twice is speculative.

### Hooks

Hooks run deterministically on events, so use them where "the agent should
remember to" is not good enough. Configured in `.claude/settings.json`.

Common ones:

- Format on write (`PostToolUse` on Edit/Write) — removes an entire class of
  lint failures
- Block edits to generated files (`PreToolUse`) — e.g. `src/generated/`
- Run the pin verifier after any workflow change

Keep them fast. A hook on every write that takes two seconds is felt constantly.

### Permissions

`.claude/settings.json` is committed, so the whole team and every agent session
inherit the same defaults. The shipped baseline allows read-only git and denies
the destructive operations:

```json
{
  "permissions": {
    "allow": ["Bash(git status)", "Bash(git diff*)", "Bash(git log*)"],
    "deny":  ["Bash(git push --force*)", "Bash(git reset --hard*)", "Bash(rm -rf*)"]
  }
}
```

Add project-specific safe commands (`Bash(npm run lint)`, `Bash(npm test)`) to
cut permission prompts. Never allowlist anything that writes to production or
rewrites shared history.

### MCP servers

MCP connects Claude to external systems — GitHub, databases, browsers,
observability. Configure per-project rather than globally so each project only
reaches what it needs.

Useful in this context: GitHub (issues, PRs, CI), Playwright (drive the real UI
for the UX checks in `rules/06-ux.md`), and a read-only database connection for
schema questions.

**Least privilege applies.** A read-only token for a server that only needs to
read. An MCP server with write access to production is a standing risk that
exists between sessions, not just during them.

### Anti-patterns

| Don't | Do |
|---|---|
| Put project detail in a skill's description | Description routes; body carries detail |
| Write a skill for a one-off | Put it in `AGENTS.md` or a `docs/` page |
| Duplicate `AGENTS.md` content into every agent | Agents reference, not restate |
| Add a skill per npm script | Skills are for judgement-bearing sequences |
| Let `AGENTS.md` grow unbounded | One-line rule + link to the doc |
| Ship an unverified command in a skill | Run it first — it will be trusted |

## Tool file structure

This document clarifies which AI tool configuration files are the source of truth and how they relate to each other.

### File Organization

#### Claude Code (Primary)
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

#### Rule Files (Shared Definitions)
**Location:** `./rules/`

- **`rules/01-architect.md` through `rules/05-devops.md`** — Full role skill files
  - **Source of truth** for detailed agent instructions
  - Mirrors `.claude/agents/` but with more context and examples
  - Updated when agent behavior needs to change
  - Read by `.claude/agents/*.md` via frontmatter reference

#### Legacy/Alternative Tool Support
**Locations:** `./.hermes/`, `./.kilo/`, `./.opencode/`

- **Not the source of truth** for new projects
- These exist for historical multi-tool support (GitHub Copilot, alternative AI tools)
- If your project uses multiple AI tools, keep these in sync with `.claude/`
- New projects should focus on `.claude/` and `rules/`

#### IDE/Editor Rules
**Files at repo root:**

- **`.cursorrules`** — Cursor AI integration
- **`.windsurfrules`** — Windsurf AI integration
- **`.github/copilot-instructions.md`** — GitHub Copilot instructions

**Source of truth:** Each tool maintains its own file for instructions specific to that tool's capabilities and constraints. Do not rely on cross-tool copying — each tool has unique features and limitations.

### Sync Strategy

When updating agent instructions:

1. **Always update `.claude/agents/` first** — this is the primary source for Claude Code
2. **Update `rules/` alongside** — the detailed version with examples and context
3. **Update IDE/editor rules only if the tool is actively used** in your team
4. **Do not update `.hermes/`, `.kilo/`, or `.opencode/`** unless explicitly supporting those tools

### Anti-Pattern

❌ Don't maintain multiple conflicting versions of the same instruction  
✅ Do maintain a single source (`.claude/` + `rules/`) and extend as needed for specific tools

### Pre-commit Hooks

A `.pre-commit-config.yaml` is included to detect merge conflict markers in all these files, preventing accidentally committed conflicts like `<<<<<<< HEAD`.

To use:

```bash
pip install pre-commit
pre-commit install
pre-commit run --all-files  # Test on existing files
```

Once installed, merge conflict markers will block commits automatically.

## Structuring a repository for AI

> **Audience:** AI agents (Claude Code, Codex, Cursor, Windsurf, Copilot) and humans building agentic workflows.

### Why Structured Content Matters

AI tooling is only as good as the context it has. When documentation, conventions, and architecture are fragmented or outdated, agents struggle to produce consistent, correct output. Structured content encodes intent into machine-readable formats that agents can reason about directly.

### The Three-Layer Model

```
┌─────────────────────────────────────┐
│  Layer 3: Agent Instructions        │  AGENTS.md, CLAUDE.md, rules/
│  (What to do and how)               │
├─────────────────────────────────────┤
│  Layer 2: Structured Context        │  architecture.md, TECH_STACK.md,
│  (Machine-readable schemas)         │  conventions.md, glossary.md
├─────────────────────────────────────┤
│  Layer 3: Human-readable Docs       │  README.md, getting-started.md,
│  (Narrative intent)                 │  runbooks, ADRs
└─────────────────────────────────────┘
```

### Schema Requirements

Every structured context file MUST include:

| Field | Type | Description |
|-------|------|-------------|
| `status` | enum | `draft \| approved \| deprecated` |
| `lastUpdated` | ISO 8601 | When the file was last modified |
| `owner` | string | Person or team responsible for accuracy |
| `supersedes` | string[] | Previous versions this replaces |

### Context File Catalog

| File | Purpose | Agent Usage |
|------|---------|-------------|
| `AGENTS.md` | Master agent instructions | Loaded by every agent at session start |
| `CLAUDE.md` | Claude Code adapter | Vendor-specific entry point |
| `.mcp.json` | MCP server config | Auto-loaded by Claude Code |
| `specs/mission.md` | Project constitution | Read before any design or implementation work |
| `specs/tech-stack.md` | Stack constraints | Referenced during component selection |
| `docs/status/handoff.md` | Live working state | Loaded at session start to resume context |

### Progressive Disclosure

Agents MUST NOT load every file into context. Instead:

1. **Session start**: Load `AGENTS.md` + `docs/status/handoff.md` only.
2. **Task start**: Load the relevant phase instructions (e.g., `docs/agentic/sdlc.md`).
3. **Deep work**: Load architecture, conventions, and tech stack only when implementing.
4. **Review**: Load PR contract and quality gates only when reviewing.

This keeps token usage proportional to task complexity.

### Atlassian-Style Semantic Tokens

Where applicable, use semantic tokens instead of literal values:

- **Colors**: `color.primary.brand`, `color.neutral.text`, `color.status.success`
- **Spacing**: `space.200`, `space.400`, `space.600`
- **Typography**: `font.size.body`, `font.weight.bold`, `font.family.mono`

Agents can map these tokens to framework-specific values (Tailwind, CSS modules, SwiftUI) without hardcoding.

### Validation

Structured content files are validated by:
- `actionlint` for YAML syntax
- `markdownlint` for Markdown structure
- Custom CI job that checks `status` and `lastUpdated` fields are present

### References

- [Atlassian Design System: Context Engine](https://www.atlassian.com/blog/ai-at-work/atlassian-design-system-building-the-context-engine-for-the-ai-era)
- [Spec-Driven Development with Coding Agents (DeepLearning.AI)](https://www.deeplearning.ai/short-courses/spec-driven-development-with-coding-agents/)
- [sdd-template by angelotadres](https://github.com/angelotadres/sdd-template)

---

### 2026 Enhancements

#### Agent Consumption Patterns

Structured content files should be optimised for the following 2026 agent behaviours:

| Pattern | Description | Implementation |
|---------|-------------|----------------|
| **Context Lake** | Single source of truth for architecture, ownership, dependencies | Add `context-lake.md` with service map, data flow, and runbook index |
| **Rules Files** | Hierarchical, scoped instructions loaded at session start | Use `always_apply`, `agent_requested`, `manual` rule types |
| **Spec Contracts** | Verified interfaces between agent-generated code and the codebase | Enforce via PEV plan-alignment gates and CI schema checks |
| **Evidence Chains** | Acceptance is verifiable, not claimed | Screenshots, test reports, and benchmark outputs committed to PRs |
| **Provenance Gates** | Tamper-evident execution for regulated industries | Hash-chained work products and audit trails in `tests/reports/` |

#### Machine-Readable Metadata Schema

Every top-level documentation file should include YAML frontmatter:

```yaml
---
status: approved
lastUpdated: 2026-08-10
owner: agent-architect
supersedes: []
tags: [agentic-sdlc, harness-engineering, multi-agent]
agentUsage: [architect, coder, reviewer, devops]
---
```

#### Validation Checklist

- [ ] `status` is one of `draft`, `approved`, `deprecated`
- [ ] `lastUpdated` is ISO 8601
- [ ] `owner` is assigned
- [ ] `tags` include at least one operational category
- [ ] `agentUsage` lists the roles that rely on this file
