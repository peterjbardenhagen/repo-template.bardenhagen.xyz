# Skills

Drop project-specific Claude Code skills here, one directory per skill:

```
.claude/skills/
└── my-skill/
    └── SKILL.md
```

`SKILL.md` needs YAML frontmatter (`name`, `description`) followed by the skill's instructions. See the [Claude Code skills docs](https://docs.claude.com/en/docs/claude-code) for the current format.

Use a skill when a task is repeatable and has a clear trigger phrase (e.g. "deploy to staging", "run the migration checklist") — not for one-off instructions, which belong in `AGENTS.md` or the relevant `rules/` file instead.

This directory ships empty in the template. Add skills as your project accumulates repeatable workflows worth packaging.
