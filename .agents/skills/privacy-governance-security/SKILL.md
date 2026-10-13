---
name: privacy-governance-security
description: Assess privacy, data governance, security and AI risks throughout the software lifecycle. Use before connecting sensitive data, enabling tools, deploying AI or changing data flows.
---

# Privacy, Governance and Security Review Skill

## Guardrails

Do not claim legal compliance or certification without evidence. Do not process real sensitive data in tests without explicit authorisation. Never reveal, copy or log credentials. Do not perform destructive tests against production without approval.

## Workflow

1. Identify business purpose, accountable owners, data subjects, jurisdiction, system boundaries and criticality.
2. Inventory data classes and map collection, storage, retrieval, model/tool processing, logs, backups, exports and deletion.
3. Assess minimisation, purpose, authority/consent where applicable, notices, retention, residency, cross-border transfers, subprocessors and rights handling.
4. Threat-model identity, access, network, secrets, dependencies, build/release pipeline, MCP, prompt injection, excessive agency and data exfiltration.
5. Map controls to applicable law, contracts, organisational policy and frameworks such as Azure Well-Architected, ASD Essential Eight, ISM, ISO 27001 or ISO/IEC 42001 as appropriate.
6. Define prevention, detection, response and recovery controls. Validate with tests and evidence.
7. Record risks, residual risk, owner, due date, approved exception and expiry.
8. Review the design after material changes and before production release.

## Required output

- Data-flow diagram and classification inventory.
- Privacy/security risk register with likelihood, impact, evidence and mitigation.
- Access/identity and retention matrix.
- AI/MCP threat cases and evaluation results.
- Control mapping with applicability notes; a framework mapping is not a certification.
- Release decision, outstanding exceptions, owner and next review date.

## References

- https://www.oaic.gov.au/privacy/australian-privacy-principles
- https://www.oaic.gov.au/privacy/notifiable-data-breaches
- https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/essential-eight
- https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism
- https://learn.microsoft.com/en-us/azure/well-architected/ai/
- https://learn.microsoft.com/en-us/azure/ai-foundry/responsible-use-of-ai-overview
