# Dependencies & Blockers

## Dependency Graph

```
Phase 1 (Complete)
  └── Phase 2: Persistence & Auth
        ├── Database migration (PostgreSQL)
        ├── AuthN/AuthZ (JWT + RBAC)
        └── Secrets rotation
              └── Phase 3: Orchestrator v2
                    ├── Hermes v2 (needs Phase 2 DB)
                    ├── OpenClaw v2 (needs Phase 2 Queue)
                    ├── Evolution wiring (needs Hermes v2)
                    └── State machine (needs Phase 2 DB)
                          └── Phase 4: Monitoring
                                └── Phase 5: Enterprise
                                      └── Phase 6: Verticals
```

## Active Blockers

| Blocker | Impact | Status | Unblock Action |
|---------|--------|--------|----------------|
| Committed secrets in git (.env, CF token, Neo4j creds) | Security risk for any external pilot | 🔴 Unresolved | Rotate all secrets, add to .gitignore, use secrets manager |
| In-memory state (projects, ledger, DAG nodes) | Vanish on restart — no real audit trail | 🔴 Unresolved | Migrate to PostgreSQL (Phase 2 item 1) |
| No auth middleware | API surface exposed | 🔴 Unresolved | Add JWT middleware (Phase 2 item 2) |
| Hermes is static planner (264 lines) | Not LLM-native, not enterprise-grade | 🟡 Unresolved | Rebuild as Hermes v2 (Phase 3) |
| OpenClaw is KV store (255 lines) | Doesn't execute anything | 🟡 Unresolved | Rebuild as OpenClaw v2 (Phase 3) |
| Evolution loop seeds from live tasks | Doesn't close lessons-learnt properly | 🟡 Unresolved | Wire completed-PDO fitness (Phase 3) |
| Android ADB integration not complete | No mobile device control | 🟡 Unresolved | Complete Hermes Bridge app |

## Resolved Blockers

| Blocker | Resolution | Date |
|---------|-----------|------|
| 5 duplicate codebases | Archived to `/archive/`, `control-plane/app` is canonical | 2026-07 |
| --reload flag in production | Removed | 2026-07 |
| WebSocket connection issues | Fixed | 2026-07 |
| Python deprecation warnings | Resolved | 2026-07 |
