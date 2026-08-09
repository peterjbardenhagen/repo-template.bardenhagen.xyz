# Repo Template — AI Agentic SDLC

**Version:** 2.4.0

> A comprehensive, opinionated starter template for modern software projects that covers **naming conventions**, **git workflows**, and the full **Agentic AI SDLC lifecycle**. Every file, rule, and workflow is designed to make AI coding tools (Claude Code, Codex, Cursor, Windsurf, GitHub Copilot) maximally effective from the first keystroke.

---

## Table of Contents

1. [Conventions & Naming Standards](#1-conventions--naming-standards)
2. [Git Workflows & Branching](#2-git-workflows--branching)
3. [Agentic AI SDLC](#3-agentic-ai-sdlc)
4. [GitHub Actions & Automation](#4-github-actions--automation)
5. [Vercel Integration](#5-vercel-integration)
6. [Project Structure](#6-project-structure)
7. [Quick Start](#7-quick-start)
8. [GitHub Repo Hygiene](#8-github-repo-hygiene)
9. [Template Maintenance](#9-template-maintenance)

---

## 1. Conventions & Naming Standards

### The Golden Rule

**Context-dependent consistency.** Different ecosystems have different conventions. The key is using the right one for the right thing, and being **consistent within a project**.

### File & Folder Naming

| Context | Convention | Examples |
|---------|-----------|---------|
| **GitHub repos** | `kebab-case` | `app.yourdomain.com` |
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
| `app.yourdomain.com` | Matches the actual domain — perfect for Vercel |
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
github.com/org/app.yourdomain.com  # Next.js web app → Vercel
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
 └── release/v2.3.0        # Release branches (manual deploy targets)
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
release/v2.3.0 ───────────────▶ QA ──fix/hotfix──▶ v2.3.0 tag ──▶ deploy
```

1. Feature work on `feat/*` branches → merge to `main`
2. When ready: `git checkout -b release/v2.3.0` from `main`
3. QA + bugfix on release branch
4. Tag: `git tag v2.3.0 && git push --tags`
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

### For Multi-Agent Orchestration Platforms

This template integrates with orchestration platforms or kanban boards:

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
├── CAPABILITIES.md              # Enterprise AI capabilities reference
├── CHANGELOG.md                 # Version history
├── CLEANUP.md                   # Repo hygiene runbook
├── CONTRIBUTING.md              # Contribution guide
├── HANDOFF.md                   # Live working state for agent sessions
├── PROGRESS.md                  # Agent loop progress tracker
├── RELEASE_NOTES.md             # Release history
├── SECURITY.md                  # Security policy
├── SUPPORT.md                   # Support & issue guidance
├── blockers.md                  # Agent loop blockers
├── CODE_OF_CONDUCT.md           # Code of conduct
├── LICENSE                      # MIT license
├── README.md                    # This file
├── .cursorrules                 # Cursor AI rules
├── .windsurfrules               # Windsurf AI rules
├── .editorconfig                # Cross-editor consistency
├── .gitattributes               # Git normalization
├── .gitignore                   # Comprehensive ignore patterns
├── .env.example                 # Documented environment variables
├── .mcp.json                    # MCP server configuration
├── .pre-commit-config.yaml       # Pre-commit hooks
├── .prettierrc                  # Code formatting (if JS/TS)
├── Dockerfile                   # Container definition
├── docker-compose.yml           # Development environment
│
├── .claude/                     # Claude Code config & skills
│   ├── agents/                  # Subagent definitions
│   │   ├── architect.md
│   │   ├── coder.md
│   │   ├── reviewer.md
│   │   ├── tester.md
│   │   ├── devops.md
│   │   ├── ux.md
│   │   └── analyst.md
│   ├── skills/                  # Repeatable Claude Code skills
│   │   ├── template-uplift/     # Promote fixes back into the template
│   │   └── ponytail/            # YAGNI-first prompt injection
│   └── settings.json            # Permission defaults
│
├── .kilo/                       # Kilo config & bundled skills
│   └── skills/
│       ├── github-cleanup/      # Merge legacy branches, delete stale refs
│       ├── pr-auto-merge/       # Auto-resolve conflicts and merge PRs
│       └── vercel-deploy/       # Deploy to Vercel with env switching
│
├── .github/
│   ├── workflows/               # CI/CD pipelines
│   │   ├── ci.yml               # Main CI workflow (lint, test, build)
│   │   ├── codeql-analysis.yml  # Security scanning
│   │   ├── security-scan.yml    # Container / dependency scanning
│   │   ├── deploy-preview.yml   # Vercel preview deployments
│   │   ├── deploy-prod.yml      # Vercel production deploy
│   │   ├── ghcr-push.yml        # Container image build & push (GHCR)
│   │   ├── dependency-review.yml# Dependency review on PRs
│   │   ├── dependabot-auto-merge.yml  # Auto-merge Dependabot PRs
│   │   ├── stale.yml            # Stale issue / PR management
│   │   ├── scorecard.yml        # OpenSSF Scorecard
│   │   ├── actionlint.yml       # Workflow linting
│   │   ├── gitleaks.yml         # Secret scanning
│   │   ├── sbom.yml             # Software Bill of Materials
│   │   └── slsa-provenance.yml  # SLSA provenance
│   ├── ISSUE_TEMPLATE/          # Issue templates
│   ├── PULL_REQUEST_TEMPLATE.md # PR template
│   ├── dependabot.yml           # Dependency automation
│   ├── renovate.json            # Renovate bot config
│   ├── auto_assign.yml          # Auto-assign reviewers
│   ├── CODEOWNERS               # Ownership & review routing
│   └── rulesets/                # Branch protection rules-as-code
│
├── docs/
│   ├── agentic-sdlc.md          # Full Agentic SDLC protocol
│   ├── architecture.md          # Architecture documentation
│   ├── build-versioning.md      # Build provenance in the footer
│   ├── ci-cd.md                 # Pipelines, permissions, supply-chain
│   ├── claude-tooling.md        # .claude/ — agents, skills, hooks, MCP
│   ├── component-structure.md   # App Router layout, data layer, styling
│   ├── decisions/               # ADRs (Architecture Decision Records)
│   ├── e2e-sdlc.md              # End-to-end testing protocol
│   ├── getting-started.md       # Quick start guide
│   ├── git-workflow.md          # Branching, commits, merging, force-push rules
│   ├── github-standards.md      # Social card, metadata, issue forms, security
│   ├── spec-driven-development.md # Spec-driven development artifacts
│   ├── structure-for-ai.md      # Structured content for AI consumption
│   ├── supply-chain-hardening.md # Supply chain security
│   ├── template-lifecycle.md     # Two-way sync with repo-template
│   ├── vercel-oidc.md           # Vercel OIDC setup
│   ├── web-standards.md         # Responsive, a11y, SEO
│   ├── website-polishing-standards.md # Site polish rules
│   ├── wcag-aa-standards.md     # Accessibility standards
│   └── 9router-integration.md   # 9Router AI gateway setup
│
├── rules/                       # Role-based agent skill files
│   ├── README.md                # Role index
│   ├── 01-architect.md          # Architecture agent
│   ├── 02-coder.md              # Implementation agent
│   ├── 03-reviewer.md           # Code review agent
│   ├── 04-tester.md             # Testing agent
│   ├── 05-devops.md             # DevOps / infrastructure agent
│   ├── 06-ux.md                 # UX/CX & accessibility agent
│   └── 07-analyst.md            # Requirements & acceptance agent
│
├── scripts/
│   ├── commit-and-clean.sh      # Lint, test, commit, and tidy
│   ├── init-project.sh          # Initialize from this template
│   ├── open-repo.sh             # Open repo in browser / editor
│   ├── propagate-template.sh    # Update downstream projects
│   ├── start-loop.sh            # Unattended agentic loop (Linux/macOS)
│   ├── start-loop.ps1           # Unattended agentic loop (Windows)
│   ├── setup-9router.ps1        # 9Router AI infrastructure setup
│   ├── verify-action-pins.sh    # Verify SHA-pinned actions
│   ├── worktree-create.sh       # Create git worktree
│   ├── worktree-list.sh         # List git worktrees
│   └── worktree-remove.sh       # Remove git worktree
│
├── templates/
│   ├── components/
│   │   ├── BuildInfo.tsx        # Build version footer component
│   │   └── DecorLayer.tsx       # Visual decor layer
│   ├── scripts/
│   │   ├── audit-overflow.mjs   # Detect layout overflow
│   │   └── generate-build-info.mjs # Generate build metadata
│   ├── styles/
│   │   └── dr-guard.css         # Digital Response guard styles
│   └── social-preview.svg       # Social preview image template
│
├── seeds/                       # Project type starter kits
│   ├── dotnet/
│   ├── nextjs/
│   └── python/
│
├── planning/                    # Planning artifacts
│   ├── ARCHITECTURE-DECISIONS.md
│   ├── BACKLOG.md
│   ├── COMPETITIVE-ANALYSIS.md
│   ├── DEEP-RESEARCH-MULTI-AGENT-ORCHESTRATION.md
│   ├── DEPENDENCIES-AND-BLOCKERS.md
│   ├── DEVELOPMENT-PHASES.md
│   ├── NEXT-PHASE-PLAN.md
│   ├── RISK-MITIGATION.md
│   ├── ROADMAP.md
│   └── worklog.md
│
├── .devcontainer/               # Dev container config
│   └── devcontainer.json
│
└── .kanban/                     # Kanban board config
    └── README.md
```

---

## 5. GitHub Actions & Automation

This template ships with hardened, production-ready GitHub Actions workflows.

### Workflows Included

| Workflow | Trigger | Purpose |
|----------|---------|---------|
| `ci.yml` | push/PR to main | Lint, test, build with concurrency cancellation and least-privilege permissions |
| `codeql-analysis.yml` | push/PR + weekly | CodeQL security scanning for JS, Python, C#, Go |
| `security-scan.yml` | push/PR + weekly | Container / dependency scanning |
| `deploy-preview.yml` | PR opened/updated | Vercel preview deployment with URL comment on PR |
| `deploy-prod.yml` | push to main | Vercel production deployment with environment protection |
| `ghcr-push.yml` | push to main + tags | Multi-arch container image to GHCR |
| `dependency-review.yml` | PR (dependency files) | Blocks PRs with high-severity or licence-violating deps |
| `dependabot-auto-merge.yml` | Dependabot PR | Auto-approve + auto-merge patch/minor updates |
| `stale.yml` | nightly | Closes stale issues/PRs after inactivity |

### Security Hardening

All workflows follow 2026 best practices:
- **Least-privilege `GITHUB_TOKEN`** — read-only by default, expand only where needed
- **SHA-pinned actions** — supply-chain hardened action references
- **Concurrency controls** — cancels superseded runs to save minutes and prevent race conditions
- **OIDC-ready** — `id-token: write` where cloud auth is needed

### Branch Protection (Recommended)

Enable these rules on `main` in GitHub Settings → Branches:
1. Require pull request before merging
2. Require status checks (CI, CodeQL, Dependency Review)
3. Require linear history (squash merge)
4. Dismiss stale reviews on new commits
5. Restrict pushes to maintainers only

---

## 6. Vercel Integration

Vercel auto-deploys `main` to production. Every feature branch gets a preview deployment.

### Workflow

```
main ──feat/tenant-sso──PR──▶ main ──▶ Vercel prod auto-deploy
                                 ↑
                         (CI must pass, linear history)
```

1. Branch from `main`: `git checkout -b feat/tenant-sso`
2. Work, commit, push — Vercel creates preview deployment via `deploy-preview.yml`
3. Open PR — review on the preview URL (auto-commented by the workflow)
4. Merge to `main` — Vercel auto-deploys to production via `deploy-prod.yml`

### Required Secrets

| Secret | Purpose |
|--------|---------|
| `VERCEL_TOKEN` | Vercel API authentication |
| `VERCEL_ORG_ID` | Vercel team/organisation ID |
| `VERCEL_PROJECT_ID` | Vercel project ID |

### Environment Protection

Production deploys use GitHub environment protection rules. Configure required reviewers in Settings → Environments → `production`.

### Vercel Analytics (Free)

Every Vercel project includes **Web Analytics** and **Speed Insights** at no cost. The template injects both via script tags in `docs/index.html` (or your app's root layout). No secrets or configuration required — Vercel auto-detects the project from the deployment.

For Next.js apps, add to `app/layout.tsx`:

```tsx
import { Analytics } from '@vercel/analytics/react';
import { SpeedInsights } from '@vercel/speed-insights/next';

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en">
      <body>
        {children}
        <Analytics />
        <SpeedInsights />
      </body>
    </html>
  );
}
```

For static HTML or non-Next.js sites, add to the `<head>`:

```html
<script defer src="https://analytics.vercel.app/main.js"></script>
<script defer src="https://analytics.vercel.app/speed-insights.js"></script>
```

Both are zero-config, privacy-friendly, and respect Do Not Track.

---

## 7. Quick Start

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

### Unattended Agentic Loop

For fully autonomous sessions, use the loop scripts:

```bash
# Linux / macOS
bash scripts/start-loop.sh

# Windows (PowerShell)
.\scripts\start-loop.ps1
```

Stop conditions: create a `STOP` file, or write `DONE` to `PROGRESS.md`.

---

## 8. Template Maintenance

This template is kept in sync across all your projects via the propagation script. See `scripts/propagate-template.sh` for the workflow.

```bash
# After updating this template, propagate to downstream repos:
bash scripts/propagate-template.sh /path/to/downstream-repo
```

---

## 9. GitHub Repo Hygiene

Keep the repository tidy with the built-in cleanup skills and runbook.

### Built-in Skills

| Skill | Location | Trigger |
|-------|----------|---------|
| `github-cleanup` | `.kilo/skills/github-cleanup/` | "clean up this repo", "merge legacy branches", "tidy branches" |
| `pr-auto-merge` | `.kilo/skills/pr-auto-merge/` | "auto-merge PRs", "resolve conflicts and merge" |

### Cleanup Checklist

Run this checklist at the start of any session or on a schedule:

1. **Ensure `main` is the default branch**
   ```bash
   gh repo view --json defaultBranchRef --jq '.defaultBranchRef.name'
   ```
   If it is not `main`, rename it:
   ```bash
   git branch -m <OLD> main
   git push origin main
   gh repo edit --default-branch main
   git push origin --delete <OLD>
   ```

2. **Merge legacy branches into `main`**
   ```bash
   git ls-remote --heads origin | awk '{print $2}' | grep -Ei 'refs/heads/(master|Master|Mai)$'
   ```
   For each legacy branch:
   ```bash
   git checkout main && git pull origin main
   git merge origin/<LEGACY> --no-commit --no-ff
   git add -A && git commit -m "Merge <LEGACY> into main"
   git push origin main
   git push origin --delete <LEGACY>
   ```

3. **Delete stale merged branches**
   ```bash
   git branch -r --merged main | grep -vE 'origin/(main|HEAD)' | sed 's/origin\///' | xargs -I{} git push origin --delete {}
   ```

4. **Close stale issues and PRs**
   ```bash
   gh issue list --state open --label stale --limit 50
   gh pr list --state open --label stale --limit 50
   ```
   Review and close anything that has gone quiet.

5. **Verify the repo is clean**
   ```bash
   git status -sb
   git stash list
   git worktree list
   ```

### Automation

- `scripts/commit-and-clean.sh` — lint, test, commit, and tidy in one step.
- `CLEANUP.md` — project-specific cleanup runbook with repo inventory and progress.

---

## Version History

See `CHANGELOG.md` for the full version history.

## License

MIT — see `LICENSE`.
