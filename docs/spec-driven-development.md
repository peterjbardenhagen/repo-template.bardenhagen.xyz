# Spec-Driven Development

> **Version:** 2.3.0  
> **Date:** August 2026

Spec-Driven Development (SDD) encodes intent before implementation. For agentic workflows, this means agents work from a contract rather than a prompt, reducing ambiguity and ensuring traceability.

## Core Principles

1. **Write specs before code.** Agents implement from approved artifacts, not from evolving conversation.
2. **Light by default, escalate on risk.** Most work is a two-way door (reversible). Only one-way-door changes (migrations, auth, public APIs) get the full spec trio.
3. **Specs are durable; code is disposable.** When the agent or human changes, the specs persist. Any agent can pick up where another left off.
4. **Ceremony scales with the cost of being wrong.** A full spec trio for a trivial change is waste. No spec for a database migration is negligence.

## The Spec Trio

For one-way-door changes, produce all three before writing code:

```
specs/initiatives/<slug>/
├── requirements.md   # Functional + non-functional requirements
├── plan.md          # Implementation plan with atomic tasks
└── validation.md    # How to verify the change is correct
```

## Phase Sizing: The Two-Way Door Test

Before writing a spec, ask:

| Question | If Yes | If No |
|----------|--------|-------|
| Can we revert without data loss? | Light mode: build it, leave a breadcrumb | Heavy mode: full spec trio |
| Does it affect external contracts? | Light mode | Heavy mode |
| Is it a security or auth boundary? | Heavy mode | Heavy mode |
| Will it be hard to undo later? | Heavy mode | Light mode |

## Traceability

Every spec references others by descriptive ID:

- `REQ-F-001` — Functional requirement
- `REQ-NFR-001` — Non-functional requirement
- `DEC-001` — Architecture decision
- `US-001` — User story

This creates a chain from business need to running code.

## Agent Workflow

1. **Bootstrap**: Run the bootstrap skill to document the existing project or start fresh.
2. **Phase kickoff**: Use `feature-spec` skill to run the two-way door test.
3. **Spec authoring**: If heavy, produce the spec trio. If light, record intent on the roadmap.
4. **Implementation**: Execute tasks one at a time, updating status.
5. **Verification**: Run tests and update `validation.md`.

## References

- [Spec-Driven Development with Coding Agents (DeepLearning.AI)](https://www.deeplearning.ai/short-courses/spec-driven-development-with-coding-agents/)
- [sdd-template by angelotadres](https://github.com/angelotadres/sdd-template)
- [Andrej Karpathy on LLM Coding Pitfalls](https://x.com/karpathy/status/2015883857489522876)
