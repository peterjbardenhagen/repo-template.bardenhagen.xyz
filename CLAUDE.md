# CLAUDE.md

## Project Overview

This project was generated from the **Perfect Repo Template** — an agentic AI SDLC starter template. See `AGENTS.md` for master agent instructions, `AI_CONTEXT.md` for a quick project summary, and `docs/agentic-sdlc.md` for the autonomous development lifecycle protocol.

## Tech Stack

*As generated — replace with your project's actual tech stack:*
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
- Use meaningful variable/function names
- Write tests for new functionality
- Update documentation alongside code changes
- Commit messages: `type(scope): description`

## AI Agent Protocol

1. Read AGENTS.md, CLAUDE.md, and AI_CONTEXT.md at session start
2. Pull latest before making changes (`git pull --ff-only`)
3. Run tests before considering work done
4. Commit after each logical phase
5. Update CHANGELOG.md with significant changes
