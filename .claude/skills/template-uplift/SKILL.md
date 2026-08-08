---
name: template-uplift
description: "Promote an improvement from a project back into repo-template.bardenhagen.xyz so every future project inherits it. Use when the user says any of: 'add this to the template', 'uplift the template', 'promote this to repo-template', 'update the repo template', 'make this the standard', 'every project should do this' — or when a bug has just been fixed whose root cause would recur in any project built from the template (a responsive/layout trap, a CI or supply-chain gap, a git-workflow hole, a missing convention). Takes a concrete fix or pattern that already exists in a downstream repo; produces a committed, PR'd change to the template. Do NOT use for changes that only make sense in one project, or for editing a project's own AGENTS.md/CLAUDE.md."
---

# Template Uplift

Turn a fix that worked in one project into a rule every future project inherits.

The template is `peterjbardenhagen/repo-template.bardenhagen.xyz`. Downstream
projects are generated from it and re-synced by `scripts/propagate-template.sh`.

## 0. Filter first — most fixes do not belong

Promote only if **both** hold:

- **It would recur.** The root cause is structural, not specific to this
  project's data, domain, or design.
- **It is stateable as a rule.** You can write "never X, always Y" and a reader
  who has never seen the original bug can apply it.

| Promote | Leave downstream |
|---|---|
| A layout pattern that silently breaks on mobile | This app's card colours |
| An unpinned action / CI permission gap | This repo's deploy secrets |
| A build-provenance mechanism | This project's version number |
| A convention that stops a whole bug class | A one-off copy fix |

If it fails the filter, say so and stop. A bloated template is worse than a thin
one — every rule in it is read by every agent on every project.

## 1. Get the template

It is a separate repo. From a downstream project:

```
add_repo(owner="peterjbardenhagen", repo="repo-template.bardenhagen.xyz", access="push")
```

Then branch from a current trunk — **never** commit to `main`:

```bash
cd /workspace/repo-template.bardenhagen.xyz
git fetch origin
git checkout -B claude/<topic>-<short-code> origin/main
```

> **Check for unpushed local commits first**: `git log --oneline origin/main..main`.
> The template's local `main` sometimes carries work that was never pushed. If it
> does, `git cherry-pick` those commits onto your branch rather than branching
> past them — otherwise the PR silently reverts them.

## 2. Generalise

This is the step that gets skipped, and skipping it is what makes a template
rot. The downstream fix is evidence; the template needs the *rule*.

- **Strip project specifics.** No app names, routes, colours, or domain nouns.
- **Lead with the failure, not the fix.** "Below 340px the card's right edge is
  clipped while its left stays visible" is what makes a reader recognise the bug
  in their own code. "Use `min()`" alone teaches nothing.
- **Say why**, so nobody "simplifies" it back. A rule whose reason is missing
  gets reverted by the next person who finds it inconvenient.
- **Give the correct form as copyable code**, both ✅ and ❌.

## 3. Place it

| Kind of improvement | Goes in |
|---|---|
| Branching, commits, merging, force-push | `docs/git-workflow.md` |
| Pipelines, permissions, supply chain | `docs/ci-cd.md` + `.github/workflows/` |
| Responsive, layout, a11y, SEO | `docs/web-standards.md` |
| React/Next structure, data layer | `docs/component-structure.md` |
| Build provenance | `docs/build-versioning.md` |
| A copyable file (script/component/CSS) | `templates/<kind>/` |
| A short rule every agent must follow | `AGENTS.md` (and `CLAUDE.md` if Claude-specific) |
| A repeatable multi-step workflow | a new `.claude/skills/<name>/SKILL.md` |

Two placement rules:

- **Prefer extending an existing doc** over adding one. Six docs nobody reads
  beat one that is actually loaded.
- **`AGENTS.md` is a budget.** Everything in it is read on every session of
  every project. Put the one-line rule there and the explanation in a doc.

## 4. Make it enforceable

A rule in prose is a suggestion. Where the improvement admits a check, add one —
this is the difference between a template that shapes behaviour and one that
documents intentions.

- A `rg` regex in the doc's Quality Gates section
- A case in `templates/scripts/audit-overflow.mjs` or an equivalent script
- A CI step
- A line in the relevant rollout checklist

**Verify the check against both inputs before shipping it.** Write a scratch
file containing the bad pattern *and* the corrected one, run the check, and
confirm it flags exactly the first. A regex that matches both — or neither — is
worse than nothing, because it will be trusted.

## 5. Verify

- YAML changed? Parse every workflow:
  `python3 -c "import yaml,glob; [yaml.safe_load(open(f)) for f in glob.glob('.github/workflows/*.yml')]"`
- Script added? Run it, including its failure path and a simulated CI env.
- Pinned an action? Resolve the real SHA — never invent one:

  ```bash
  # Latest stable tag for a repo
  git ls-remote --tags https://github.com/<owner>/<repo> \
    | grep -oE 'refs/tags/v[0-9]+\.[0-9]+\.[0-9]+$' | sort -V | tail -1

  # That tag -> its COMMIT sha
  resolve() {
    git ls-remote "https://github.com/$1" "refs/tags/$2^{}" "refs/tags/$2" \
      | sort -k2 | tail -1 | cut -f1
  }
  resolve actions/checkout v7.0.1
  ```

  The `^{}` ref matters: for an *annotated* tag, `refs/tags/vX` is the tag
  object, not the commit, and pinning to it does not resolve. Querying both and
  taking the last sorted line yields the commit for annotated tags and the only
  line for lightweight ones. Keep the version in a trailing comment so
  Dependabot can still bump it: `uses: owner/repo@<sha> # v1.2.3`

  Then let the guard confirm it: `./scripts/verify-action-pins.sh`. **Never
  hand-write a SHA from memory** — a plausible-looking but wrong one stops the
  job from starting at all, and reviews do not catch it because one 40-hex
  string looks like any other.
- Links resolve to files that exist.

## 6. Ship

Conventional commit. Body states the failure the rule prevents, not just the
edit:

```
docs(web-standards): add responsive patterns learned in production

- The minmax() grid trap. repeat(auto-fit, minmax(300px, 1fr)) claims a hard
  300px per track, so below ~340px the card's right edge is pushed off-screen
  while its left edge stays visible — it reads as a styling bug, not overflow.
  Fix is minmax(min(300px, 100%), 1fr), with a lint regex verified to match
  the bare floor but not the min() form.
```

Then push and open a **draft** PR:

```bash
git push -u origin claude/<topic>-<short-code>
```

Use `mcp__github__create_pull_request` with `draft: true`, following
`.github/PULL_REQUEST_TEMPLATE.md` if present.

## 7. Mention propagation — do not run it

`scripts/propagate-template.sh` pushes template files into **every** downstream
repo, and for AI-config files the template overwrites the project's version.

**Never run it unprompted**, and never before the PR merges. Tell the user it
exists and let them decide:

> Merged into the template. `scripts/propagate-template.sh --dry-run` will show
> what would land in the other N repos — want me to run that?

Always `--dry-run` first, and read the diff before a real run.

## Definition of done

- [ ] Passed the §0 filter
- [ ] Generalised — no project-specific nouns
- [ ] States the failure mode and the reason, not just the rule
- [ ] Placed per §3, extending a doc rather than adding one where possible
- [ ] Enforceable check added and verified against good *and* bad input
- [ ] Workflows parse; scripts run
- [ ] Committed conventionally, pushed, draft PR open
- [ ] Propagation offered, not executed
