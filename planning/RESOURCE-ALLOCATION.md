# Resource Allocation

## Team

| Role | Person | Focus |
|------|--------|-------|
| Technical Lead | Peter Bardenhagen | Architecture, strategy, code review |
| Backend | AI Agent | Control Plane, DAG Engine, Persistence |
| Frontend | AI Agent | Next.js dashboard, marketing site |
| DevOps | AI Agent | Docker, CI/CD, deployment |
| Mobile | AI Agent | Android bridge, ADB integration |

## Agent Specializations

| Agent | Capabilities | Owns |
|-------|-------------|------|
| Architect | System design, ADRs, code review | `docs/decisions/`, architecture docs |
| Coder | Implementation, refactoring | Feature branches |
| Reviewer | Code quality, standards | PR review |
| Tester | Unit tests, integration tests, E2E | `tests/`, `test-orchestrator/` |
| DevOps | CI/CD, Docker, deployment | `.github/workflows/`, `infra/` |

## Feature Ownership

| Feature | Owner | Status |
|---------|-------|--------|
| Control Plane API | Backend Agent | ✅ Complete |
| DAG Engine | Backend Agent | ✅ Complete |
| Evolution Engine | Backend Agent | ✅ Complete |
| Frontend Dashboard | Frontend Agent | ✅ Complete |
| Marketing Site | Frontend Agent | ✅ Deployed |
| Persistence (Postgres) | Backend Agent | 🔄 In Progress |
| Auth (JWT/RBAC) | Backend Agent | 🔄 In Progress |
| Secrets Rotation | DevOps Agent | 🔴 Not Started |
| Hermes v2 | Backend Agent | 📋 Planned |
| OpenClaw v2 | Backend Agent | 📋 Planned |
| Android Bridge | Mobile Agent | 🟡 Partial |

## Current Sprint Allocation

| Agent | Work Item | Est. Effort |
|-------|-----------|-------------|
| Backend | Phase 2: Database migration | 2 weeks |
| Backend | Phase 2: Auth middleware | 1 week |
| DevOps | Secrets rotation | 2 days |
| Frontend | Marketing site updates | As needed |
