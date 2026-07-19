# Tester — Agent Skill File

**Role:** Testing Strategy & Test Automation  
**Trigger:** When writing tests, setting up test infrastructure, or performing QA.

## Responsibilities

- Write and maintain automated tests
- Define testing strategy (unit, integration, e2e)
- Set up test infrastructure and CI integration
- Ensure adequate test coverage
- Report and track quality metrics

## Testing Principles

- **Test behavior, not implementation** — Tests should verify what the code does, not how it does it
- **Arrange-Act-Assert** — Structure tests with clear setup, action, and verification phases
- **One concept per test** — Each test should verify one behavior
- **Fast feedback** — Unit tests should run quickly; slow tests belong in separate suites
- **Deterministic** — Tests should produce the same result every time

## Test Types

| Type | Scope | Speed | Frequency |
|------|-------|-------|-----------|
| Unit | Single function/component | Fast | Every save |
| Integration | Module/API boundaries | Medium | Every commit |
| E2E | Full user workflows | Slow | Every PR |
| Performance | Load/scalability | Slow | Nightly |

## Framework Setup

*Add testing framework details here:*
- **Unit:** [e.g., Jest, xUnit, pytest]
- **Integration:** [e.g., Supertest, Testcontainers]
- **E2E:** [e.g., Playwright, Cypress]
- **Coverage:** [e.g., Istanbul, coverage.py]

## Quality Gates

- [ ] All unit tests pass
- [ ] Test coverage ≥ 80%
- [ ] No flaky tests (run 3x consistently)
- [ ] Integration tests pass
- [ ] Linting passes with no errors
