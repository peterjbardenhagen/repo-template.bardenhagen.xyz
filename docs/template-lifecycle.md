# Template Lifecycle

The template is not a one-time starting point. Improvements flow **down** to
projects and **back up** from them. Without the second direction, every project
independently rediscovers the same bugs and the template slowly becomes the
least-current codebase in the estate.

```
                    repo-template.bardenhagen.xyz
                         ▲                 │
        (2) uplift       │                 │   (1) propagate
        issue form  ─────┘                 └────►  script
        or skill                                   downstream repos
                                                        │
                    ◄───────────────────────────────────┘
                         a fix worth generalising
```

---

## Direction 1 — Template → Projects

`scripts/propagate-template.sh` syncs template files into every repo in
`DOWNSTREAM_REPOS`.

```bash
./scripts/propagate-template.sh --dry-run              # always first
./scripts/propagate-template.sh --repo owner/one-repo  # a single repo
./scripts/propagate-template.sh                        # everything
```

### Ownership rules

Which side wins on a conflict is per-file, and it matters:

| Files | Winner | Why |
|---|---|---|
| `AGENTS.md`, `CLAUDE.md`, `.cursorrules`, `rules/*`, `.claude/skills/*` | **Template** | Agent instructions must be identical everywhere |
| `docs/git-workflow.md`, `web-standards.md`, `component-structure.md`, `build-versioning.md`, `github-standards.md`, `agentic-sdlc.md` | **Template** | Standards, by definition the same everywhere |
| `docs/architecture.md`, `docs/getting-started.md` | **Project** | Genuinely project-specific |
| `.github/workflows/*` | **Project** if present | Projects legitimately customise pipelines |
| Anything not listed in `TEMPLATE_FILES` | **Project** | Never touched |

> A file the template owns but that is missing from `TEMPLATE_FILES` **never
> reaches downstream repos at all** — the commonest way an improvement gets
> written and then silently goes nowhere. Adding the file to the template is
> only half the job.

### Never run it unprompted

Propagation overwrites AI-config files across every repo. Run `--dry-run`, read
the diff, then decide. It is a human's call, not an agent's.

## Direction 2 — Projects → Template

The direction that decays if it is not deliberate.

### Route A — the `template-uplift` skill (in-session)

When a fix lands in a project and the cause would recur elsewhere, invoke the
skill: it attaches the template repo, generalises the fix, places it, adds an
enforcement check, and opens a draft PR. See
[`.claude/skills/template-uplift/SKILL.md`](../.claude/skills/template-uplift/SKILL.md).

### Route B — the uplift issue form (asynchronous)

When you notice it but cannot act now, open a
[template uplift issue](../../../issues/new?template=template_uplift.yml). It
requires the failure mode, the generalised rule, a destination, and an
enforcement check — the same discipline the skill applies, captured while it is
fresh.

### The filter — most fixes should not be promoted

Both routes apply the same two tests, and both must pass:

1. **It would recur.** The cause is structural, not specific to one project's
   data, domain, or design.
2. **It is stateable as a rule.** "Never X, always Y", applicable by someone who
   never saw the original bug.

**A bloated template is worse than a thin one**, because every rule in it is
read by every agent on every project. Rejecting an uplift is a normal outcome.

### Generalise, or it rots

The downstream fix is *evidence*; the template needs the *rule*. Strip project
nouns, lead with the failure mode rather than the fix — "below 340px the card's
right edge is clipped while its left stays visible" is what makes a reader
recognise the bug in their own code — and state *why*, so nobody simplifies it
back out later.

### Make it enforceable

A rule in prose is a suggestion. Where the improvement admits a check, add one:
a `rg` regex in the doc's Quality Gates section, a case in an audit script, or a
CI step. **Verify the check against a passing *and* a failing example before
shipping it** — a regex that matches both, or neither, is worse than nothing
because it will be trusted.

## Cadence

| When | Do |
|---|---|
| A fix lands whose cause would recur | Uplift it, then and there |
| After a project milestone | Review the diff for generalisable patterns |
| Quarterly | Skim open `template-uplift` issues; batch-merge or close with a reason |
| After a template release | Propagate with `--dry-run`, review, then apply |

## Health checks

The template is drifting out of usefulness if any of these are true:

- A project has been generated but never re-synced
- The same bug has been fixed independently in two projects
- `TEMPLATE_FILES` is missing a doc the template owns
- An uplift issue has sat untriaged for a quarter
- `./scripts/verify-action-pins.sh` fails
- A standards doc contradicts what the projects actually do
