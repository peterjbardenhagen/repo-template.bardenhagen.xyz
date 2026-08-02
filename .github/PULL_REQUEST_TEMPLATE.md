## Description

<!-- Briefly describe what this PR does -->

## Type of Change

- [ ] feat: New feature
- [ ] fix: Bug fix
- [ ] docs: Documentation only
- [ ] refactor: Code change that neither fixes nor adds
- [ ] test: Adding tests
- [ ] chore: Maintenance, dependencies, CI
- [ ] style: Formatting only

## Does this build what was asked?

<!--
The one question CI cannot answer. Correct code solving the wrong problem is a
total loss. See rules/07-analyst.md.
-->

**Original request:** <!-- link the issue, or quote the ask in one line -->

**Acceptance criteria and how each was verified:**
<!-- e.g. "Signed-out user redirected to /login — checked manually at 320px and 1440px" -->
- [ ]
- [ ]

- [ ] Nothing in the original request was silently dropped
- [ ] Nothing unrequested was added (or, if it was, it is called out below)
- [ ] Assumptions I made are stated, including any that turned out wrong
- [ ] Gaps and known limitations are stated plainly, not omitted

**Scope changes, assumptions, or gaps:** <!-- "none" is a valid answer -->

## Testing

<!-- Describe how you tested these changes -->

- [ ] All existing tests pass
- [ ] New tests added for changes
- [ ] Lint passes

## User-facing changes

<!-- Delete this section if the change has no user-visible surface. See rules/06-ux.md. -->

- [ ] All five states handled: empty, loading, partial, error, success
- [ ] Errors say what went wrong **and** what to do next, in plain language
- [ ] Keyboard-only navigation works; focus is visible
- [ ] Contrast meets WCAG AA (4.5:1 body, 3:1 large text and UI boundaries)
- [ ] No horizontal scroll at 320px; tap targets ≥ 44×44px; text ≥ 16px
- [ ] Checked on a real device, not only a devtools emulator

## Documentation

- [ ] CHANGELOG.md updated
- [ ] ADR created/updated (if architectural decision)
- [ ] README/docs updated (if user-facing change)

## Checklist

- [ ] I have read AGENTS.md
- [ ] Code follows project conventions
- [ ] No secrets/credentials in code
- [ ] Environment variables documented in .env.example (if new)
