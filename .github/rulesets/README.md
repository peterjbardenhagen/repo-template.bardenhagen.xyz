# Repository rulesets

`repo-safety-no-destructive-actions.json` blocks force-push (`non_fast_forward`) and branch deletion (`deletion`) on `main`/`master`. It is not applied automatically — GitHub rulesets are an org/repo API resource, not a file GitHub reads from the tree.

Apply it once per repo after generating from this template:

```bash
gh api --method POST repos/<owner>/<repo>/rulesets \
  --input .github/rulesets/repo-safety-no-destructive-actions.json
```

To update an existing ruleset, find its ID first (`gh api repos/<owner>/<repo>/rulesets`) then `PUT` to `repos/<owner>/<repo>/rulesets/<id>`.

Why this matters for autonomous agent loops: an agent running unattended (see `docs/agentic-sdlc.md`) has no way to recover from a force-push or deleted branch on `main`. The ruleset makes that failure mode impossible instead of relying on the agent to remember not to do it.
