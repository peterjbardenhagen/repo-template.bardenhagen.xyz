# End-to-End Agentic SDLC — Complete Guide

**Version:** 2.2.0 | **Date:** August 2026

---

## Overview

This document describes the complete software development lifecycle (SDLC) for projects using this template. Every stage — from ideation to production deployment and monitoring — is covered with specific tools, workflows, and AI agent integration points.

---

## 1. Project Bootstrap

### 1.1 Create from Template

```bash
# Option A: GitHub template repository
github.com/new -> "Use a template" -> repo-template.bardenhagen.xyz

# Option B: Clone and rename
git clone https://github.com/peterjbardenhagen/repo-template.bardenhagen.xyz.git my-new-project
cd my-new-project
rm -rf .git && git init
git add . && git commit -m "chore: bootstrap from repo-template"
```

### 1.2 Initial Configuration

1. **Rename** `CLAUDE.md` placeholders with your actual tech stack
2. **Update** `README.md` with project-specific content
3. **Configure** `.env.example` with required environment variables
4. **Set up** Vercel project (if web app)
5. **Add** repo secrets: `VERCEL_TOKEN`, `VERCEL_ORG_ID`, `VERCEL_PROJECT_ID`

### 1.3 Files Included on Bootstrap

| File | Purpose |
|------|--------|
| `AGENTS.md` | AI agent operating instructions |
| `CLAUDE.md` | Claude Code project context |
| `AI_CONTEXT.md` | Quick project summary for AI tools |
| `.cursorrules` | Cursor IDE rules |
| `.pre-commit-config.yaml` | Git hooks for code quality |
| `.github/workflows/ci.yml` | CI pipeline (lint, build, test) |
| `.github/dependabot.yml` | Automated dependency updates |
| `CONTRIBUTING.md` | Contributor guidelines |
| `SECURITY.md` | Security policy |
| `LICENSE` | Project licence |

---

## 2. Development Workflow

### 2.1 Branching Strategy

```
main ───────────────────────────────────────────── (production)
  \─ feat/add-login ──────────────── PR ── merge ──> (feature)
  \─ fix/memory-leak ────────────── PR ── merge ──> (hotfix)
  \─ chore/update-deps ──────────── PR ── merge ──> (maintenance)
```

**Rules:**
- `main` is always deployable
- Feature branches: `feat/<description>`
- Bug fixes: `fix/<description>`
- Chores: `chore/<description>`
- All changes go through PRs (no direct pushes to main)
- Branches auto-delete after merge (repo setting enabled)

### 2.2 Commit Convention

