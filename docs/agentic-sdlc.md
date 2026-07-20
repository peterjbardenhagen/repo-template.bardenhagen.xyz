# Agentic AI SDLC Protocol

## Overview

The **Agentic AI SDLC** is a multi-agent, file-driven software development lifecycle designed for AI coding agents. It replaces traditional human-centric processes (standups, sprint planning, manual code review) with role-based agent orchestration while keeping humans in the loop for strategic decisions.

## Core Principles

1. **State lives in files, not in model memory** — Every decision, ADR, spec, and progress update is written to a file. AI agents never assume the next session remembers what they did.
2. **Roles are specialised** — Each agent role has its own rule file (`rules/`) with domain-specific knowledge. An architect doesn't need testing rules and a tester doesn't need architecture rules.
3. **Handoffs are explicit** — Agents hand work to each other via files and kanban board transitions, not conversation context.
4. **Pull before push** — Always sync from origin before making changes. Divergence is the enemy of autonomous work.
5. **Humans review strategy, agents execute tactics** — Strategic decisions (architecture, API design, pricing) go to humans. Implementation, testing, and deployment are agent-owned.

## The Agentic Workflow

### Solo Agent Cycle

A single AI agent follows this loop for autonomous feature development:

```
┌──────────────┐    ┌──────────────┐    ┌──────────────┐    ┌──────────────┐    ┌──────────────┐
│  1. READ     │    │  2. ORIENT   │    │  3. PLAN     │    │  4. EXECUTE  │    │  5. VERIFY   │
│  CONTEXT     │───▶│              │───▶│              │───▶│              │───▶│              │
│              │    │              │    │              │    │              │    │              │
│ AGENTS.md    │    │ git pull     │    │ State        │    │ Code one     │    │ Run tests    │
│ CLAUDE.md    │    │ Check issues │    │ approach     │    │ change at a  │    │ Run linter   │
│ AI_CONTEXT.md│    │ Check PRs    │    │ Write ADR?   │    │ time         │    │ Build check  │
│ .cursorrules │    │ Read docs/   │    │              │    │ Commit with  │    │              │
└──────────────┘    └──────────────┘    └──────────────┘    │ conventional │    │ Update       │
       ▲                                                    │ commit       │    │ CHANGELOG.md │
       └────────────────────────────────────────────────────┴──────────────┘    └──────┬───────┘
                                                                                       │
                                                                             ┌─────────▼─────────┐
                                                                             │  6. DELIVER       │
                                                                             │                   │
                                                                             │ Push → PR → Merge │
                                                                             └───────────────────┘
```

### Multi-Agent Handoff Pipeline

For complex work, specialised agents hand off through a pipeline:

```
Phase 1         Phase 2          Phase 3          Phase 4           Phase 5
────────        ────────         ────────         ────────          ────────
ARCHITECT ──▶   CODER ──────▶    REVIEWER ───▶    TESTER ─────▶    DEVOPS
  Create        Implement         Review           Add/verify        Deploy
  ADR           feature           code             tests             to prod
  Design        in small          against          All tests         Monitor
  API/DTOs      commits           quality gates    must pass         Rollback?
```

Each handoff produces an artifact (ADR, code, PR, test report) that the next agent reads from the filesystem, not from memory.

### Agent-to-Agent Communication Protocol

```
┌───────────────────┐              ┌──────────────────────┐
│  Source Agent     │              │  Target Agent        │
│                   │              │                      │
│  Writes:          │              │  Reads:              │
│  - ADR file       │──────────────▶  - ADR files         │
│  - Spec document  │  file-based   │  - Spec docs         │
│  - PR with desc   │  handoff      │  - Commit messages   │
│  - Kanban task    │              │  - Kanban task body   │
│  - Comment thread │              │  - Comment thread     │
└───────────────────┘              └──────────────────────┘
                               NO conversation memory
                               NO what-I-told-you-last-time
                               EVERYTHING in files
```

