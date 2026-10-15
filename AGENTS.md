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

1. **Read context files first** — Check AGENTS.md, CLAUDE.md, docs/project/context.md, and .cursorrules at the start of every session.
2. **Follow the Agentic SDLC** — See the README for the full autonomous development lifecycle protocol.
3. **State lives in files, not in model memory** — Write decisions, progress, and blockers to files. Do not assume the next session has context from this one.
4. **Commit frequently** — After every logical phase of work. Keep history clean and recoverable.
5. **Pull before working** — Always sync from origin before making changes. Use `git pull --ff-only`.
6. **No fake completion** — Never mark work done that isn't actually complete. Report blockers honestly.
7. **Conventional commits** — Use `type(scope): description` (e.g., `feat(auth): add OAuth2 flow`).
9. **Load structured context first** — Check `docs/status/handoff.md` for live state, then load phase-specific instructions. Do not load every file into context; use progressive disclosure.
8. **Answer both questions** — "Did we build it correctly" *and* "did we build the right thing". The second is the expensive one and no test can check it. Define acceptance criteria before you code and verify against the original request before you call it done (`rules/07-analyst.md`). If it has a user-facing surface, apply `rules/06-ux.md` too.

## Ponytail — Lazy Senior Dev Mode

**Ponytail** (`ponytail.dev`) applies YAGNI-first code generation. Installed globally and included in `.claude/skills/ponytail/`.

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

This keeps every safety guard while reducing unnecessary code.

## File Structure Overview

```
.
├── AGENTS.md              # This file — master agent instructions
├── docs/project/capabilities.md        # Enterprise AI capabilities reference (BytePlus ↔ Claude mapping)
├── CLAUDE.md              # Claude-specific configuration
├── AGENTS.md               # Codex-specific instructions
├── .github/copilot-instructions.md# GitHub Copilot instructions
├── docs/project/context.md          # Project context summary (all agents)
├── .mcp.json              # MCP server configuration (Context7, GitHub, Playwright)
├── docs/status/handoff.md             # Live working state for agent sessions
├── specs/                 # Spec-driven development artifacts
├── CODEOWNERS             # Auto-review assignment
├── .windsurfrules         # Windsurf AI rules
├── rules/                 # Role-based agent skill files
│   ├── 01-architect.md    # Architecture agent
│   ├── 02-coder.md        # Coding agent
│   ├── 03-reviewer.md     # Code review agent
│   ├── 04-tester.md       # Testing agent
│   ├── 05-devops.md       # DevOps agent
│   ├── 06-ux.md           # UX/CX & accessibility agent
│   └── 07-analyst.md      # Requirements & acceptance agent
├── .claude/
│   ├── agents/            # Claude Code subagents (mirror rules/ roles)
│   ├── skills/            # Claude Code skills
│   │   └── template-uplift/  # Promote an improvement back into the template
│   └── settings.json      # Committed permission defaults
├── .github/rulesets/      # Branch-protection rules-as-code
├── .github/workflows/     # CI/CD pipelines (ci, deploy, security, stale, scorecard, gitleaks, sbom)
├── .github/workflows/     # CI/CD pipelines (ci, deploy, security, stale)
├── CONTRIBUTING.md        # Human + agent contribution guide
├── docs/                  # Documentation
│   ├── agentic-sdlc.md    # Agentic SDLC protocol
│   ├── architecture.md    # Architecture documentation
│   ├── git-workflow.md    # Branching, commits, merging, force-push rules
│   ├── ci-cd.md           # Pipelines, permissions, supply-chain hardening
│   ├── web-standards.md   # Responsive, a11y, SEO — incl. banned patterns
│   ├── component-structure.md # App Router layout, data layer, styling
│   ├── build-versioning.md    # Build provenance in the footer
│   ├── github-standards.md    # Social card, metadata, issue forms, security
│   ├── claude-tooling.md      # .claude/ — agents, skills, hooks, MCP
│   ├── template-lifecycle.md  # Two-way sync with repo-template
│   └── decisions/         # Architecture Decision Records
├── scripts/               # Automation scripts (init, propagate, start-loop, worktree)
├── seeds/                 # Template seeds for project types
└── templates/             # Copyable scripts, components, styles
```

