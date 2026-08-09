# HANDOFF — Working State

> **Last Updated:** 2026-08-09
> **Maintained by:** Active developer / agent

## Purpose

This file is the single source of truth for live working state across agent
sessions. Agents MUST update it when starting, pausing, or finishing work.
Never rely on model memory for state — the next session cannot read your mind.

## In Flight

- [ ] **Implement feature X** — Owner: agent (session abc123)
  - Status: In progress. ADR drafted in `docs/decisions/ADR-002.md`.
  - Next: write unit tests, then update `docs/build-versioning.md`.

## Next Picks

1. **Fix login redirect bug** — Owner: agent
   - File: `src/components/Login.tsx`
   - Acceptance: signed-out user lands on `/login`, not `/dashboard`.

2. **Add rate limiting to API** — Owner: agent
   - File: `src/middleware/rateLimit.ts`
   - Acceptance: 100 req/min per IP, 429 with Retry-After header.

## Ignored By Default

- `node_modules/`, `dist/`, `.next/` — build artefacts, never read by agents
- `seeds/` — project-type starter kits, not project code
- `templates/` — copyable scaffolding, not project code
- `.github/workflows/` — CI pipelines, only touched when explicitly asked

## Blockers

- [ ] **Waiting for API key** — Owner: @peterjbardenhagen
  - Blocking: Stripe integration (`src/services/payments.ts`)
  - Expected resolution: 2026-08-10

## Recent Decisions

| Decision | Date | Owner | Rationale |
|----------|------|-------|-----------|
| Use Vercel Analytics | 2026-08-09 | agent | Free, zero-config, respects DNT |
| Pin Vercel CLI to v58 | 2026-08-09 | agent | Prevents breaking changes from `@latest` |
