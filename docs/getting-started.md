# Getting Started

> *Replace with your project's actual getting-started guide.*

Welcome to your new project! This guide will help you get up and running quickly.

## Prerequisites

- [ ] Git
- [ ] [Language/Framework runtime] (e.g., Node.js 20+, .NET 10, Python 3.11+)
- [ ] [Package manager] (e.g., npm, dotnet, pip)
- [ ] Docker (optional, for containerized development)

## Setup

```bash
# Clone the repository
git clone <repo-url>
cd <project-directory>

# Install dependencies
# npm install        # for Node.js
# dotnet restore     # for .NET
# pip install -r requirements.txt  # for Python

# Copy environment variables
cp .env.example .env
# Edit .env with your configuration

# Start development
# npm run dev        # for Node.js
# dotnet watch       # for .NET
# docker compose up  # for Docker
```

## Development

```bash
# Run tests
npm test

# Lint code
npm run lint

# Format code
npm run format
```

## Project Structure

```
├── AGENTS.md           # AI agent instructions
├── CLAUDE.md           # Claude-specific config
├── AI_CONTEXT.md       # Project context summary
├── docs/               # Documentation & ADRs
├── rules/              # Role-based agent skill files
├── .github/workflows/  # CI/CD pipelines
└── src/                # Source code
```

## Next Steps

- Read `docs/agentic-sdlc.md` for the autonomous development workflow
- Read `AGENTS.md` for AI agent instructions
- Configure your editor with the `.editorconfig` and `.cursorrules`
- Set up GitHub repository secrets for CI/CD
