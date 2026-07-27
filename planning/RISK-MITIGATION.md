# Risk Mitigation

## Technical Risks

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| Committed secrets exposed in public repo | High | Critical | Rotate immediately. Add to .gitignore. Pre-commit hook for secret scanning. |
| Container restart loses orchestration state | Certain | High | Phase 2 priority — migrate to PostgreSQL. Until then, document limitation. |
| GPU unavailable for local inference | Medium | High | 9Router cloud fallback. Model Manager auto-routes to available provider. |
| Neo4j/Qdrant data loss | Low | High | Volume persistence in Docker. Scheduled snapshots. |
| Docker compose scaling limits | Medium | Medium | Team-server tier targets single-box. Document K8s migration path for enterprise. |
| Python GIL limits CPU parallelism | Medium | Medium | Async I/O + separate worker processes. Consider Go/Rust for hot paths in v4. |
| Redis Stream delivery failure | Low | Medium | Dead-letter queue. Monitoring alerts on unacknowledged messages. |

## Business Risks

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| No paying customers for open-core model | Medium | High | MyDesk vertical pricing (Legal first). Per-seat + per-node licensing. |
| Competitor ships similar local-first platform | Medium | Medium | Evolutionary per-tenant optimization is defensible moat (compounds with usage). |
| Australian legal vertical too niche | Medium | Medium | Platform is horizontal; legal is first vertical, not only vertical. |
| Developer adoption of open-core slow | Medium | Low | Focus on quality over quantity. MCP compatibility reduces friction. |

## Security Risks

| Risk | Mitigation |
|------|-----------|
| API surface exposed without auth | Phase 2 JWT middleware. Rate limiting via Traefik. |
| Hardcoded credentials in docker-compose | Move to secrets manager. Docker secrets or HashiCorp Vault. |
| CORS allow_origins=["*"] | Restrict to known origins in production. |
| No tenant isolation | Schema-per-tenant with TenantId enforced on all queries. RLS as safety net. |
| SQL injection in raw queries | Parameterized queries only. No string concatenation. |
