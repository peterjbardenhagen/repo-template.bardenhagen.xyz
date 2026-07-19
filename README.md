# Perfect Repo Template — AI Agentic SDLC Starter

**Version:** 1.0.0

> A comprehensive, opinionated starter template for modern software projects that leverages AI agents throughout the Software Development Lifecycle. Every file, rule, and workflow is designed to make AI coding tools (Claude Code, Codex, Cursor, Windsurf, GitHub Copilot) maximally effective from the first keystroke.

## What's Included

### 🧠 AI Agent Configuration
| File | What It Does |
|------|-------------|
| `AGENTS.md` | Master instructions for all AI coding agents |
| `CLAUDE.md` | Claude Code/CLI-specific configuration |
| `CODEX.md` | OpenCode/Codex-specific instructions |
| `COPILOT_INSTRUCTIONS.md` | GitHub Copilot context |
| `AI_CONTEXT.md` | One-page project summary for fast AI orientation |
| `.cursorrules` | Cursor editor AI rules |
| `.windsurfrules` | Windsurf editor AI rules |

### 📋 Role-Based Agent Skills (`rules/`)
| Rule File | Agent Role |
|-----------|-----------|
| `01-architect.md` | System architecture & design decisions |
| `02-coder.md` | Implementation & feature development |
| `03-reviewer.md` | Code review & quality assurance |
| `04-tester.md` | Testing strategy & test automation |
| `05-devops.md` | Infrastructure, CI/CD & deployment |

### 🔄 GitHub Integration
- **CI/CD workflows** — `.github/workflows/ci.yml`, `codeql-analysis.yml`, `auto-assign.yml`
- **Issue templates** — Bug reports, feature requests
- **PR template** — Structured pull request descriptions
- **Dependabot** — Automated dependency updates
- **CODEOWNERS** — Code ownership & review routing

### 📐 Developer Tooling
- `.editorconfig` — Cross-editor consistency
- `.gitattributes` — Git normalization & diff settings
- `.gitignore` — Comprehensive ignore patterns
- `.env.example` — Documented environment variables
- `.prettierrc` — Code formatting
- `docker-compose.yml` — Development environment

### 📚 Documentation
- `docs/agentic-sdlc.md` — The Autonomous Development Lifecycle protocol
- `docs/architecture.md` — Architecture documentation template
- `docs/decisions/` — Architecture Decision Records (ADRs)
- `docs/getting-started.md` — Quick start guide template
- `CHANGELOG.md` — Version history & release notes

### 🚀 Automation
- `scripts/init-project.sh` — Initialize a new project from this template
- `scripts/propagate-template.sh` — Propagate template updates to downstream repos

## AI Agentic SDLC Workflow

```
┌─────────────┐    ┌──────────┐    ┌─────────┐    ┌────────┐    ┌──────────┐
│  README &   │───▶│Git Pull  │───▶│  Do     │───▶│ Run    │───▶│  Commit  │
│  Context    │    │--ff-only │    │  Work   │    │ Tests  │    │  & Push  │
└─────────────┘    └──────────┘    └─────────┘    └────────┘    └──────────┘
       ▲                                                            │
       └───────────────────────── Loop ─────────────────────────────┘
```

## Quick Start

```bash
# Use this template from GitHub
# Option 1: "Use this template" button on GitHub
# Option 2: Clone and reset
git clone https://github.com/peterjbardenhagen/perfect-repo-template-pjb.git my-new-project
cd my-new-project
rm -rf .git && git init && git add -A && git commit -m "chore: initialise from perfect-repo-template"
```

## How to Propagate Updates

This template is designed to be kept in sync across all your projects. See `scripts/propagate-template.sh` for the propagation workflow. A nightly cron job handles research, enhancement, iteration, and propagation automatically.

## Version History

See `CHANGELOG.md` for the full version history and release notes.

## License

MIT — see `LICENSE`.
