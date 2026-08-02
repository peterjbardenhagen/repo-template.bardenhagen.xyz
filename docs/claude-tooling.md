# Claude Tooling

What lives in `.claude/`, and which pieces are worth adding to a project
inheriting this template.

---

## What's in the box

```
.claude/
├── agents/          # Subagents — delegated roles with their own tool access
│   ├── architect.md   coder.md   reviewer.md   tester.md   devops.md
│   └── ux.md         analyst.md
├── skills/          # Packaged repeatable workflows
│   └── template-uplift/SKILL.md
└── settings.json    # Committed permission defaults
```

## The four mechanisms, and when each is right

Picking the wrong one is the usual mistake — most often a skill written where a
line in `AGENTS.md` would have done.

| Mechanism | Use when | Loaded |
|---|---|---|
| **`AGENTS.md` / `CLAUDE.md`** | A rule that applies to *everything* | Every session |
| **`rules/` + `.claude/agents/`** | A distinct role with its own judgement and checklist | When that role is invoked |
| **`.claude/skills/`** | A repeatable multi-step workflow with a clear trigger phrase | When its description matches |
| **Hooks** (`settings.json`) | Something that must happen deterministically, every time | On the matching event |

**Budget matters.** Everything in `AGENTS.md` is read on every session of every
project. Put the one-line rule there and the explanation in a doc. A skill costs
only its name and description (~100 tokens) until it fires — which is why a
sharp description matters more than the body.

### Agents vs skills

- **Agent** = *who* — a role with a perspective. "Review this like a UX
  specialist would."
- **Skill** = *how* — a procedure. "Promote this improvement into the template."

If you find yourself writing "first do X, then Y, then Z", that is a skill. If
you are writing "care about these things, block on those", that is an agent.

## Writing a skill that actually fires

The description is the only part loaded at startup, so it is a **routing rule,
not a summary**. It must answer *when to fire*, name the trigger phrases people
actually say, and state what it produces.

```yaml
---
name: deploy-staging
description: "Deploy the current branch to staging. Use when the user says
  'deploy to staging', 'push this to staging', or 'can I see this on staging'.
  Produces a deployed URL and a smoke-test result. Do NOT use for production
  deploys — those require the release checklist."
---
```

Rules of thumb:

- Keep `SKILL.md` under ~500 lines; split into referenced files beyond that
- Say what it is **not** for — negative triggers prevent misfires
- Encode the *failure modes*, not just the happy path. The value is in "this
  looks right but breaks because…"
- Verify anything the skill tells an agent to run. A command shipped in a skill
  gets executed verbatim and trusted

## Worth adding to most projects

| Skill | Why |
|---|---|
| `template-uplift` | Shipped. Promotes improvements back upstream |
| `deploy` | Encodes the deploy sequence and its pre-flight checks |
| `release` | Version bump, changelog, tag, notes — easy to do inconsistently |
| `db-migration` | Migrations are high-risk and benefit from a fixed procedure |
| `incident` | What to check, in what order, when production is broken |
| `onboard` | Gets a fresh session productive without re-reading everything |

Add them **as the project accumulates the workflow**, not upfront. A skill for a
procedure nobody has performed twice is speculative.

## Hooks

Hooks run deterministically on events, so use them where "the agent should
remember to" is not good enough. Configured in `.claude/settings.json`.

Common ones:

- Format on write (`PostToolUse` on Edit/Write) — removes an entire class of
  lint failures
- Block edits to generated files (`PreToolUse`) — e.g. `src/generated/`
- Run the pin verifier after any workflow change

Keep them fast. A hook on every write that takes two seconds is felt constantly.

## Permissions

`.claude/settings.json` is committed, so the whole team and every agent session
inherit the same defaults. The shipped baseline allows read-only git and denies
the destructive operations:

```json
{
  "permissions": {
    "allow": ["Bash(git status)", "Bash(git diff*)", "Bash(git log*)"],
    "deny":  ["Bash(git push --force*)", "Bash(git reset --hard*)", "Bash(rm -rf*)"]
  }
}
```

Add project-specific safe commands (`Bash(npm run lint)`, `Bash(npm test)`) to
cut permission prompts. Never allowlist anything that writes to production or
rewrites shared history.

## MCP servers

MCP connects Claude to external systems — GitHub, databases, browsers,
observability. Configure per-project rather than globally so each project only
reaches what it needs.

Useful in this context: GitHub (issues, PRs, CI), Playwright (drive the real UI
for the UX checks in `rules/06-ux.md`), and a read-only database connection for
schema questions.

**Least privilege applies.** A read-only token for a server that only needs to
read. An MCP server with write access to production is a standing risk that
exists between sessions, not just during them.

## Anti-patterns

| Don't | Do |
|---|---|
| Put project detail in a skill's description | Description routes; body carries detail |
| Write a skill for a one-off | Put it in `AGENTS.md` or a `docs/` page |
| Duplicate `AGENTS.md` content into every agent | Agents reference, not restate |
| Add a skill per npm script | Skills are for judgement-bearing sequences |
| Let `AGENTS.md` grow unbounded | One-line rule + link to the doc |
| Ship an unverified command in a skill | Run it first — it will be trusted |
