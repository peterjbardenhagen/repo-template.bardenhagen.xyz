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

### Modern Agentic Enhancements (v2.3.0)

This release introduces several enhancements based on leading agentic AI and software platform research:

1. **Structured Content for AI** — See `docs/structure-for-ai.md` for machine-readable context schema. Agents reason about the codebase programmatically rather than scanning raw text.
2. **Spec-Driven Development** — See `docs/spec-driven-development.md` for lightweight SDD methodology. Write specs before code; keep them in the repo; organize them as a constitution plus per-phase spec trio.
3. **Dual-Model Review** — Generate with one model (e.g., Claude Code), review with another (e.g., Codex CLI). Separation of duties catches errors that single-model review misses.
4. **Evidence-Chain Acceptance** — Browser QA with Playwright MCP produces screenshots and reports. Evidence is committed to the PR or `tests/reports/` so acceptance is verifiable, not claimed.
5. **Worktree Parallelism** — Use `scripts/worktree-create.sh` to isolate parallel pipelines. Each worktree gets its own branch, port range, and `.claude/.sdlc-config`.
6. **Live Working State** — `HANDOFF.md` is the single source of truth for what is in flight, what to pick up next, and what is ignored by default.
7. **MCP Servers** — `.mcp.json` pre-wires Context7 (live library docs), GitHub (issues/PRs), and Playwright (browser QA) so agents have live tool access without manual setup.
8. **Supply Chain Hardening** — OpenSSF Scorecard, Gitleaks, actionlint, SBOM, and SLSA provenance workflows provide defense-in-depth against supply chain attacks.

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

| Type | Description | Path |
|-----------|---------|---------|
| ADR | Architecture decisions | `docs/decisions/` |
| Spec | Feature specification | `docs/specs/` |
| Progress | Autonomous loop progress | `PROGRESS.md` |
| Blockers | Items needing human input | `blockers.md` |
| PR | Code change description | GitHub PR |
| Test plan | Test strategy | `tests/` or `docs/test-plans/` |
| CI workflow | Build/test/deploy | `.github/workflows/` |
| CHANGELOG.md | Release history | Root |

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
  └── release/vX.Y.Z ── QA ──▶ tag vX.Y.Z ──▶ deploy
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

## Multi-Agent Orchestration

When using an orchestration platform or kanban board:

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

## Unattended Autonomous Loop

When a human delegates "complete the planned work" with no further check-ins, use this protocol instead of the interactive solo-agent cycle above. It exists so an agent can run for hours without a human in the loop and still be safe and recoverable.

### Operating principles

- **State lives in files, not model memory.** Checkpoint progress to `PROGRESS.md` and blockers to `blockers.md` at the repo root. A new session (or a crashed/restarted one) must be able to resume purely from these files.
- **Non-blocking first.** When a task can't proceed (missing credential, ambiguous requirement, failing external dependency), write it to `blockers.md` with enough detail for a human to act on later, then move to the next non-blocked task. Never idle waiting on a blocker.
- **Pull before every iteration.** `git pull --ff-only origin main`. If this fails (diverged history), stop and write to `blockers.md` — do not force-push or reset.
- **Commit at least every phase.** Small, frequent, conventional commits. A crash mid-loop should lose at most one phase of work.
- **Auto-merge to keep `main` moving**, gated on CI passing. Do not merge on a red pipeline.
- **Fix forward.** There is no recovery from a force-push once it lands (the `repo-safety-no-destructive-actions.json` ruleset — see `.github/rulesets/README.md` — blocks force-push and branch deletion on `main`/`master` at the platform level). If something is broken, commit a fix; never rewrite history to hide it.

### Loop contract

Each iteration:

