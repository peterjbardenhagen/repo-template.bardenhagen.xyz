# CLAUDE.md

## Project Overview

This project was generated from the **Repo Template** (`repo-template.bardenhagen.xyz`). See `AGENTS.md` for master agent instructions, `AI_CONTEXT.md` for a quick project summary, and the README for detailed conventions and the agentic SDLC protocol.

## Tech Stack

*Replace with your project's actual tech stack:*
- **Language/Framework:** [e.g., TypeScript/Next.js, C#/.NET, Python/FastAPI]
- **Runtime:** [e.g., Node.js 20+, .NET 10, Python 3.11+]
- **Database:** [e.g., PostgreSQL, SQLite, SQL Server]
- **Infrastructure:** [e.g., Docker, Vercel, Azure, Tailscale]

## Repository Structure

```
├── AGENTS.md              # Master agent instructions
├── CLAUDE.md              # This file
├── AI_CONTEXT.md          # Quick project context
├── rules/                 # Role-based agent skill files
├── docs/                  # Documentation & ADRs
├── .github/workflows/     # CI/CD pipelines
└── src/                   # Source code
```

## Commands

*Replace with your project's actual commands:*

```bash
# Development
npm run dev              # Start dev server
npm run build            # Production build
npm run lint             # Run linter
npm run format           # Format code

# Testing
npm test                 # Run tests
npm run test:watch       # Watch mode
npm run test:coverage    # Coverage report

# Docker
docker compose up        # Start dev environment
docker compose down      # Stop environment
```

## Code Style

- Follow existing patterns in the codebase
- Use the project's naming conventions (see README)
- Use meaningful variable/function names
- Write tests for new functionality
- Update documentation alongside code changes
- Commit messages: `type(scope): description`

## Git Workflow

- Default branch is `main` — always green, always deployable
- Feature branches: `feat/description`, `fix/description`, `chore/description`
- Always run `git pull --ff-only origin main` before starting work
- Rebase feature branches on main before PR
- Squash merge PRs to main

## AI Agent Protocol

1. Read AGENTS.md, CLAUDE.md, and AI_CONTEXT.md at session start
2. Pull latest before making changes (`git pull --ff-only origin main`)
3. State approach before writing code
4. Run tests before considering work done
5. Commit after each logical phase (conventional commits)
6. Update CHANGELOG.md with significant changes
7. Push branch and create PR when done
