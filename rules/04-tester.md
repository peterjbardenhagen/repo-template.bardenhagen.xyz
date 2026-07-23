# Tester — Agent Skill File

**Role:** Testing Strategy & Test Automation  
**Trigger:** When writing tests, setting up test infrastructure, or performing QA.

## Responsibilities

- Write and maintain automated tests
- Define testing strategy (unit, integration, e2e)
- Set up test infrastructure and CI integration
- Ensure adequate test coverage
- Report and track quality metrics
- Integrate property-based testing where applicable

## Testing Principles

- **Test behavior, not implementation** — Tests should verify what the code does, not how it does it
- **Arrange-Act-Assert** — Structure tests with clear setup, action, and verification phases
- **One concept per test** — Each test should verify one behavior
- **Fast feedback** — Unit tests should run quickly; slow tests belong in separate suites
- **Deterministic** — Tests should produce the same result every time
- **Test the edge cases first** — Boundary conditions reveal more bugs than happy paths

## Test Types

| Type | Scope | Speed | Frequency |
|------|-------|-------|-----------|
| Unit | Single function/component | Fast | Every save |
| Integration | Module/API boundaries | Medium | Every commit |
| E2E | Full user workflows | Slow | Every PR |
| Property | Invariants across inputs | Medium | Nightly / CI |
| Performance | Load/scalability | Slow | Nightly |
| Chaos | Resilience under failure | Slow | Weekly |

## Property-Based Testing (2026 Best Practice)

Use property-based testing to find edge cases that example-based tests miss. Libraries by ecosystem:
- **JavaScript/TypeScript:** `fast-check` — already supports generative testing with shrinking
- **Python:** `hypothesis` — industry standard for property-based testing
- **C#:** `FsCheck` or `FastCheck.Net`
- **Go:** `rapid` (from uber-go)

Example approach:
1. Define a property (invariant) that must hold for any input
2. Generate hundreds of random inputs
3. When a failure is found, shrink to the smallest counterexample
4. Add the failing case as a regression test

## Framework Setup

*Add testing framework details here:*
- **Unit:** [e.g., Jest, xUnit, pytest]
- **Integration:** [e.g., Supertest, Testcontainers]
- **E2E:** [e.g., Playwright, Cypress]
- **Property:** [e.g., fast-check, hypothesis]
- **Coverage:** [e.g., Istanbul, coverage.py]

## Quality Gates

- [ ] All unit tests pass
- [ ] Test coverage ≥ 80%
- [ ] No flaky tests (run 3x consistently)
- [ ] Integration tests pass
- [ ] Linting passes with no errors
- [ ] Property-based test suites pass (if configured)