## File Types & Their Purpose

| File Type | Purpose | Written By | Read By |
|-----------|---------|-----------|---------|
| ADR (`docs/decisions/`) | Architecture decisions | Architect | All agents, humans |
| Spec (`docs/specs/`) | Feature specification | Architect | Coder |
| PR | Code change description | Coder | Reviewer |
| Test plan | Test strategy | Tester | All agents |
| CI workflow | Build/test/deploy | DevOps | Everyone |
| CHANGELOG.md | Release history | All agents | Humans, downstream |

## Vercel vs Non-Vercel Deploy Strategy

### Vercel-Hosted Apps

```
main ──────────────▶ Vercel auto-deploy to production
  │
  ├── feat/feature1 ── PR ──▶ main (squash merge)
  └── feat/feature2 ── PR ──▶ main
```

- `main` is **always deployable** — Vercel auto-deploys it
- Every PR gets a **preview deployment** — review before merging
- Hotfix: commit directly to `main` (if branch protection allows) or fast PR

### Non-Vercel / Manual Deploy Apps

```
main ────────────────────────────────────────── (integration branch)
  │                                             │
  └── release/v2.1.0 ── QA ──▶ tag v2.1.0 ──▶ deploy
```

- `main` is always green (tests pass) but not automatically deployed
- Release branches (`release/v*`) cut from `main` for QA
- Tags are the actual deployment artifacts
- Hotfixes go on release branch then cherry-pick to `main`

## AI / ML Project Extensions

For AI/ML projects, extend the lifecycle with:

```
main
├── experiment/hyperparam-tuning    # Temp experiments
├── model/v2-classifier              # Model iterations
├── data/processed-v3                # Data pipeline changes
└── notebooks/                       # Research notebooks
```

### ML-Specific Rules

- **Don't commit model weights** — use DVC or Hugging Face Hub
- **Don't commit raw data** — use DVC with S3/Cloudflare R2
- **Do commit experiment configs** — YAML in `configs/experiments/`
- **Do tag training runs** — `git tag experiment/20260721-lr0.001`
- **Do track in external system** — W&B / MLflow / Neptune
- **Notebooks** — use `jupytext` to export `.py` alongside `.ipynb`

## Multi-Agent Orchestration (AgentsOS / Kanban)

When using an orchestration platform like AgentsOS:

1. **Orchestrator decomposes** — A planner agent breaks the goal into kanban tasks
2. **Specialist agents execute** — Each task picks up its role-appropriate rule file
3. **Dependencies manage flow** — Tasks auto-promote when parent tasks complete
4. **Blockers escalate** — Agents raise blockers for human decisions
5. **Artifacts attach** — Output files (ADRs, PRs, test reports) attach to completed tasks

### Kanban State Flow

```
triage ──▶ todo ──▶ ready ──▶ running ──▶ done
                                    │
                                    └──▶ blocked ──▶ ready (when unblocked)
```

Orchestrators only decompose and route. They don't implement. Specialists implement. This prevents scope creep and keeps each agent focused on its role.

## Error Recovery

When an agent encounters a failure:

| Error | Recovery |
|-------|----------|
| Merge conflict | Auto-resolve (accept theirs), commit, notify |
| Build failure | Fix, commit, retry (max 3 attempts) |
| Test failure | Fix or roll back, commit, retry |
| API rate limit | Backoff and retry with exponential delay |
| Ambiguous requirement | Write question to file, block on kanban board |
| Tool/access failure | Report as capability block, escalate to human |

## Template Propagation

This template updates downstream projects:

```bash
# From the template repo:
bash scripts/propagate-template.sh /path/to/downstream-repo

# The script copies:
# - rules/ (new rules added)
# - Agent config files (AGENTS.md, CLAUDE.md, etc.)
# - CI/CD workflow improvements
# - docs/ structure updates
```

Downstream repos should be rebased onto the template periodically to receive updates without losing their project-specific content.