**Before writing code, read the standard that governs it** — `web-standards.md`
for anything with a UI, `component-structure.md` for React/Next work,
`git-workflow.md` before your first commit. Each carries a banned-patterns table
or checklist that is faster to scan than the bug it prevents is to debug.

## Anti-Patterns

- **Don't create a parallel implementation.** If similar functionality already exists, extend it. If this repo has a documented history of duplicate/abandoned implementations, it lives in `archive/README.md` — read it before starting new work in a mature area of the codebase.
- **Don't let docs drift from shipped state.** If a change affects anything user-facing (features, architecture, pricing, roadmap) and this project has a marketing site or public docs, update them in the *same* change — not a follow-up. Documentation drift is worse than a missing feature.

## Progressive Disclosure for Agents

**State lives in files, not in model memory.** Agents MUST use progressive disclosure to avoid loading the entire repository into context:

1. **Session start** — Load only `AGENTS.md`, `docs/status/handoff.md`, and the phase index (`docs/agentic/sdlc.md`).
2. **Task start** — Load the relevant skill or role file (`rules/01-architect.md`, etc.) only when that role is active.
3. **Deep work** — Load architecture, conventions, and tech stack only when implementing a specific component.
4. **Review** — Load PR contract and quality gates only when reviewing.

This keeps token usage proportional to task complexity and prevents context window exhaustion.

## Structured Content for AI Consumption

When authoring documentation, follow the schema in `docs/agentic/agent-tooling.md`. Structured content enables agents to:
- Reason about the codebase programmatically
- Validate artifacts against schemas
- Trace requirements from intent to implementation

Key files for structured context:
- `specs/mission.md` — Project constitution (what we build, who we serve)
- `specs/tech-stack.md` — Stack constraints and rationale
- `docs/status/handoff.md` — Live working state (in flight, next picks, blockers)
- `.mcp.json` — MCP server configuration for live tool access

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

- `main` is the trunk — always green, always deployable. **Never commit to it directly.**
- Project-wide naming conventions are documented in the README. Follow them.
- Commit messages: `type(scope): description` (e.g., `feat(auth): add MFA support`).
- Branch from a current trunk: `git fetch origin && git checkout -B <branch> origin/main`.
  Rebase onto `origin/main` before pushing.
- PR branches: `feat/description`, `fix/description`, `chore/description`.
  Agent-authored: `claude/<feature>-<short-code>`.
- Squash merge, then delete the branch. `--force-with-lease` on your own branch
  only; never force-push `main`.
- Keep `.env` in `.gitignore`; document required variables in `.env.example`.
- Architecture decisions go in `docs/decisions/` as ADR files.
- Update `CHANGELOG.md` with every significant change.

Full branching, commit, and merge rules: [`docs/engineering/git-workflow.md`](docs/engineering/git-workflow.md).

## Agentic SDLC Protocol

1. **Read context** — AGENTS.md → CLAUDE.md → docs/project/context.md → .cursorrules
2. **Orient** — `git fetch origin`, branch off `origin/main`, check issues/PRs/task
3. **Plan** — State approach before coding. Write/update ADR if architect role.
4. **Execute** — One logical change, run linters, commit.
5. **Verify** — Full tests + build. Update CHANGELOG.md.
6. **Deliver** — Rebase on `origin/main`, push branch, open PR.
7. **Land** — Drive CI to green. Never bypass a failing check; fix it or escalate it.

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

## Pre-Commit Hooks

A `.pre-commit-config.yaml` is included to catch merge conflict markers before they're committed. Install and activate it:

```bash
pip install pre-commit
pre-commit install
pre-commit run --all-files  # Validate existing files
```

This prevents accidentally committing files with `<<<<<<< HEAD` markers and catches other common issues (trailing whitespace, YAML/JSON syntax errors, etc.).

## Before You Finish

