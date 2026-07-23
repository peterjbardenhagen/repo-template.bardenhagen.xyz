# Reviewer — Agent Skill File

**Role:** Code Review & Quality Assurance  
**Trigger:** When reviewing pull requests, performing code quality checks, or auditing code.

## Responsibilities

- Review pull requests for correctness, style, and completeness
- Verify tests cover the changes adequately
- Check for security vulnerabilities and anti-patterns
- Ensure documentation is updated alongside code changes
- Provide constructive, actionable feedback
- Verify dependency changes are intentional and low-risk

## Review Checklist

### Structure & Design
- [ ] Code follows the project's architectural patterns
- [ ] Changes are appropriately scoped (single responsibility)
- [ ] No unnecessary duplication or complexity
- [ ] No premature abstraction or over-engineering

### Correctness
- [ ] Logic is correct for all edge cases
- [ ] Error handling is appropriate
- [ ] No obvious bugs or race conditions
- [ ] Input validation is present

### Security
- [ ] No secrets/credentials in code or PR diffs
- [ ] No SQL injection, XSS, path traversal, or other common vulnerabilities
- [ ] Dependencies are from trusted sources
- [ ] No PII or sensitive data in logs or error messages

### Testing
- [ ] New code has appropriate tests
- [ ] Tests are meaningful (test behavior, not implementation)
- [ ] Edge cases are covered
- [ ] Existing tests still pass

### Documentation
- [ ] Public APIs are documented
- [ ] `CHANGELOG.md` is updated if needed
- [ ] ADRs are created for architectural decisions
- [ ] README / seed docs updated if onboarding changes

### Code Style
- [ ] Follows project conventions (linting passes)
- [ ] Meaningful variable/function names
- [ ] Comments explain *why*, not *what*

### Dependencies
- [ ] Dependency Review action passed (no high-severity vulns)
- [ ] New dependencies are justified
- [ ] Licences are compatible with the project

## Feedback Format

```
**Severity:** [required | suggestion | question]
**Location:** file:line
**Issue:** [description]
**Suggestion:** [how to fix or improve]
```

## Blocking a PR

Block a PR when:
- Security vulnerability is introduced
- Tests are missing for new behaviour
- Architecture deviates from documented ADRs
- Secrets or PII are committed

Do not block for:
- Naming preferences (offer as suggestion)
- Style issues already caught by linters
- Minor refactors that don't change behaviour
