# Getting Started

> *Replace with your project's actual getting-started guide.*

Welcome to your new project! This guide will help you get up and running quickly.

## Prerequisites

- [ ] Git
- [ ] [Language/Framework runtime] (e.g., Node.js 20+, .NET 10, Python 3.11+)
- [ ] [Package manager] (e.g., npm, dotnet, pip)
- [ ] Docker (optional, for containerized development)

## Option 1: Use This Template (Recommended)

```bash
# On GitHub, click "Use this template" to create a new repo, then:
git clone https://github.com/<your-org>/<your-repo>.git
cd <your-repo>
```

## Option 2: Clone and Reset

```bash
git clone https://github.com/peterjbardenhagen/repo-template.bardenhagen.xyz.git my-new-project
cd my-new-project
rm -rf .git && git init && git add -A && git commit -m "chore: initialise from repo-template"
```

## Option 3: Init Script

```bash
bash scripts/init-project.sh my-new-project
```

## Setup

```bash
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

## GitHub Setup

1. Push to your new GitHub repository
2. Copy the required secrets under Settings → Secrets and variables → Actions:
   - `VERCEL_TOKEN` — for Vercel preview/production deploys
   - `VERCEL_ORG_ID` — your Vercel team or personal org ID
   - `VERCEL_PROJECT_ID` — the Vercel project ID
3. Configure branch protection on `main`:
   - Require PR before merging
   - Require status checks (CI, CodeQL, Dependency Review)
   - Require linear history (squash merge)

## Vercel Setup

1. Import your repository into Vercel
2. Link it to the repo URL
3. Configure environment variables in Vercel dashboard
4. Push a feature branch to test preview deployments

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
├── scripts/            # Automation scripts
├── seeds/              # Project type starter kits
└── src/                # Source code
```

## Next Steps

- Read `docs/agentic-sdlc.md` for the autonomous development workflow
- Read `AGENTS.md` for AI agent instructions
- Configure your editor with the `.editorconfig` and `.cursorrules`
- Set up GitHub repository secrets for CI/CD
- Explore the seed for your stack in `seeds/`
