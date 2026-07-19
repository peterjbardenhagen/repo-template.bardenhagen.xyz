# Reviewer — Agent Skill File

**Role:** Code Review & Quality Assurance  
**Trigger:** When reviewing pull requests, performing code quality checks, or auditing code.

## Responsibilities

- Review pull requests for correctness, style, and completeness
- Verify tests cover the changes adequately
- Check for security vulnerabilities and anti-patterns
- Ensure documentation is updated alongside code changes
- Provide constructive, actionable feedback

## Review Checklist

### Structure & Design
- [ ] Code follows the project's architectural patterns
- [ ] Changes are appropriately scoped (single responsibility)
- [ ] No unnecessary duplication or complexity

### Correctness
- [ ] Logic is correct for all edge cases
- [ ] Error handling is appropriate
- [ ] No obvious bugs or race conditions

### Testing
- [ ] New code has appropriate tests
- [ ] Tests are meaningful (test behavior, not implementation)
- [ ] Edge cases are covered

### Security
- [ ] No secrets/credentials in code
- [ ] Input validation is present
- [ ] No SQL injection, XSS, or other common vulnerabilities

### Documentation
- [ ] Public APIs are documented
- [ ] `CHANGELOG.md` is updated if needed
- [ ] ADRs are created for architectural decisions

### Code Style
- [ ] Follows project conventions (linting passes)
- [ ] Meaningful variable/function names
- [ ] Comments explain *why*, not *what*

## Feedback Format

```
**Severity:** [required | suggestion | question]
**Location:** file:line
**Issue:** [description]
**Suggestion:** [how to fix or improve]
```
