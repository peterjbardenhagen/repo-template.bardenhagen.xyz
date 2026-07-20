# Repo Template — AI Agentic SDLC Starter

**Version:** 2.0.0

> A comprehensive, opinionated starter template for modern software projects that covers **naming conventions**, **git workflows**, and the full **Agentic AI SDLC lifecycle**. Every file, rule, and workflow is designed to make AI coding tools (Claude Code, Codex, Cursor, Windsurf, GitHub Copilot) maximally effective from the first keystroke.

---

## Table of Contents

1. [Conventions & Naming Standards](#1-conventions--naming-standards)
2. [Git Workflows & Branching](#2-git-workflows--branching)
3. [Agentic AI SDLC](#3-agentic-ai-sdlc)
4. [Project Structure](#4-project-structure)
5. [Quick Start](#5-quick-start)

---

## 1. Conventions & Naming Standards

### The Golden Rule

**Context-dependent consistency.** Different ecosystems have different conventions. The key is using the right one for the right thing, and being **consistent within a project**.

### File & Folder Naming

| Context | Convention | Examples |
|---------|-----------|---------|
| **GitHub repos** | `kebab-case` | `app.mydesk.digitalresponse.com.au` |
| **Web folders** | `kebab-case` | `src/components/`, `src/lib/hooks/` |
| **React/Vue/Next.js components** | `PascalCase` | `UserProfile.tsx`, `SidebarNav.vue` |
| **Blazor/.NET pages** | `PascalCase` | `Login.razor`, `Dashboard.razor` |
| **JavaScript/TypeScript utilities** | `camelCase` | `formatDate.ts`, `useAuth.ts` |
| **Python modules (PEP 8)** | `snake_case` | `data_loader.py`, `model_trainer.py` |
| **CSS/SCSS modules** | `kebab-case` | `button.module.css`, `card-layout.scss` |
| **Config files** | `kebab-case` | `tailwind.config.js`, `docker-compose.yml` |
| **Markdown docs** | `kebab-case` | `contributing.md`, `api-reference.md` |
| **Docker/DevOps** | `kebab-case` | `Dockerfile`, `.dockerignore` |
| **CI/CD workflows** | `kebab-case` or `snake_case` | `.github/workflows/deploy-prod.yml` |
| **Environment variables** | `UPPER_SNAKE_CASE` | `DATABASE_URL`, `VERCEL_TOKEN` |

### Why Kebab-Case Won for Repos & Folders

- **URL-friendly** — `my-project` vs `my_project` (hyphens are unambiguous in URLs)
- **No case-sensitivity issues** — macOS is case-insensitive, Linux is case-sensitive. `MyFile.ts` and `myfile.ts` can coexist on Linux but collide on macOS. Kebab-case avoids this entirely.
- **Shell-friendly** — tab-completion doesn't require shift keys
- **GitHub sorts repos** with hyphens naturally

### GitHub Repo Naming Best Practices

```
format:   <project-name>[-<sub-component>]
case:     kebab-case (lowercase, hyphens)
length:   2-5 meaningful words, ideally ≤30 chars
```

| Good | Why |
|------|-----|
| `app.mydesk.digitalresponse.com.au` | Matches the actual domain — perfect for Vercel |
| `ai-test-orchestrator` | Short, clear, hyphenated |
| `agents-os` | Clear project identity |
| `tailscale-gateway-exporter` | Self-documenting |
| `dotnet-blazor-components` | Ecosystem + tech + purpose |

| Avoid | Why |
|-------|-----|
| `MyProject` | Case ambiguity, not URL-friendly |
| `project_alpha` | Underscore is less URL-friendly than hyphens |
| `my-app-v3-final` | Version numbers and "final" date quickly |
| `test123` | Not descriptive |

### Repository Organization for Multi-Product Projects

**Option A — Separate repos** (best when tech stacks differ):
```
github.com/org/app.mydesk.digitalresponse.com.au  # Next.js web app → Vercel
github.com/org/mydesk-browser                      # WPF desktop shell
github.com/org/mydesk-shared                       # Shared libraries (NuGet/npm)
github.com/org/agents-os                           # Agent orchestration service
```

**Option B — Monorepo** (best when everything shares one deploy pipeline):
```
monorepo/
├── apps/
│   ├── web/       # → Vercel project: app.mydesk...
│   └── marketing/ # → Vercel project: mydesk.digital...
├── packages/
│   └── shared/
├── services/
│   └── agents-os/
└── docs/
```

---

## 2. Git Workflows & Branching

### Trunk-Based Development (Recommended)

```
main (always deployable / green)
 │
 ├── feat/tenant-sso       # Feature branches (short-lived, <1 week)
 ├── fix/login-error       # Bug fix branches
 ├── chore/update-deps     # Maintenance branches
 └── release/v2.1.0        # Release branches (manual deploy targets)
```

### Branch Naming Convention

```
type/description-in-kebab-case
```

| Prefix | Purpose |
|--------|---------|
| `feat/` | New features |
| `fix/` | Bug fixes |
| `chore/` | Maintenance, tooling, config |
| `docs/` | Documentation |
| `refactor/` | Code restructuring |
| `test/` | Test additions |
| `experiment/` | Throwaway experiments (AI/ML) |
| `model/` | Model iterations (AI/ML) |
| `release/` | Release preparation |

### Workflow: Vercel-Hosted Apps

Vercel auto-deploys `main` to production, so **main must always be deployable**:

```
main ──feat/tenant-sso──PR──▶ main ──▶ Vercel prod auto-deploy
                                ↑
                        (squash merge, CI must pass)
```

1. Branch from `main`: `git checkout -b feat/tenant-sso`
2. Work, commit, push — Vercel creates preview deployment
3. Open PR — review on the preview URL
4. Merge to `main` — Vercel auto-deploys to production
5. Delete feature branch

### Workflow: Non-Vercel / Manual Deploy Apps

Same trunk-based flow, but deployments from release branches or tags:

```
main ──feat/a──feat/b──feat/c───────────────────────────────▶ (integration)
                              \                            /
release/v2.1.0 ───────────────▶ QA ──fix/hotfix──▶ v2.1.0 tag ──▶ deploy
```

1. Feature work on `feat/*` branches → merge to `main`
2. When ready: `git checkout -b release/v2.1.0` from `main`
3. QA + bugfix on release branch
4. Tag: `git tag v2.1.0 && git push --tags`
5. Deploy from tag
6. Merge hotfixes back to `main`

### Commit Messages (Conventional Commits)

```
type(scope): description

feat(tenant): add SSO with Entra ID
fix(auth): handle token refresh race condition
chore(deps): bump MudBlazor to 8.1
docs(api): update webhook endpoints
refactor(dashboard): extract chart components
```

This integrates with **semantic release** (auto version bumps), **GitHub changelog** (auto release notes), and makes `git log --oneline` scannable.

### Pull Before Pushing

```bash
git pull --ff-only origin main   # Fast-forward only — aborts if divergence
# If it fails:
git fetch origin
git rebase origin/main            # Rebase, never merge-pull on feature branches
```

### Protected Branch Rules

On `main` (recommended GitHub settings):
- ✅ Require PR before merging
- ✅ Require status checks (CI must pass)
- ✅ Require linear history (no merge commits in PRs — squash or rebase)
- ✅ Dismiss stale reviews when new commits are pushed

---

## 3. Agentic AI SDLC

### The Autonomous Development Lifecycle

This template codifies a **multi-agent, file-driven SDLC** where AI agents operate autonomously through defined roles, artifacts, and handoffs.

```
┌─────────────────────────────────────────────────────────────────────┐
│                    AGENTIC AI SDLC LIFECYCLE                        │
│                                                                     │
│  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌──────────┐  ┌─────────┐ │
│  │ README  │  │ Git Pull│  │  Agent  │  │  Run     │  │ Commit  │ │
│  │ Context │─▶│ --ff-   │─▶│ Works   │─▶│ Tests &  │─▶│ & Push  │ │
│  │ Files   │  │ only    │  │ on Task │  │ Verify   │  │         │ │
│  └─────────┘  └─────────┘  └─────────┘  └──────────┘  └─────────┘ │
│       ▲                                                         │   │
│       └──────────────────── Loop (continue) ────────────────────┘   │
│                                                                     │
│  ┌──────────┐  ┌──────────┐  ┌───────────┐  ┌────────┐  ┌───────┐ │
│  │ ADR /    │  │ PR       │  │ Peer      │  │ Merge  │  │ Tag   │ │
│  │ Decision │─▶│ Created  │─▶│ Review by │─▶│ to     │─▶│ &     ││
│  │ Written  │  │          │  │ Agent     │  │ main   │  │Release│ │
│  └──────────┘  └──────────┘  └───────────┘  └────────┘  └───────┘ │
└─────────────────────────────────────────────────────────────────────┘
```

### Role-Based Agent Architecture

Each agent role has **specialised knowledge** in `rules/` — loaded contextually depending on the task:

| Role | Rule File | Responsibility |
|------|-----------|---------------|
| 🏗️ **Architect** | `rules/01-architect.md` | System design, ADRs, tech decisions |
| 💻 **Coder** | `rules/02-coder.md` | Feature implementation, refactoring |
| 👁️ **Reviewer** | `rules/03-reviewer.md` | Code review, quality gates |
| 🧪 **Tester** | `rules/04-tester.md` | Test strategy, test automation |
| 🚀 **DevOps** | `rules/05-devops.md` | CI/CD, infrastructure, deployment |

### Agent Configuration Files

Every AI tool gets context tailored to it:

| File | Tool / Purpose |
|------|---------------|
| `AGENTS.md` | **Master instructions** — read by ALL AI agents at session start |
| `CLAUDE.md` | Claude Code / CLI — defines project commands & code style |
| `CODEX.md` | OpenCode / Codex CLI — structured instructions |
| `COPILOT_INSTRUCTIONS.md` | GitHub Copilot — inline completion context |
| `AI_CONTEXT.md` | **One-page project summary** — for fast AI orientation |
| `.cursorrules` | Cursor AI — indexing & generation rules |
| `.windsurfrules` | Windsurf — indexing & generation rules |

### Agentic Workflow for AI Agents

When an AI agent starts a session, it should follow this protocol:

```
1. READ CONTEXT
   └─ Read AGENTS.md → CLAUDE.md → AI_CONTEXT.md → .cursorrules
   └─ Identify role from rules/ (architect/coder/reviewer/tester/devops)

2. ORIENT
   └─ `git pull --ff-only origin main`
   └─ Check open issues, PRs, or the stated task
   └─ Read relevant docs/ and docs/decisions/ for prior context

3. PLAN
   └─ State the approach before coding
   └─ If architect: write or update ADR
   └─ If coder: break work into small commits

4. EXECUTE
   └─ One logical change at a time
   └─ Run linters and tests after each change
   └─ Commit with conventional commits

5. VERIFY
   └─ Run full test suite
   └─ Run build/compilation
   └─ Update CHANGELOG.md

6. DELIVER
   └─ Push branch
   └─ Create PR (if reviewer agent will review)
   └─ Or merge directly (if solo agent with passing CI)
```

### Agent-to-Agent Handoffs

This template supports **multi-agent orchestration** — one agent spawns subtasks for others:

```
Architect Agent
   └─ Creates ADR, defines architecture
   └─ Hands off to Coder Agent with spec
   
Coder Agent
   └─ Implements feature in small commits
   └─ Hands off to Reviewer Agent with PR

Reviewer Agent
   └─ Reviews code against quality gates
   └─ Approves or requests changes → loops back to Coder

Tester Agent
   └─ Adds / updates tests
   └─ Verifies all tests pass

DevOps Agent
   └─ Deploys to staging / production
   └─ Monitors for regressions
```

Handoffs are **file-based** — agents write decisions to files (ADRs, specs, test plans), never relying on conversation memory.

### Agentic AI / ML Workflow

For AI/ML projects, the lifecycle extends with experiment tracking:

```
main
├── experiment/hyperparam-tuning   # Temp experiments
├── model/v2-classifier             # Model iterations
├── data/processed-v3               # Data pipeline changes
└── notebooks/                      # Research (use jupytext)

Key rules:
├── DON'T commit model weights → use DVC or Hugging Face Hub
├── DON'T commit raw data → use DVC with cloud storage
├── DO commit experiment configs → YAML in configs/experiments/
├── DO tag training runs → git tag experiment/20260721-lr0.001
└── DO track in external system → W&B / MLflow / Neptune
```

### For Multi-Agent Orchestration Platforms (AgentsOS)

This template integrates with **AgentsOS** or similar orchestration systems:

- **Kanban board** agents discover work from a shared board
- **Agent profiles** map to `rules/` — each profile loads its role's rule file
- **Handoffs** go through the kanban board's parent/child dependency system
- **Artifacts** are attached to tasks — code changes, ADRs, test results
- **Blockers** are raised when agents need human input

---

## 4. Project Structure

```
.
├── AGENTS.md                    # Master instructions for all AI agents
├── CLAUDE.md                    # Claude Code / CLI configuration
├── CODEX.md                     # OpenCode / Codex instructions
├── COPILOT_INSTRUCTIONS.md      # GitHub Copilot context
├── AI_CONTEXT.md                # One-page project summary
├── .cursorrules                 # Cursor AI rules
├── .windsurfrules               # Windsurf AI rules
│
├── rules/                       # Role-based agent skill files
│   ├── 01-architect.md          # Architecture agent
│   ├── 02-coder.md              # Implementation agent
│   ├── 03-reviewer.md           # Code review agent
│   ├── 04-tester.md             # Testing agent
│   └── 05-devops.md             # DevOps / infrastructure agent
│
├── .github/
│   ├── workflows/               # CI/CD pipelines
│   │   ├── ci.yml               # Main CI workflow
│   │   └── codeql-analysis.yml  # Security scanning
│   ├── ISSUE_TEMPLATE/          # Issue templates
│   ├── PULL_REQUEST_TEMPLATE.md # PR template
│   ├── dependabot.yml           # Dependency automation
│   └── CODEOWNERS               # Ownership & review routing
│
├── docs/
│   ├── agentic-sdlc.md          # Full Agentic SDLC protocol
│   ├── architecture.md          # Architecture documentation
│   ├── decisions/               # ADRs (Architecture Decision Records)
│   └── getting-started.md       # Quick start guide
│
├── scripts/
│   ├── init-project.sh          # Initialize from this template
│   └── propagate-template.sh    # Update downstream projects
│
├── seeds/                       # Project type starter kits
│   ├── dotnet/
│   ├── nextjs/
│   └── python/
│
├── .editorconfig                # Cross-editor consistency
├── .gitattributes               # Git normalization
├── .gitignore                   # Comprehensive ignore patterns
├── .env.example                 # Documented environment variables
├── .prettierrc                  # Code formatting (if JS/TS)
├── docker-compose.yml           # Development environment
├── Dockerfile                   # Container definition
├── CHANGELOG.md                 # Version history
├── LICENSE                      # MIT license
└── README.md                    # This file
```

---

## 5. Quick Start

```bash
# Use this template from GitHub
# Option 1: "Use this template" button on GitHub UI
# Option 2: Clone and reset
git clone https://github.com/peterjbardenhagen/repo-template.bardenhagen.xyz.git my-new-project
cd my-new-project
rm -rf .git && git init && git add -A && git commit -m "chore: initialise from repo-template"

# Option 3: Use the init script
bash scripts/init-project.sh my-new-project
```

### Template Maintenance

This template is kept in sync across all your projects via the propagation script. See `scripts/propagate-template.sh` for the workflow.

```bash
# After updating this template, propagate to downstream repos:
bash scripts/propagate-template.sh /path/to/downstream-repo
```

---

## Version History

See `CHANGELOG.md` for the full version history.

## License

MIT — see `LICENSE`.