1. `git pull --ff-only origin main`
2. Read `PROGRESS.md` — resume from the last checkpoint
3. Pick the next non-blocked task
4. Execute it (plan → code → test → lint)
5. Commit with a conventional commit message
6. Update `PROGRESS.md` (what changed, what's next) and, if applicable, `blockers.md`
7. Push; if CI passes and the change is safe to land, merge to `main`

### Stop conditions

Stop the loop on any of:

- A `DONE` marker written to `PROGRESS.md`
- A `STOP` sentinel file present at the repo root
- A configured time budget elapsed
- Manual kill by a human

### Launcher

A simple wrapper script drives the loop with exponential backoff on consecutive failures (interval doubles up to a cap, resets on success), so a flaky iteration doesn't hot-loop or burn the whole time budget on retries.

PowerShell (`scripts/start-loop.ps1`):

```powershell
param(
    [int]$MaxIntervalSeconds = 3600,
    [int]$InitialIntervalSeconds = 30
)

$interval = $InitialIntervalSeconds
while (-not (Test-Path "STOP")) {
    if (Select-String -Path "PROGRESS.md" -Pattern "^DONE$" -Quiet -ErrorAction SilentlyContinue) {
        Write-Host "DONE marker found — stopping."
        break
    }

    claude -p "Continue the agentic SDLC loop: read PROGRESS.md, do the next task, checkpoint, commit." --dangerously-skip-permissions
    if ($LASTEXITCODE -eq 0) {
        $interval = $InitialIntervalSeconds
    } else {
        $interval = [Math]::Min($interval * 2, $MaxIntervalSeconds)
        Write-Host "Iteration failed — backing off to ${interval}s"
    }

    Start-Sleep -Seconds $interval
}
```

bash mirror (`scripts/start-loop.sh`):

```bash
#!/usr/bin/env bash
set -euo pipefail

max_interval=3600
interval=30

while [ ! -f STOP ]; do
    if grep -q '^DONE$' PROGRESS.md 2>/dev/null; then
        echo "DONE marker found — stopping."
        break
    fi

    if claude -p "Continue the agentic SDLC loop: read PROGRESS.md, do the next task, checkpoint, commit." --dangerously-skip-permissions; then
        interval=30
    else
        interval=$(( interval * 2 < max_interval ? interval * 2 : max_interval ))
        echo "Iteration failed — backing off to ${interval}s"
    fi

    sleep "$interval"
done
```

Only use `--dangerously-skip-permissions` in a sandboxed/disposable environment — the whole point of the guardrails above (ruleset, ff-only pulls, fix-forward) is to make that safe.

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

---

## Harness Engineering & 2026 Production Patterns

This section captures production-grade patterns from Anthropic, Deloitte, Alice Labs, and Augment Code research (2026).

### Constraint Harnesses

Harness engineering encodes correctness into the agent loop through three reinforcing layers:

1. **Preventive Controls (Constraint Harnesses)** — Reduce the agent's solution space before generation begins.
   - Rules files injected at session start (`always_apply`, `agent_requested`, `manual`)
   - Architectural lint configurations with remediation-instruction error messages
   - Type systems and schemas that make invalid states unrepresentable

2. **Corrective Controls (Feedback Loops)** — Return structured error signals to the agent for self-correction.
   - Lint/type-checker output fed back into agent reasoning as actionable prompts
   - Test failure details (which test, what assertion, what line) for precise retries
   - Plan-alignment checks: did the agent use the existing middleware or create a new one?

3. **Quality Gates** — Prevent non-compliant code from merging.
   - Deterministic CI gates (SAST, SCA, secrets, IaC, type-check, lint)
   - Staleness gates for dependency strategy drift
   - LLM-as-judge pre-screening for specification compliance and scope creep

### Plan-Execute-Verify (PEV) Pattern

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   PLAN      │───▶│  EXECUTE    │───▶│   VERIFY    │
│             │    │             │    │             │
│ Decompose   │    │ Implement   │    │ Test suite  │
│ acceptance  │    │ against     │    │ Type check  │
│ criteria    │    │ plan        │    │ Lint        │
│ Open qs     │    │ Iterate     │    │ Plan align  │
└─────────────┘    └─────────────┘    └─────────────┘
       ▲                   │                   │
       └───────────────────┴───────────────────┘
              Feedback loop on any failure
```

PEV enforces phase boundaries with gates at every transition. Unlike generate-and-check, planning is explicit and verified before code is written.

### Multi-Agent Coordination Taxonomy (2026)

| Tier | Pattern | Best For | Tools |
|------|---------|----------|-------|
| **Tier 1: Local Multi-Agent** | Multiple agents in isolated worktrees with dashboards, diff review, merge control | 3-10 agents on known codebases | Claude Code Agent Teams, Conductor, Antigravity |
| **Tier 2: Managed Orchestration** | Platform manages agent lifecycle, context, and coordination | Teams needing governance without cloud lock-in | Vibe Kanban, OpenClaw + Antfarm, Gastown |
| **Tier 3: Cloud Autonomous** | Fully cloud-hosted agents with API-level integration | End-to-end workflows with sandboxed execution | Claude Code Web, Copilot Coding Agent, Jules, Codex Web |

**Key coordination patterns:**
- Spec-driven decomposition
- Worktree isolation for parallel execution
- Coordinator/Specialist/Verifier roles
- Per-task model routing (Opus for reasoning, Sonnet for routine, Haiku for simple)
- Automated quality gates
- Sequential merge with human approval on production touches

### Context Engineering

Context engineering is the discipline of systematically managing how AI systems process context.

**Rules files** are persistent, repository-scoped instruction sets injected at session start:
- `always_apply` — included in every prompt automatically
- `agent_requested` — loaded when the agent determines relevance
- `manual` — loaded only when explicitly invoked

**Context lakes** provide one source of truth every agent reads from: service ownership, dependencies, runbooks, and architecture decisions.

**Progressive disclosure** keeps token usage proportional to task complexity:
1. Session start: `AGENTS.md` + `HANDOFF.md`
2. Task start: phase-specific instructions
3. Deep work: architecture, conventions, tech stack
4. Review: PR contract and quality gates only

### Cost Optimization & Model Routing

Token economics vary dramatically across task types and models. Sustainable operation requires:
- Intelligent model routing (Opus/Sonnet/Haiku) based on task complexity
- Multi-runtime strategy (local integration vs. cost-efficient sandboxed execution)
- Usage-based metering and budget caps
- Caching strategies for repeated context

### Verification Gates

Tests are the ground truth. The test suite is what lets the agent close its own loop. Three properties make a test suite agent-ready:
1. **Speed** — affected tests first, parallelize, cache; common case in seconds
2. **Trustworthiness** — flaky tests poison the signal; fix before delegating to agents
3. **Coverage** — gaps in tests are gaps in the agent's verification

**Verification gate checklist:**
- [ ] Affected tests pass
- [ ] Full suite passes (no regressions)
- [ ] Type checker clean
- [ ] Linter clean
- [ ] Plan alignment verified (architecture, conventions)
- [ ] Human approval for production-touching changes
