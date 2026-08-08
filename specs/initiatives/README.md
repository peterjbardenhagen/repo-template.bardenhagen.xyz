# Initiatives

Each initiative lives in its own folder under `specs/initiatives/`.  
Multiple people or agents can drive different initiatives in parallel without colliding on the constitution.

## Structure

```
specs/initiatives/<initiative-slug>/
├── roadmap.md    # Phases for this initiative
└── research/     # Supporting research notes
```

## Rules

1. Initiatives are **sequential** within a phase, but **parallel** across initiatives.
2. One person owns the constitution (`specs/mission.md`, `specs/tech-stack.md`).
3. Branch creation claims a phase; the PR is the gate.
