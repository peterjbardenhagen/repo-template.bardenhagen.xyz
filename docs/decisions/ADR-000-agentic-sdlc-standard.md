# ADR-000: Adopt the Agentic AI SDLC and GitHub Control Plane

- **Status:** Accepted as the template default; consuming projects must validate local fit
- **Date:** 2026-10-14
- **Decision owners:** Repository maintainers; each consuming project assigns its own accountable owner

## Context

AI coding agents need durable repository context, scoped permissions, observable acceptance criteria and repeatable verification. Conversation memory alone is not a reliable control plane. Large projects also need discoverable path-specific guidance, specialist roles and structured issue/PR intake.

## Decision

Use five phases—Discovery and Inception; Design and Architecture; Execution and Refinement; Verification and Deployment; Governance and Evolution—with humans accountable for business outcomes and material risk decisions.

Use root `AGENTS.md` as the canonical global contract. `.github/` provides GitHub-specific routing, path instructions, role prompts and issue/PR templates. Use focused branches and PRs, deterministic checks, independent review and explicit production approval gates.

Adopt MCP, agent evaluations, specialist-agent orchestration and episodic memory incrementally, based on need and after reviewing permissions, data flows and operating cost.

## Consequences

### Positive
- More consistent human/agent handoffs and repository onboarding.
- Requirements and decisions remain reviewable in version control.
- Easier to improve quality through evidence, evaluations and retrospectives.

### Trade-offs and safeguards
- Instructions need maintenance; keep them concise and avoid duplicate policy.
- Model-based evaluations can be noisy; retain deterministic tests and human adjudication.
- MCP and memory systems expand the trust surface; use least privilege, provenance, retention controls and an offline path.
- Solo projects may combine roles, but authorship is not independent approval.

## Alternatives considered

1. Keep guidance only in prompts or chat: rejected because it is ephemeral and hard to review.
2. Duplicate policy in every tool-specific file: rejected because copies drift.
3. Deploy a multi-agent swarm and vector memory immediately: deferred until deterministic controls and a clear use case exist.

## Validation

Validate docs, instruction links, issue/PR templates and applicable checks before release. Each consuming repository must adapt the defaults and verify its own stack and governance.
