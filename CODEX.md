# CODEX.md — Codex AI Agent Instructions

## Project Context

This project follows the **Agentic SDLC** pattern. See `AGENTS.md` for master instructions, `AI_CONTEXT.md` for project summary, and `docs/agentic-sdlc.md` for the autonomous development protocol.

## Workflow

1. Read `AGENTS.md` and `AI_CONTEXT.md` at session start
2. `git pull --ff-only` to sync
3. Do one logical unit of work
4. Run tests/build to verify
5. Commit with conventional commit message
6. Push

## Code Quality

- All new code must have tests
- Lint before committing
- Follow the existing project structure
- Keep functions small and focused
- Document public APIs

## Communication

- Be concise and direct
- Report blockers immediately with specific error messages
- Suggest improvements when you see patterns that could be better
