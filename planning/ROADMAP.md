# AgentsOS Product Roadmap

**Last Updated:** July 27, 2026  
**Current Version:** v3.2 — Conductor Integration (Smart Router + Dynamic Complexity + Self-Corrective Loop + 9router + RL Feedback)  
**Next Version:** v3.3 — Vertical Accelerators  
**Site:** https://agentsos.digitalresponse.com.au

---

## Phase Overview

| Phase | Version | Status | Timeline | Key Features |
|-------|---------|--------|----------|--------------|
| **Phase 1** | v3.1 | ✅ Complete | Q2-Q3 2026 | Control Plane, DAG Engine, Evolution, Frontend, Docker stack, 9Router integration, codebase consolidation |
| **Phase 2** | v3.2 | ✅ Complete | Q3 2026 | Postgres persistence, JWT auth, secrets rotation, durable task queue, activity ledger |
| **Phase 3** | v3.2+ | ✅ Complete | Q3 2026 | OIDC SSO, multi-tenant SaaS, Stripe billing, legal vertical accelerator, per-tenant evolution isolation |
| **Phase 5** | v3.2+ | ✅ Complete | Q3 2026 | **Conductor Integration**: Smart Router, Dynamic Complexity, Self-Corrective Loop, 9router Integration, RL Feedback Loop |
| **Phase 4** | v4.0 | 📋 Planned | Q4 2026 | Hermes v2 Orchestrator, OpenClaw v2 Executor, evolution wiring, state machine, provenance-gated execution |
| **Phase 6** | v4.1 | 📋 Planned | Q4 2026 | Grafana dashboards, Prometheus metrics, structured logging, alerting |
| **Phase 7** | v4.2 | 📋 Planned | Q1 2027 | SOC 2, multi-tenant isolation, SSO/SAML, on-prem appliance |
| **Phase 8** | v4.3+ | 📋 Planned | Rolling | Legal, Financial, Healthcare, Government verticals |

---

## Phase 1: Foundation Hardening ✅ (v3.1)

**Timeline:** Q2-Q3 2026 — Complete

### Delivered
- Control Plane (Python FastAPI) — 80 tests passing
- DAG Engine with async task lifecycle
- PDO Models (Scope, Risk, Epic, TaskNode, ResourcePlan)
- Master Orchestrator — planning to execution loop
- Evolution Engine — DAGGenome, fitness scoring, genetic optimization
- Event Bus — async pub/sub
- Frontend (Next.js + Tailwind + D3.js)
- Docker Compose full stack (15 services)
- 9Router AI Gateway integration
- 8 9Router Hermes skills installed
- 5 codebase duplicates consolidated to archive
- Production fixes applied

### Marketing Site Deployed
- agentsos.digitalresponse.com.au
- Static HTML/CSS/JS — Vercel
- Pages: Home, Pricing, Docs, Blog
- CI/CD via GitHub Actions

---

## Phase 5: Conductor Integration ✅ (v3.2+)

**Completed:** July 27, 2026
**Inspired by:** Sakana AI Conductor (ICLR 2026) — learning to orchestrate via RL

### Delivered (S5.1-S5.5)

| Sprint | Feature | Files | Status |
|--------|---------|-------|--------|
| **S5.1** | Smart Router — task-level model selection | `orchestrator/smart_router.py`, `api/routes_smart_router.py` | ✅ |
| **S5.2** | Dynamic Complexity — skip pipeline for simple tasks | `orchestrator/master_orchestrator.py` (fast-track) | ✅ |
| **S5.3** | Self-Corrective Loop — output verification + retry | `orchestrator/verifier.py` | ✅ |
| **S5.4** | 9router Integration — gateway as model backend | `dag/engine.py` (9router-first execution) | ✅ |
| **S5.5** | RL Feedback Loop — evolve routing strategies | `orchestrator/feedback_loop.py` | ✅ |

### Architecture

```
Task Input → Complexity Classifier → Smart Router → 9router dispatch
                                        ↓
                            [Simple/Trivial] → Fast Track (bypass DAG)
                            [Complex] → Full DAG Pipeline
                                        ↓
                                  Task Execution
                                        ↓
                                  Verifier → [PASS] → Done
                                        ↓ [FAIL]
                                  Corrective Router → Retry/Escalate/Human
                                        ↓
                                  Feedback Loop → Strategy Evolution
```

### Key Files Created/Modified

| File | Change |
|------|--------|
| `control-plane/app/orchestrator/smart_router.py` | NEW — Smart Router with complexity classification, model selection, tenant-aware routing |
| `control-plane/app/orchestrator/verifier.py` | NEW — Output verification, corrective workflows, quality checks |
| `control-plane/app/orchestrator/feedback_loop.py` | NEW — RL reward computation, strategy evolution, model affinity tracking |
| `control-plane/app/orchestrator/master_orchestrator.py` | MODIFIED — Fast-track execution for simple tasks |
| `control-plane/app/dag/engine.py` | MODIFIED — Smart Router integration, verification, feedback loop |
| `control-plane/app/orchestrator/scheduler.py` | MODIFIED — Rich metadata for routing decisions |
| `control-plane/app/api/routes_smart_router.py` | NEW — API endpoints for routing stats, verification, feedback |
| `control-plane/app/core/config.py` | MODIFIED — Smart Router settings |
| `control-plane/app/main.py` | MODIFIED — v3.2.0, new router registration |
| `control-plane/tests/test_smart_router.py` | NEW — Smart Router tests |
| `control-plane/tests/test_conductor_integration.py` | NEW — Full Phase 5 tests |

---

## Phase 6: Orchestrator v2 📋 (v4.0)

**Priority:** HIGH — Rebuild Hermes & OpenClaw as first-party engines

| Task | Description |
|------|-------------|
| Hermes v2 | LLM-native hierarchical planner replacing static 4-step decomposition |
| OpenClaw v2 | Sandboxed step executor with provenance, retries, rollbacks |
| Evolution wiring | Wire GeneticEngine to completed-PDO corpus (not live tasks) |
| State machine | Formal node lifecycle: pending→running→completed/failed/rolled_back |
| Provenance-gated execution | No credit for work unless ledger entry written first |

---

## Phase 4-6 (Future)

| Phase | Focus | Timeline |
|-------|-------|----------|
| v4.1 — Monitoring | Grafana, Prometheus, structured logging, alerting | Q4 2026 |
| v4.2 — Enterprise | SOC 2, multi-tenant, SSO, on-prem appliance | Q1 2027 |
| v4.3+ — Verticals | Legal, Financial, Healthcare, Government | Rolling |

---

## Immediate Next Steps

1. 🔴 **Secrets rotation** — Remove hardcoded CF tunnel token, Neo4j password, .env from git
2. 🔴 **Database migration** — Replace in-memory dicts with PostgreSQL + SQLAlchemy
3. 🔴 **Auth** — Add JWT middleware, tenant isolation, API key management
4. 🟡 **Android bridge** — Complete Hermes Bridge app for ADB-free control
5. 🟡 **Evolution wiring** — Close the lessons-learnt loop from completed PDOs

---

## Key Links

| Resource | URL |
|----------|-----|
| Marketing Site | https://agentsos.digitalresponse.com.au |
| Strategic Design | `docs/STRATEGIC-PRODUCT-DESIGN.md` |
| v4 Blueprint | `docs/AGENTSOS-V4-BLUEPRINT.md` |
| Phases & Roadmap | `docs/PHASES-AND-ROADMAP.md` |
| GitHub | https://github.com/peterjbardenhagen/AgentsOS |
