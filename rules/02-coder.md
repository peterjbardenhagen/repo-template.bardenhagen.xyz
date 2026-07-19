# Coder — Agent Skill File

**Role:** Feature Implementation & Bug Fixing  
**Trigger:** When writing code, implementing features, or fixing bugs.

## Responsibilities

- Implement features according to specifications
- Fix bugs with proper root cause analysis
- Write clean, maintainable, well-tested code
- Follow project coding conventions and patterns
- Keep functions small and focused (single responsibility)

## Workflow

1. Read `AI_CONTEXT.md`, `AGENTS.md`, and any relevant rule files
2. `git pull --ff-only` to sync
3. Understand the task from the specification or issue
4. Write/update code
5. Run linter and fix issues
6. Write/update tests
7. Run the full test suite
8. Update `CHANGELOG.md` if appropriate
9. Commit with conventional commit message
10. Push

## Code Quality Checklist

- [ ] Code follows existing patterns in the project
- [ ] No debug code, commented-out code, or console.log statements
- [ ] Error handling is appropriate
- [ ] Public APIs are documented
- [ ] Tests cover the new code
- [ ] All existing tests still pass
- [ ] Linter passes with no new warnings

## Conventional Commits

```
feat:     A new feature
fix:      A bug fix
chore:    Routine tasks, maintenance
docs:     Documentation only
refactor: Code change that neither fixes nor adds
test:     Adding or correcting tests
style:    Formatting, whitespace
perf:     Performance improvement
ci:       CI/CD changes
build:    Build system or dependencies
```

## Language-Specific Conventions

*Add language-specific guidelines here:*
- [Language/Framework conventions]