All commits follow [Conventional Commits](https://www.conventionalcommits.org):

```
type(scope): description
```

| Type | Use For | Example |
|------|---------|--------|
| `feat` | New feature | `feat(auth): add OAuth2 flow` |
| `fix` | Bug fix | `fix(api): handle null response` |
| `docs` | Documentation | `docs: update README` |
| `chore` | Tooling/config | `chore: update dependencies` |
| `refactor` | Code restructuring | `refactor(db): extract query builder` |
| `test` | Tests | `test(auth): add login tests` |
| `ci` | CI/CD | `ci: add CodeQL workflow` |
| `perf` | Performance | `perf(api): add response caching` |
| `security` | Security | `security: fix XSS vulnerability` |

### 2.3 AI Agent Workflow

When an AI agent (Claude Code, Cline, Cursor) works on a task:

```
1. READ context files (AGENTS.md, CLAUDE.md, AI_CONTEXT.md)
2. git pull --ff-only origin main
3. git checkout -b feat/feature-name
4. Implement changes (small, focused commits)
5. Run tests: npm test
6. Run lint: npm run lint
7. git push origin feat/feature-name
8. Create PR using template
9. CI runs automatically (lint, build, test, CodeQL, dependency review)
10. Request review / auto-merge if approved
```

---

## 3. CI/CD Pipeline

### 3.1 Workflow Summary

| Workflow | Trigger | Purpose |
|----------|---------|--------|
| `ci.yml` | push/PR to main | Lint, build, test |
| `codeql-analysis.yml` | push/PR/weekly | Security code analysis |
| `dependabot-auto-merge.yml` | PR from dependabot | Auto-merge patch/minor updates |
| `dependency-review.yml` | PR | Check new dependencies for vulnerabilities |
| `deploy-preview.yml` | PR | Vercel preview deployment |
| `deploy-prod.yml` | push to main | Vercel production deployment |
| `security-scan.yml` | push/PR/weekly | npm audit + vulnerability reporting |
| `stale.yml` | daily | Close inactive issues/PRs |
| `auto-assign.yml` | PR opened | Auto-assign reviewers |
| `ghcr-push.yml` | push to main | Build and push Docker image to GHCR |

### 3.2 CI Pipeline Flow

```
PR Created
  ├─> ci.yml
  │     ├─ action-pins (verify SHA pins)
  │     ├─ lint (eslint/prettier)
  │     ├─ build (next build / dotnet build)
  │     └─ test (playwright/jest/xunit)
  │
  ├─> codeql-analysis.yml
  │     └─ Detect languages -> Run CodeQL
  │
  ├─> dependency-review.yml
  │     └─ Check new deps for known CVEs
  │
  ├─> deploy-preview.yml
  │     └─ Vercel preview deployment
  │
  └─> security-scan.yml
        └─ npm audit -> Report results

Merge to main
  ├─> deploy-prod.yml
  │     └─ Vercel production deployment
  │
  ├─> ghcr-push.yml
  │     └─ Build Docker image -> Push to GHCR
  │
  └─> security-scan.yml (weekly)
        └─ Full vulnerability scan
```

### 3.3 Required Repository Secrets

| Secret | Where | Purpose |
|--------|-------|--------|
| `VERCEL_TOKEN` | Repo settings | Vercel deployment |
| `VERCEL_ORG_ID` | Repo settings | Vercel org |
| `VERCEL_PROJECT_ID` | Repo settings | Vercel project |

---

## 4. Quality Gates

### 4.1 Branch Protection Rules

On `main` branch:
- Require pull request reviews (1 approval minimum)
- Require status checks to pass (ci, codeql)
- Require branches to be up to date
- Require conversation resolution
- No force pushes
- No deletions

### 4.2 Automated Checks

| Gate | Tool | Blocks Merge? |
|------|------|---------------|
| Lint | ESLint / Prettier | Yes |
| Build | Next.js / .NET build | Yes |
| Tests | Playwright / Jest / xUnit | Yes |
| CodeQL | GitHub Code Scanning | Yes (on high/critical) |
| Dependency Review | GitHub Dependency Review | Yes (on critical) |
| npm audit | npm audit | No (informational) |

### 4.3 Pre-Commit Hooks

Via `.pre-commit-config.yaml`:
- Prettier formatting
- ESLint linting
- Conventional commit message validation
- Secrets detection

---

## 5. Deployment

### 5.1 Vercel (Web Apps)

**Preview Deployments (PRs):**
- Automatic on every PR
- Unique URL for testing
- Comments on PR with preview link

**Production Deployments (main push):**
- Automatic on merge to main
- Zero-downtime deployment
- Instant rollback available

### 5.2 Docker / GHCR (Services)

**Image Tags:**
- `main` - latest main branch
- `v1.2.3` - semantic version tags
- `main-abc1234` - commit SHA tags

**Multi-arch builds:**
- `linux/amd64` and `linux/arm64`
- QEMU + Buildx for cross-compilation

### 5.3 Rollback Procedure

```bash
# Vercel: Instant rollback via dashboard or CLI
vercel rollback

# Docker: Deploy previous image tag
docker pull ghcr.io/org/app:v1.2.2
docker-compose up -d
```

---

## 6. Security

### 6.1 Security Scanning

| Scan | Frequency | Tool |
|------|-----------|------|
| Code analysis | Every push/PR | CodeQL |
| Dependency review | Every PR | GitHub Dependency Review |
| npm audit | Weekly + every push | npm audit |
| Secret detection | Every commit | pre-commit hooks |
| Container scanning | Every push to main | Docker scan |

### 6.2 Vulnerability Response

| Severity | Response Time | Action |
|----------|--------------|--------|
| Critical | < 24 hours | Hotfix PR, expedited review |
| High | < 72 hours | Fix in next sprint |
| Moderate | Next sprint | Regular PR |
| Low | Backlog | Address when convenient |

### 6.3 Security Policy

See `SECURITY.md` for:
- Supported versions
- Reporting vulnerabilities
- Response timeline
- Disclosure policy

---

## 7. Documentation

### 7.1 Required Files

| File | Purpose | Audience |
|------|---------|----------|
| `README.md` | Project overview, setup, usage | Everyone |
| `AGENTS.md` | AI agent instructions | AI tools |
| `CLAUDE.md` | Claude Code context | Claude |
| `AI_CONTEXT.md` | Quick project summary | All AI tools |
| `CONTRIBUTING.md` | Contribution guidelines | Contributors |
| `SECURITY.md` | Security policy | Security researchers |
| `CHANGELOG.md` | Version history | Everyone |
| `RELEASE_NOTES.md` | Release announcements | Users |
| `docs/` | Detailed documentation | Developers |

### 7.2 Architecture Decision Records (ADRs)

Store in `docs/decisions/`:

```
ADR-001: Use Next.js for frontend
ADR-002: PostgreSQL for database
ADR-003: Supabase for auth
```

Each ADR follows the template in `rules/01-architect.md`.

---

## 8. Monitoring & Observability

### 8.1 Vercel Analytics
- Core Web Vitals tracking
- Real User Monitoring (RUM)
- Performance metrics

### 8.2 Error Tracking
- Sentry integration (if configured)
- Vercel Function logs
- GitHub Actions failure notifications

### 8.3 Uptime Monitoring
- BetterStack / UptimeRobot
- Health check endpoints
- Alert on downtime

---

## 9. Release Process

### 9.1 Version Numbering

Follow [Semantic Versioning](https://semver.org):

```
MAJOR.MINOR.PATCH
1.0.0
```

- **MAJOR:** Breaking changes
- **MINOR:** New features (backward compatible)
- **PATCH:** Bug fixes

### 9.2 Creating a Release

```bash
# Using Changesets (recommended)
npx changeset        # Describe changes
npx changeset version # Bump version
git push             # Push to main

# Or manual
gh release create v1.2.3 --title "v1.2.3" --notes "Release notes"
```

### 9.3 Automated Changelog

The `CHANGELOG.md` is auto-generated from conventional commits:

```bash
npx conventional-changelog -p angular -i CHANGELOG.md -s
```

---

## 10. Agent Roles

| Role | File | Responsibilities |
|------|------|------------------|
| Architect | `rules/01-architect.md` | System design, ADRs, tech decisions |
| Coder | `rules/02-coder.md` | Implementation, small commits |
| Reviewer | `rules/03-reviewer.md` | Code review, quality gates |
| Tester | `rules/04-tester.md` | Test strategy, E2E tests |
| DevOps | `rules/05-devops.md` | CI/CD, deployment, monitoring |
| UX | `rules/06-ux.md` | UI/UX review, accessibility |
| Analyst | `rules/07-analyst.md` | Requirements, acceptance criteria |

---

## 11. Quick Reference

### Daily Developer Commands

```bash
git pull --ff-only origin main    # Sync
git checkout -b feat/my-feature   # Branch
npm run dev                        # Develop
npm test                           # Test
npm run lint                       # Lint
git commit -m "feat(scope): desc" # Commit
git push origin feat/my-feature   # Push
gh pr create                       # Create PR
```

### AI Agent Commands

```bash
# Claude Code
/ponytail full                    # Enable lazy senior dev mode

# Cline
# Read AGENTS.md, CLAUDE.md, AI_CONTEXT.md at session start

# Cursor
# .cursorrules loaded automatically
```

---

*This document is the single source of truth for the SDLC process. All projects using this template inherit these practices.*
