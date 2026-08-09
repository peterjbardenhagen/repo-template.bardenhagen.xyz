# Skills

Drop project-specific Claude Code skills here, one directory per skill:

```
.claude/skills/
└── my-skill/
    └── SKILL.md
```

`SKILL.md` needs YAML frontmatter (`name`, `description`) followed by the skill's instructions. See the [Claude Code skills docs](https://docs.claude.com/en/docs/claude-code) for the current format.

Use a skill when a task is repeatable and has a clear trigger phrase (e.g. "deploy to staging", "run the migration checklist") — not for one-off instructions, which belong in `AGENTS.md` or the relevant `rules/` file instead.

## Shipped with the template

- **`template-uplift/`** — promote an improvement from this project back into
  `repo-template.bardenhagen.xyz`, so every future project inherits it. Fires on
  "add this to the template" / "every project should do this", or after fixing a
  bug whose root cause would recur in any project built from the template.

- **`github-cleanup/`** — keep the GitHub repo tidy: ensure `main` is the
  default branch, merge legacy `master`/`Master` branches into `main`, and
  delete stale merged branches. Fires on "clean up this repo", "tidy branches",
  or "merge legacy branches".

Add your own alongside it as the project accumulates repeatable workflows worth
packaging.
