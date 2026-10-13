---
name: enterprise-architecture
description: Enterprise architecture work - business capability models, application portfolio assessment, technology roadmaps, architecture principles, reference architectures, and governance artefacts. Use when working above the level of a single solution - portfolio rationalisation, capability mapping, target operating models, EA principles, technology standards, lifecycle and currency assessment, or roadmap sequencing across multiple systems. Triggers on "capability model", "application portfolio", "enterprise architecture", "technology roadmap", "architecture principles", "reference architecture", "TOGAF", "target operating model", "rationalisation", "technology currency", "EA governance".
---

# Enterprise architecture

## Work at the right altitude

The distinguishing error in EA work is drifting down into solution detail. If a statement would change
because one system was replaced, it is solution architecture, not enterprise architecture. EA statements
survive the replacement of any single component.

Test each artefact: *would this still be true and useful in three years, after two of these systems have
been swapped out?* If not, it belongs in a solution document.

## Capability models

Business capabilities are **what** the organisation does, never **how** or **who**. "Customer billing"
is a capability. "SAP" is not. "The billing team" is not.

- Level 1: 8-15 capabilities covering the whole organisation. More than 15 and nobody can hold it.
- Level 2: decompose only where the analysis needs it. Uniform decomposition everywhere is wasted effort.
- Heat-map against exactly one dimension at a time - maturity, or investment, or risk. Never three at
  once with a traffic-light per corner; it becomes unreadable and defensible only by its author.

The value is not the model. It is the conversation the model forces about where capability and
investment diverge.

## Application portfolio

Assess each application on two axes - **business value** and **technical health** - and place it in one
of four dispositions: Tolerate, Invest, Migrate, Eliminate. Keep the axes independent; a beloved system
on a dead platform is the whole point of the exercise.

Minimum record per application: owner, business capability supported, lifecycle status, vendor support
end date, integration count, annual cost, disposition, and the trigger that would change the disposition.

**Technology currency deserves its own treatment.** For each material platform, record: current version,
vendor support end date, the version the vendor is steering customers toward, and whether the current
line has a successor at all. A platform on its terminal release is a different risk from one that is
merely behind - the first has no upgrade path, only a migration.

## Principles

An EA principle needs four parts, and is worthless with three: **statement**, **rationale**,
**implications**, and **how you would know it was being violated**. The fourth is the one that gets
dropped and the one that makes the principle enforceable.

Ten to fifteen principles maximum. Principles that never constrain a decision are decoration - if you
cannot name a real decision the principle would have changed, delete it.

## Roadmaps

Sequence by dependency and by risk, not by preference. Horizons work better than dates when the funding
is not yet secured:

- **Horizon 1** - close what is already causing harm. Evidenced problems only.
- **Horizon 2** - make the estate predictable. Standardisation, parity, observability, automation.
- **Horizon 3** - position for what comes next. Cannot be sequenced until the strategic questions are
  answered, and say so.

State the dependency that makes Horizon 3 unsequenceable rather than inventing dates for it. A roadmap
with confident dates on unfunded, undecided work is the artefact most likely to be quoted back at you.

## Governance artefacts

Keep them thin enough to be used. A standards document nobody reads has negative value - it creates the
appearance of governance without the substance. Prefer: a short standards register with named owners, a
current exception list with expiry dates, and a decision log. An exception with no expiry date is a
silent standard change.

## Reference architectures

A reference architecture is only useful if a project can be measured against it. Include the decision
points and the acceptable answers, not just a diagram of boxes. State what the reference does not cover.

## Where EA work goes wrong

- **Modelling for its own sake.** Ask what decision the artefact will change. If none, stop.
- **Current state that is never finished.** Time-box it. Capture enough to make the next decision.
- **Principles nobody applies.** See the fourth part above.
- **Roadmaps disconnected from funding cycles.** Sequence against the budget calendar, or the roadmap
  is fiction.
- **Confusing standardisation with value.** Standardise where variance costs money or risk. Elsewhere,
  variance is cheaper than the programme to remove it.
