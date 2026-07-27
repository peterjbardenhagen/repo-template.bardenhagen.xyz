# AgentsOS Development Phases

## Phase 1: Foundation Hardening (v3.1) ✅

**Status:** Complete — all acceptance criteria met.

### Acceptance Criteria
- [x] Control Plane API serves routes on port 8080
- [x] DAG Engine executes tasks with dependency resolution
- [x] PDO models validated via Pydantic
- [x] Master Orchestrator creates plans from briefs
- [x] Evolution Engine runs genetic optimization on DAGs
- [x] Frontend (Next.js) renders dashboard
- [x] Docker Compose stack runs all 15 services
- [x] 9Router gateway routes model calls
- [x] 5 codebase duplicates archived
- [x] 80+ tests passing

### Tech Stack
- Python FastAPI (Control Plane)
- Next.js + Tailwind + D3.js (Frontend)
- Docker Compose (Infrastructure)
- Ollama (Local GPU inference)
- 9Router (AI Gateway)
- Qdrant (Vector DB), Neo4j (Graph DB), Redis (Cache)

---

## Phase 2: Persistence & Auth (v3.2) 🔄

**Status:** In Progress — priority work for any external pilot.

### Acceptance Criteria
- [ ] All in-memory state migrated to PostgreSQL
- [ ] JWT auth middleware rejecting unauthenticated requests
- [ ] Tenant isolation enforced on all queries
- [ ] No hardcoded secrets in docker-compose or .env
- [ ] Redis-backed durable task queue operational
- [ ] Neo4j activity ledger recording all task executions
- [ ] API routes versioned under /v1/
- [ ] RBAC with min 3 roles (admin, operator, viewer)

### Database Schema (Target)
- `tenants` — multi-tenant orgs
- `projects` — PDO definitions
- `tasks` — DAG task nodes with state machine
- `activity_ledger` — append-only execution log
- `users` — auth + role assignments

### Breaking Changes
- All API routes move from `/...` to `/v1/...`
- In-memory `_projects`/`_ledger` dicts removed
- `.env` format changes to remove secrets

---

## Phase 3: Orchestrator v2 (v4.0) 📋

**Status:** Planned — builds on Phase 2 persistence.

### Key Deliverables
| Component | Description |
|-----------|-------------|
| Hermes v2 | LLM-native hierarchical planner. Schema-validated PDO output. Seeds from evolutionary history. |
| OpenClaw v2 | Sandboxed step executor. Fixed primitive set. Hash-chained provenance ledger. Acceptance-criteria review. |
| Queue Layer | Redis Streams with consumer groups. At-least-once delivery. Idempotency keys. |
| State Machine | Formal lifecycle: queued→dispatched→running→checkpoint→completed→failed/retrying |
| Evolution Loop | Completed-PDO fitness feeds per-tenant GeneticEngine population. get_best() seeds new briefs. |

### Architecture Change
```
Before: Hermes (static planner) → HTTP poll → worker → in-memory state
After:  Planner → Scheduler → Redis Streams → OpenClaw Executor → Neo4j Ledger → Postgres state
```

---

## Phase 4: Monitoring (v4.1)

| Feature | Description |
|---------|-------------|
| Grafana dashboards | Token usage, latency, GPU/CPU/memory, agent activity |
| Prometheus metrics | /metrics endpoint on all services |
| Structured logging | JSON logs with correlation IDs across all services |
| Alerting | Slack webhooks for failed DAGs, agent offline, backpressure |

## Phase 5: Enterprise (v4.2)

| Feature | Description |
|---------|-------------|
| SOC 2 compliance | Access controls, audit logs, data retention |
| Multi-tenant isolation | Per-org data, model, queue separation |
| SSO/SAML | Okta, Azure AD, Google Workspace |
| On-prem appliance | Air-gapped deployment, USB key install |

## Phase 6: Verticals (v4.3+)

| Vertical | Key Features |
|----------|-------------|
| Legal (AU) | Australian Consumer Law, QLD Legal Practice Act templates |
| Financial | SOX compliance, reconciliation, AML checks |
| Healthcare | HIPAA, PHI handling, medical coding |
| Government | IRAP, PROTECTED, air-gapped |
