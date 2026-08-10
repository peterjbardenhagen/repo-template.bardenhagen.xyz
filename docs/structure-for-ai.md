# Structured Content for AI Consumption

> **Audience:** AI agents (Claude Code, Codex, Cursor, Windsurf, Copilot) and humans building agentic workflows.

## Why Structured Content Matters

AI tooling is only as good as the context it has. When documentation, conventions, and architecture are fragmented or outdated, agents struggle to produce consistent, correct output. Structured content encodes intent into machine-readable formats that agents can reason about directly.

## The Three-Layer Model

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

## Schema Requirements

Every structured context file MUST include:

| Field | Type | Description |
|-------|------|-------------|
| `status` | enum | `draft \| approved \| deprecated` |
| `lastUpdated` | ISO 8601 | When the file was last modified |
| `owner` | string | Person or team responsible for accuracy |
| `supersedes` | string[] | Previous versions this replaces |

## Context File Catalog

| File | Purpose | Agent Usage |
|------|---------|-------------|
| `AGENTS.md` | Master agent instructions | Loaded by every agent at session start |
| `CLAUDE.md` | Claude Code adapter | Vendor-specific entry point |
| `.mcp.json` | MCP server config | Auto-loaded by Claude Code |
| `specs/mission.md` | Project constitution | Read before any design or implementation work |
| `specs/tech-stack.md` | Stack constraints | Referenced during component selection |
| `HANDOFF.md` | Live working state | Loaded at session start to resume context |

## Progressive Disclosure

Agents MUST NOT load every file into context. Instead:

1. **Session start**: Load `AGENTS.md` + `HANDOFF.md` only.
2. **Task start**: Load the relevant phase instructions (e.g., `docs/agentic-sdlc.md`).
3. **Deep work**: Load architecture, conventions, and tech stack only when implementing.
4. **Review**: Load PR contract and quality gates only when reviewing.

This keeps token usage proportional to task complexity.

## Atlassian-Style Semantic Tokens

Where applicable, use semantic tokens instead of literal values:

- **Colors**: `color.primary.brand`, `color.neutral.text`, `color.status.success`
- **Spacing**: `space.200`, `space.400`, `space.600`
- **Typography**: `font.size.body`, `font.weight.bold`, `font.family.mono`

Agents can map these tokens to framework-specific values (Tailwind, CSS modules, SwiftUI) without hardcoding.

## Validation

Structured content files are validated by:
- `actionlint` for YAML syntax
- `markdownlint` for Markdown structure
- Custom CI job that checks `status` and `lastUpdated` fields are present

## References

- [Atlassian Design System: Context Engine](https://www.atlassian.com/blog/ai-at-work/atlassian-design-system-building-the-context-engine-for-the-ai-era)
- [Spec-Driven Development with Coding Agents (DeepLearning.AI)](https://www.deeplearning.ai/short-courses/spec-driven-development-with-coding-agents/)
- [sdd-template by angelotadres](https://github.com/angelotadres/sdd-template)

---

## 2026 Enhancements

### Agent Consumption Patterns

Structured content files should be optimised for the following 2026 agent behaviours:

| Pattern | Description | Implementation |
|---------|-------------|----------------|
| **Context Lake** | Single source of truth for architecture, ownership, dependencies | Add `context-lake.md` with service map, data flow, and runbook index |
| **Rules Files** | Hierarchical, scoped instructions loaded at session start | Use `always_apply`, `agent_requested`, `manual` rule types |
| **Spec Contracts** | Verified interfaces between agent-generated code and the codebase | Enforce via PEV plan-alignment gates and CI schema checks |
| **Evidence Chains** | Acceptance is verifiable, not claimed | Screenshots, test reports, and benchmark outputs committed to PRs |
| **Provenance Gates** | Tamper-evident execution for regulated industries | Hash-chained work products and audit trails in `tests/reports/` |

### Machine-Readable Metadata Schema

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

### Validation Checklist

- [ ] `status` is one of `draft`, `approved`, `deprecated`
- [ ] `lastUpdated` is ISO 8601
- [ ] `owner` is assigned
- [ ] `tags` include at least one operational category
- [ ] `agentUsage` lists the roles that rely on this file
