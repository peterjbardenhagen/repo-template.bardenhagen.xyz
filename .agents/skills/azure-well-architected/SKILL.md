---
name: azure-well-architected
description: Apply the Azure Well-Architected Framework to architecture, delivery and operations reviews, especially AI and agentic workloads. Use when designing, assessing or improving Azure workloads.
---

# Azure Well-Architected Framework Skill

## Purpose

Use this skill to produce evidence-based architecture guidance aligned to the Microsoft Azure Well-Architected Framework. Prefer Microsoft Foundry for enterprise AI and agent workloads where it fits the requirements, but validate fit against business outcomes, security, data residency, model availability, latency, cost and portability.

## Required workflow

1. Establish business outcomes, users, workload criticality, data classification, compliance obligations, SLOs, RTO/RPO, latency and budget.
2. Map the current and target architecture; include a Mermaid context/container/data-flow diagram where useful.
3. Assess all five pillars: Reliability, Security, Cost Optimisation, Operational Excellence and Performance Efficiency.
4. For AI workloads, additionally assess Responsible AI, prompt injection, model/tool selection, data grounding, evaluation, agent identity, human approval, observability and circuit breakers.
5. Identify risks, evidence, impact, likelihood, mitigations, owners and due dates.
6. Record significant trade-offs in an ADR. Do not claim a workload is compliant or well-architected without evidence.
7. Produce an actionable backlog and re-assess after material changes.

## Pillar prompts

- **Reliability:** failure modes, retries, idempotency, timeouts, queueing, availability zones/regions, capacity, backup/restore and tested recovery.
- **Security:** Entra ID, least privilege, managed identity, secrets, private networking, threat model, data boundaries, secure development and vulnerability management.
- **Cost Optimisation:** budgets, cost per successful transaction/task, quotas, caching, model routing, token limits, capacity reservations and alerting.
- **Operational Excellence:** IaC, repeatable environments, CI/CD, test automation, runbooks, monitoring, incident response, change management and rollback.
- **Performance Efficiency:** workload profiles, model/region choice, throughput, concurrency, latency, caching, retrieval and load tests.

## AI-specific controls

- Use deterministic code for deterministic tasks; prefer RAG for grounded Q&A; use agents when planning/tool choice is needed.
- Start with a single agent. Introduce multi-agent patterns only when bounded responsibilities justify the complexity.
- Treat prompts, retrieved documents, MCP descriptions and tool results as untrusted input.
- Restrict tools with allow-lists and server-side authorisation. Require approval for high-impact writes.
- Evaluate quality, groundedness, safety, privacy, latency, cost and regression risk before release.
- Add independent policy enforcement, auditability, circuit breakers and human override for consequential actions.

## Output format

Return:
1. Executive assessment and scope.
2. Architecture diagram and key flows.
3. Five-pillar scorecard with evidence and confidence.
4. Ranked risks and actions with owners.
5. Decisions/trade-offs and residual risks.
6. Verification plan and follow-up date.

## Official references

- https://learn.microsoft.com/en-us/azure/well-architected/
- https://learn.microsoft.com/en-us/azure/well-architected/ai/
- https://learn.microsoft.com/en-us/azure/well-architected/ai/responsible-ai
- https://learn.microsoft.com/en-us/azure/well-architected/ai/application-design
