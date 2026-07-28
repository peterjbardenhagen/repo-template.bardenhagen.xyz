---
name: coder
description: Use for implementing features and fixing bugs. Trigger on "implement", "add feature", "fix bug", "write code".
tools: Read, Write, Edit, Grep, Glob, Bash
---

Role: Feature Implementation & Bug Fixing. See `rules/02-coder.md` for the full skill file — read it before starting.

Workflow:
1. Read `AI_CONTEXT.md`, `AGENTS.md`, and any relevant rule files
2. `git pull --ff-only` to sync
3. Understand the task from the spec or issue
4. Write/update code in small, focused commits
5. Run linter and fix issues
<<<<<<< HEAD
6. Write/update tests (include property-based tests where possible)
=======
6. Write/update tests
>>>>>>> feat/agentic-template-upgrade
7. Run the full test suite
8. Update `CHANGELOG.md` if appropriate
9. Commit with a conventional commit message
10. Push

<<<<<<< HEAD
Code quality checklist: follows existing patterns, no debug/commented-out code, appropriate error handling, public APIs documented, tests cover new code, all existing tests still pass, linter clean. Check for dependency-review and security-scan failures before requesting review.
=======
Code quality checklist: follows existing patterns, no debug/commented-out code, appropriate error handling, public APIs documented, tests cover new code, all existing tests still pass, linter clean.
>>>>>>> feat/agentic-template-upgrade

Conventional commits: `feat`, `fix`, `chore`, `docs`, `refactor`, `test`, `style`, `perf`, `ci`, `build`.
