# AI_CONTEXT.md — Quick Project Context

**One-page summary of this project for AI agent orientation.** Read this first, then AGENTS.md, then the role-specific rule file.

## What This Project Is

This is the **Repo Template** (`repo-template.bardenhagen.xyz`) — a comprehensive starter template for AI-powered software development. It codifies naming conventions, git workflows, and the full Agentic AI SDLC lifecycle.

## Key Facts

- **Default branch:** `main`
- **Template repo:** `peterjbardenhagen/repo-template.bardenhagen.xyz`
- **License:** MIT
- **Version:** 2.0.0
- **Source:** https://github.com/peterjbardenhagen/repo-template.bardenhagen.xyz

## Conventions at a Glance

| Convention | Standard |
|-----------|----------|
| Branch naming | `type/kebab-case` (feat/, fix/, chore/, docs/, release/) |
| Commit messages | Conventional Commits: `type(scope): description` |
| Git workflow | Trunk-based: `main` is always green. Feature branches → PR → squash merge |
| File naming | PascalCase for components, camelCase for utils, kebab-case for folders/files |
| Repo naming | kebab-case, lowercase, hyphens only |

## Agent Roles

| Role | Rule File | Responsibility |
|------|-----------|---------------|
| Architect | `rules/01-architect.md` | System design, ADRs |
| Coder | `rules/02-coder.md` | Implementation |
| Reviewer | `rules/03-reviewer.md` | Code review |
| Tester | `rules/04-tester.md` | Testing |
| DevOps | `rules/05-devops.md` | CI/CD, deploy |

## Session Protocol

1. Read AGENTS.md, CLAUDE.md, AI_CONTEXT.md, and .cursorrules
2. `git pull --ff-only origin main`
3. Check existing issues, PRs, or the explicitly stated task
4. Review docs/decisions/ for prior architecture decisions
5. State approach before writing code
6. Commit after every logical phase using conventional commits
7. Run tests and verify before considering work complete
8. Update CHANGELOG.md for significant changes
