---
applyTo: "**/*.{cs,py,go,rs,java,ts,js}"
---

# Backend and service instructions

These are adaptable defaults. Follow the repository's established stack and root `AGENTS.md`; do not apply language-specific assumptions to unrelated files.

- Keep transport, domain logic, persistence and external integrations separated according to the existing architecture.
- Validate inputs at trust boundaries and enforce authentication/authorisation server-side.
- Use parameterised queries and established ORM/query patterns; do not concatenate untrusted input into commands or queries.
- Apply timeouts, cancellation, bounded retries and idempotency where relevant to remote calls.
- Avoid logging credentials, tokens, sensitive payloads or unnecessary personal data.
- Return stable, documented errors; do not leak stack traces or internal implementation details to clients.
- Add tests for normal, boundary, failure and unauthorised cases.
- Update API contracts, schemas, migration and rollback guidance when relevant.
- Do not introduce a framework or dependency without a concrete need and review of maintenance/security impact.
