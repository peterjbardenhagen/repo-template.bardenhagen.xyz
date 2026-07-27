# AgentsOS Architecture Decisions

## ADR Process

Each major technical decision documented as:
```
ADR #XXX: [Title]
Status: [Proposed/Accepted/Deprecated/Superseded]
Date: [YYYY-MM-DD]
Context: [Problem statement and constraints]
Decision: [What was decided]
Rationale: [Why this decision was made]
Consequences: [Positive and negative impacts]
```

---

## ADR-001: Single Canonical Backend (control-plane/app)

**Status:** Accepted  
**Date:** 2026-07-01

**Context:** Five parallel DAG/API/memory implementations existed across `apps/`, `backend/app/`, `control-plane/app/`, `core/`, `runtime/`, `stack/`. Duplication caused confusion and wasted effort.

**Decision:** `control-plane/app` becomes the single canonical backend. All others archived to `/archive/`.

**Rationale:** control-plane/app is smallest, cleanest, and already wired into docker-compose.yml as the Control Plane service.

**Consequences:** + Consolidation ended duplication. - Some module migration needed (evolution engine, memory modules).

---

## ADR-002: Local-First with Governed Cloud Burst

**Status:** Accepted  
**Date:** 2026-07-01

**Context:** Need sovereignty story for regulated verticals (legal, finance, government). Cloud-only approach disqualifying for these buyers.

**Decision:** Ollama for local GPU inference; 9Router for cloud fallback. Model Manager enforces routing policy per-tenant.

**Rationale:** Differentiated position vs cloud-only competitors. Meets Australian legal vertical data-sovereignty requirements.

**Consequences:** + Strong compliance story. - Dual model pipeline maintenance. GPU hardware required for local tier.

---

## ADR-003: Python FastAPI for Control Plane

**Status:** Accepted  
**Date:** 2026-06-01

**Context:** Need async-capable framework for AI orchestration with WebSocket support, task queue integration, and ML library compatibility.

**Decision:** Python FastAPI with async workers.

**Rationale:** Native async, Pydantic validation, OpenAPI generation, strong ML ecosystem (LangChain, transformers, etc.).

**Consequences:** + Rapid development, excellent docs. - Python GIL limits CPU-bound parallelism; mitigated via async + separate worker processes.

---

## ADR-004: Redis Streams for Durable Task Queue

**Status:** Proposed  
**Date:** 2026-07-23

**Context:** Current HTTP-polled task queue loses state on restart, has no delivery guarantees. Need durable queue for enterprise SLA.

**Decision:** Redis Streams with consumer groups. QueueAdapter interface for future Temporal migration.

**Rationale:** Redis already in stack. Streams + consumer groups provide at-least-once delivery, acknowledgment, replay. Lighter than Celery or Temporal for current scale.

**Consequences:** + Durable dispatch with existing dependency. - Must implement QueueAdapter abstraction layer.

---

## ADR-005: Provenance-Gated Execution

**Status:** Accepted  
**Date:** 2026-07-01

**Context:** Agents could report completion without verifiable proof. Audit trail needed for regulated verticals.

**Decision:** No ledger entry = no credit. OpenClaw writes hash-chained provenance to Neo4j as atomic final step of each task.

**Rationale:** Audit trail is the primary enterprise moat. Regulated buyers pay for verifiability.

**Consequences:** + Strong compliance narrative. - Two-phase commit for task completion (execution + ledger write).

---

## ADR-006: Multi-Tenant via Schema-Per-Tenant

**Status:** Proposed  
**Date:** 2026-07-23

**Context:** Phase 2 requires tenant isolation. Options: database-per-tenant, schema-per-tenant, row-level TenantId.

**Decision:** Schema-per-tenant with TenantId on all tables. Documented migration path to database-per-tenant.

**Rationale:** Simpler ops than database-per-tenant at current scale. Data boundary clearer than pure row-level isolation.

**Consequences:** + Simple backup/restore per tenant. - Migration path must be planned if regulated customer demands physical separation.

---

## ADR-007: Open Source Core, Paid Product on Top

**Status:** Accepted  
**Date:** 2026-07-01

**Context:** Need community adoption + revenue. Pure open source doesn't pay; pure proprietary doesn't get developer mindshare.

**Decision:** AgentsOS runtime (scheduler, executor, DAG/evolution, MCP) source-available/open-core. MyDesk is the paid product.

**Rationale:** Open-core builds trust and tool connectors. MyDesk per-seat pricing with vertical premium (Legal).

**Consequences:** + Community growth. - Must maintain clear boundary between core and paid features.

---

*See `docs/decisions/` for ADR templates and `docs/decisions/ADR-001-record-architecture-decisions.md` for the original ADR setup.*
