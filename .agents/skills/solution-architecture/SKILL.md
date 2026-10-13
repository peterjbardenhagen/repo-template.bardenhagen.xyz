---
name: solution-architecture
description: Produce solution architecture deliverables - current state assessments, gap registers, target state designs, options analyses, ADRs and solution design documents. Use when the task is to assess an existing system, design a target state, write up architecture findings for a client, structure a technical review, or produce any architecture document that must survive challenge by the people who built the system. Triggers on "current state", "target state", "gap analysis", "solution architecture", "architecture review", "design document", "ADR", "options analysis", "HLD", "SAD", "architecture assessment".
---

# Solution architecture deliverables

## The rule that governs everything else

**Separate what is documented from what is observed from what is inferred.** Most architecture reviews fail
not because the analysis is wrong but because the reader cannot tell which category a statement falls into,
so they discount all of it.

Carry an explicit status against every fact:

| Status | Meaning |
|---|---|
| `[DOC]` | Documented in a source, unverified against the running system |
| `[DOC-CONFLICT]` | Two or more sources disagree |
| `[OBS]` | Observed directly - console, telemetry, config, code |
| `[CONFIRMED]` | Confirmed by a named stakeholder who owns the system |
| `[INF]` | Inferred. State the inference chain |

A finding that reaches a client deliverable while still `[DOC]` must say so. "The DID states X" is a
different claim from "X is true", and the difference is the whole value of the review.

## Evidence log first, deliverables second

Before writing any deliverable, stand up a working evidence log. It holds:

1. **Source register** - every document, with version, date, approval status, and a candid note on its
   reliability. Number them `S1`, `S2`, ... and cite as `S2 §8.5` everywhere. Include sources you have
   *requested but not received* - the gaps in the register are findings.
2. **Fact table per scope area** - ID, fact, source reference, status.
3. **Conflicts** - where sources disagree, both positions and which is more current.
4. **Verification questions** - numbered `Q1`, `Q2`, ordered by how much the answer moves the risk register.

The log is not a deliverable. Its purpose is that someone else can defend your findings without you in
the room. Test it that way before handover.

## Distinguish evidenced gaps from undocumented ones

An **evidenced gap** is one the source material demonstrates: the design shows no CI/CD pipeline, the
config shows a single-zone deployment. It is a finding today.

An **undocumented gap** is one where the source is silent on something an architecture of this type would
normally state. That is not the same as the control being absent - it may be recorded elsewhere. Present
these as questions, not findings.

Collapsing the two is the commonest way an architecture review loses credibility in the first review
meeting, because the client answers three of your "findings" from a document you were never given.

## Deliverable set that works

| Doc | Purpose | Discipline |
|---|---|---|
| Working notes / evidence log | Internal. Everything traces here | Never goes to the client |
| Executive summary | Why it matters, in the client's language | Written last, no jargon, no hedging |
| Current state and gaps | What is, and what is missing | Every row cites a source |
| Risk register | Likelihood × business impact | Impact = impact on customers and obligations, not technical severity |
| Target state principles | What good looks like | Each principle tied to a named risk, never stated on its own |
| Recommendations and roadmap | What to do, in what order | Each recommendation traces to a risk AND a principle |

Two tests before anything is issued:
- Every High or Critical risk has at least one recommendation against it.
- Every recommendation traces back to a risk. Recommendations with no risk behind them are opinions.

## Target state principles - the failure mode

Principles are individually unremarkable. Most organisations would endorse all of them. Their value is
not novelty, it is the specific places where the current architecture departs from them and what that
departure costs. So: **never state a principle without naming the risk it addresses and the current
behaviour it contradicts.** A principle list that reads as generic good practice will be skimmed and
ignored.

Where the organisation has its own architecture principles, frame yours as applications of theirs rather
than as new ones. It removes an argument you do not need to have.

## Options analysis

For any material decision, present three options - not two, which reads as a rigged choice, and not five,
which reads as indecision. For each: description, what it costs, what it buys, what it forecloses, and
the conditions under which it is the right answer. Then make a recommendation. An options paper that
does not recommend is unfinished work handed back to the client.

## Architecture Decision Records

One decision per ADR. Status (Proposed / Accepted / Superseded), context, decision, consequences -
including the bad ones. An ADR with no negative consequences listed has not been thought through.
Supersede rather than edit; the history is the point.

## Scope discipline

State explicitly what the work does NOT cover, in the deliverable itself. On a review engagement the
most likely breach is target-state *principles* drifting into target-state *design* - conceptual becomes
logical becomes physical, and the days that belonged to recommendations are gone. Check the boundary
at the point you start writing patterns, and again before issue.

## Language

Write for the reader who will be challenged on your findings in a meeting you are not in. Plain
statements, active voice, no hedging where you have evidence and explicit hedging where you do not.
Quantify: "publishes take 40 minutes" not "publishing is slow". If a number is not known, say it is not
known rather than reaching for an adjective.
