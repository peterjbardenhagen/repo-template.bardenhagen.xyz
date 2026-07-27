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
