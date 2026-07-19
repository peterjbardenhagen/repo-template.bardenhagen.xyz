# ADR-001: Record Architecture Decisions

**Status:** Accepted  
**Date:** 2026-07-20  
**Author:** Peter Bardenhagen

## Context

We need a consistent way to document architectural decisions made during the development of projects generated from this template. Without a record, decisions get lost or forgotten, leading to repeated debate and inconsistent evolution of the system.

## Decision

We will use Architecture Decision Records (ADRs), as described by Michael Nygard in his article ["Documenting Architecture Decisions"](https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions).

Each ADR will:
- Be a short markdown file in `docs/decisions/`
- Use the format `ADR-NNNN-title-with-dashes.md`
- Follow the template sections: Context, Decision, Consequences

## Consequences

- **Positive:** Decisions are documented and accessible to all team members (human and AI)
- **Positive:** New team members can understand the rationale behind past decisions
- **Negative:** Requires discipline to write ADRs for significant decisions
- **Negative:** ADRs need occasional maintenance if decisions are revisited