- [ ] Read the relevant READMEs and `docs/` before making assumptions
- [ ] Followed existing patterns rather than introducing a new style
- [ ] Wrote/updated tests
- [ ] Updated docs (including this file's sections above, if they went stale)
- [ ] Ran the full build
- [ ] Tested manually if the change has a UI or user-facing surface
- [ ] For tool/config changes: reviewed `docs/agentic/agent-tooling.md` to ensure consistency

## Version

This template is versioned. See `CHANGELOG.md` for the current version and release history.

## Available Skills

The canonical skill set lives in `.agents/skills/` and is pinned there. Every supported agent folder (`.claude`, `.windsurf`, `.kiro`, `.roo` …) symlinks the same set. Add skills with `npx skills add <owner/repo@skill>`, and use one whenever it fits the task.

| Area | Skills |
|---|---|
| Discover | `find-skills` |
| Think before building | `grill-me`, `codebase-design`, `solution-architecture`, `enterprise-architecture` |
| Build and verify | `tdd`, `code-review`, `vercel-react-best-practices`, `using-git-worktrees` |
| Design and UX | `frontend-design`, `impeccable`, `design-taste-frontend`, `web-design-guidelines`, `ui-ux-pro-max`, `ux-copy`, `brand-guidelines-generator` |
| Git and GitHub | `git-commit`, `git-flow-branch-creator`, `git-guardrails-claude-code`, `github-issues`, `create-github-*` (issues, PRs, workflow specs) |
| Cloud AI | `microsoft-foundry` (see also `docs/cloud/enterprise-ai-platforms.md`) |

Repo-specific skills: **template-uplift** (`.claude/skills/template-uplift/`) promotes an improvement back into this template; **github-cleanup**, **pr-auto-merge** and **vercel-deploy** live under `.kilo/skills/`.

## Agentic development practices (reviewed October 2026)

- **Context is the product.** Keep `AGENTS.md` short and current, link to `docs/` for depth, and give agents the exact commands to lint, typecheck, test and build.
- **Spec, then plan, then code.** For non-trivial work, write a short spec with acceptance criteria (`docs/agentic/spec-driven-development.md`), get the plan reviewed, and then implement in slices that each fit one PR.
- **Harness over memory.** Anything that must always happen (formatting, secret scanning, tests before finishing, branch protection) is enforced by hooks, CI and rulesets, not by asking the model to remember it.
- **Parallel agents, isolated work.** One git worktree or branch per agent. Never let two agents share a working tree, and never commit to `main` directly.
- **Evals are tests.** Prompt, model and agent changes run an eval set in CI. Track task success, cost per task, tool accuracy and loop or stall rate (`docs/agentic/sdlc.md`).
- **Least privilege for agents.** Scope tool permissions and MCP servers per task, use secretless authentication (OIDC, workload identity), and keep humans approving anything external or irreversible.
- **Enterprise AI clouds.** Follow `docs/cloud/enterprise-ai-platforms.md` for Microsoft Foundry, Amazon Bedrock and Vertex AI / Gemini.

## 9Router AI Infrastructure

The repo template includes a comprehensive setup script for 9Router and related AI infrastructure components:

### Setup Script
```powershell
# Full installation with all components
.\scripts\setup-9router.ps1

# Selective installation
.\scripts\setup-9router.ps1 -SkipRTK
.\scripts\setup-9router.ps1 -SkipCLIProxy
.\scripts\setup-9router.ps1 -SkipCaveman
.\scripts\setup-9router.ps1 -SkipPonytail
```

### Components Installed

| Component | Description | Purpose |
|-----------|-------------|---------|
| **9Router** | AI Gateway with OpenAI-compatible endpoints | Routes requests to 40+ providers, auto-fallback, quota tracking |
| **CLIProxyAPI** | CLI proxy for OAuth-based providers | Connects Claude Code, Codex, Gemini subscriptions |
| **RTK** | Rust Token Killer - bash output compression | Saves 60-90% tokens on dev commands |
| **Caveman** | Terseness prompt injection | Cuts output tokens by ~65% |
| **Ponytail** | Lazy senior dev prompt injection | YAGNI-first code, 54% code reduction |

### Quick Start
1. Run `.\scripts\setup-9router.ps1`
2. Start 9Router: `cd ~/.ai-infrastructure/9router-source && npm run dev`
3. Open http://localhost:20128/dashboard
4. Configure AI tools: `http://localhost:20128/v1` with API key

### Environment Variables
```powershell
$env:NINEROUTER_URL = "http://localhost:20128"
$env:NINEROUTER_KEY = "sk-..."  # From dashboard
```

### Hermes Integration
Profiles updated automatically:
- `.hermes/profiles/default-profile.json` - Uses 9router as primary
- `.hermes/profiles/omniroute-profile.json` - OmniRoute with 9router fallback

## Claude Code environment for agentic development

Every repository is set up so any agent (Claude Code first; Codex, Gemini, Cursor, Copilot and others via this file) starts with the same context, guardrails and tools.

**Instruction files**
- `AGENTS.md` is the single contract. `CLAUDE.md` imports it with `@AGENTS.md` and adds only Claude-specific notes; it must never contradict it.
- Keep both short and current: they are loaded into every session, so stale or bloated instructions cost tokens and mislead agents. Put long procedures in `docs/` and link to them.

**`.claude/` (committed)**
- `settings.json`: shared permissions. Allow routine read/build/test commands; **deny** destructive ones (`git push --force`, `git reset --hard`, `rm -rf`, reading `.env*` or key files). Personal overrides go in `settings.local.json`, which stays git-ignored.
- `hooks` in `settings.json` enforce what must always happen. Hooks are run by the harness, not left to the model's memory. Minimum set: format or lint changed files after edits, block writes containing secrets, and run the fast test or typecheck before the agent stops.
- `agents/`: project subagents for focused roles (reviewer, tester, architect, designer). Give each a narrow tool list.
- `skills/`: project skills, pinned in `skills-lock.json` and installed with `npx skills add <owner/repo@skill>`. Use a skill when one fits instead of improvising its method.

**MCP servers**
- Declare them in `.mcp.json` with **no secrets**. Pull credentials from the environment, the secret store (Doppler) or OAuth. Never commit a token, even to a private repo.
- Prefer one aggregated server (for example the Neocortex MCP) over many overlapping ones; fewer tools means better tool selection.

**Working practices**
- Plan before large or ambiguous changes (plan mode, or a written plan in the task or issue). Split epics into slices that each fit one reviewable PR.
- Always work on a branch or worktree, never on `main`. Use git worktrees for parallel agents so they never share a working tree.
- Verify, don't assume: run the project's lint, typecheck, tests and build, and look at UI changes at phone and desktop widths. Report failures honestly, including ones that were already there.
- Review your own diff (`/code-review` or the reviewer subagent) before opening a PR, and check for secrets, generated files and unrelated changes.
- Keep context lean: read only the files you need, delegate wide searches to a subagent, and record durable decisions in docs or ADRs, not chat.
- Track work on the board: anything unfinished or blocked is written down with the exact blocker and next step before the session ends.

**New repository checklist**
1. `AGENTS.md` + `CLAUDE.md` (`@AGENTS.md`) present.
2. `.claude/settings.json` with permissions, deny list and hooks; `settings.local.json` git-ignored.
3. `.mcp.json` with no secrets; secrets in the secret store.
4. Skills installed and pinned in `skills-lock.json`.
5. Lint, typecheck, test and build scripts that an agent can run without prompts.
6. CI runs the same gates on every PR.


## Productised delivery and lifecycle safety

Plan work from business outcomes through epics, features, tasks/defects and versioned releases. Every repository should be productised from day zero at an appropriately thin level: configuration rather than environment-specific hard-coding, tests, security/privacy, observability, documentation, local development, deployment and rollback. Follow [Productised agile delivery](docs/engineering/productised-agile-delivery.md) for release/semantic versioning, hotfixes, readiness/done criteria and reversible data lifecycle practices.

Do not hard-delete business data or related records by default. Prefer soft-delete/archive, explicit retention, auditability and separately authorised purge where lawful. Secrets and compromised credentials are an exception: revoke/rotate promptly. Never bypass required checks or claim verification without evidence.


## Pull request freshness and change-loss prevention (mandatory)

- Before merging any pull request into the default branch, update the PR head branch with the latest base branch using the repository-approved strategy. A mergeable flag or absence of textual conflicts does not prove the branch is current or safe.
- Resolve conflicts by understanding and preserving intended changes from both the PR and the latest base branch. Never blindly choose one side or discard changes without review.
- After updating, run the relevant build, tests, lint, type checks and security checks. Review the final diff against the updated base for unexpected deletions, reversions, overwritten features and generated-file churn.
- Immediately before merge, recheck the base commit SHA. If the base moved since validation, update and validate again.
- Never force-push, reset hard, or use destructive clean-up to make a branch appear current. Preserve work on a safety branch before any repair.
- If freshness, conflict resolution, validation, or change preservation cannot be verified, leave the PR open and record the exact blocker. Do not merge around failed or missing required checks.
- This policy applies to every agent, automated sync job, native CI/CD runner, and manual merge process.
