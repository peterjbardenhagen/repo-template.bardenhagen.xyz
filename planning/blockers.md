# Active Blockers

| Blocker | Owner | Since | Impact | Action Needed |
|---------|-------|-------|--------|---------------|
| Committed secrets in git (.env, CF token, Neo4j) | DevOps | 2026-07 | Security — can't share repo externally | Rotate all, add to .gitignore, purge from history |
| In-memory state lost on restart | Backend | 2026-07 | No real audit trail, data loss risk | Migrate to PostgreSQL |
| No auth on API | Backend | 2026-07 | Anyone with network access can call API | Add JWT middleware |
| Android ADB not complete | Mobile | 2026-07 | No mobile device control | Complete Hermes Bridge app |
