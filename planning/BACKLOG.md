# Backlog

## Current Sprint (Phase 2)

### 🔴 Critical
- [ ] Rotate all committed secrets (CF tunnel token, Neo4j creds, .env)
- [ ] Stand up PostgreSQL, migrate in-memory _projects/_ledger dicts
- [ ] Add JWT middleware for API auth
- [ ] Add .gitignore entries for secrets and build artifacts

### 🟡 High
- [ ] Implement Redis-backed durable task queue
- [ ] Wire Neo4j activity ledger writes
- [ ] Add API versioning (/v1/)
- [ ] Define RBAC roles and policies
- [ ] Implement schema-per-tenant isolation

### 🟢 Medium
- [ ] Add tenant creation API
- [ ] Add API key management
- [ ] Document deployment runbook
- [ ] Update CHANGELOG.md

## Next Sprint (Phase 2 cont.)
- [ ] OpenAPI spec generation
- [ ] Rate limiting via Traefik
- [ ] Health check endpoints
- [ ] Backup/restore scripts

## Backlog (Phase 3+)
- [ ] Hermes v2: LLM-native hierarchical planner
- [ ] OpenClaw v2: Sandboxed step executor
- [ ] Evolution wiring: completed-PDO → GeneticEngine
- [ ] QueueAdapter interface with Redis Streams implementation
- [ ] Formal task lifecycle state machine
- [ ] Provenance-gated execution (hash-chained ledger)
- [ ] Grafana dashboards
- [ ] Prometheus metrics
- [ ] Structured JSON logging
- [ ] SOC 2 compliance
- [ ] SSO/SAML integration
- [ ] On-prem appliance packaging
- [ ] Android bridge app

## Marketing Site
- [ ] Connect form to email service (SendGrid/Mailgun)
- [ ] Add real images and logo assets
- [ ] Add customer testimonials section
- [ ] Implement dark mode toggle
- [ ] Add video demo section

## Removed (not applicable)

The prior backlog listed generic AgentsOS items: PostgreSQL/Neo4j/Redis persistence, JWT auth middleware, multi-tenant schema isolation, SSO/SAML, RBAC, API versioning `/v1/`, OpenAPI spec, rate limiting, Android bridge, SOC 2. **None apply to this repository.** They belong to the AgentsOS repository.

- [~] Rotate all committed secrets (CF tunnel token, Neo4j creds, .env) — not applicable
- [~] Stand up PostgreSQL, migrate in-memory _projects/_ledger dicts — not applicable
- [~] Add JWT middleware for API auth — not applicable
- [~] Add .gitignore entries for secrets and build artifacts — not applicable
- [~] Implement Redis-backed durable task queue — not applicable
- [~] Wire Neo4j activity ledger writes — not applicable
- [~] Add API versioning (/v1/) — not applicable
- [~] Define RBAC roles and policies — not applicable
- [~] Implement schema-per-tenant isolation — not applicable
- [~] Add tenant creation API — not applicable
- [~] Add API key management — not applicable
- [~] Document deployment runbook — not applicable
- [~] Update CHANGELOG.md — not applicable
- [~] OpenAPI spec generation — not applicable
- [~] Rate limiting via Traefik — not applicable
- [~] Health check endpoints — not applicable
- [~] Backup/restore scripts — not applicable
- [~] Hermes v2: LLM-native hierarchical planner — not applicable
- [~] OpenClaw v2: Sandboxed step executor — not applicable
- [~] Evolution wiring: completed-PDO → GeneticEngine — not applicable
- [~] QueueAdapter interface with Redis Streams implementation — not applicable
- [~] Formal task lifecycle state machine — not applicable
- [~] Provenance-gated execution (hash-chained ledger) — not applicable
- [~] Grafana dashboards — not applicable
- [~] Prometheus metrics — not applicable
- [~] Structured JSON logging — not applicable
- [~] SOC 2 compliance — not applicable
- [~] SSO/SAML integration — not applicable
- [~] On-prem appliance packaging — not applicable
- [~] Android bridge app — not applicable
- [~] Connect form to email service (SendGrid/Mailgun) — not applicable
- [~] Add real images and logo assets — not applicable
- [~] Add customer testimonials section — not applicable
- [~] Implement dark mode toggle — not applicable
- [~] Add video demo section — not applicable
