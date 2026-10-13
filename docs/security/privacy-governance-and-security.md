# Privacy, Governance and Security Baseline

This is the default engineering baseline for repositories created from this template. It is not legal advice or a claim of certification. Tailor controls to the jurisdiction, sector, data and risk of the actual workload.

## Operating principles

1. **Privacy by design and default:** collect the minimum data needed for a stated purpose.
2. **Security by design:** threat-model early, enforce controls server-side and verify them with tests.
3. **Accountability:** identify business, data, system, security and AI risk owners for material workloads.
4. **Purpose limitation:** document why data is collected, how it is used, who can access it, where it is processed and when it is deleted.
5. **Least privilege:** deny by default, scope identities and tools narrowly, separate duties and review access regularly.
6. **Evidence over assertion:** record test results, approvals, risk acceptance, data-flow diagrams, retention rules and operational readiness.
7. **Human oversight:** gate consequential, external, financial, safety-related or irreversible actions behind policy and authorised people.

## Privacy and data handling checklist

- [ ] Identify personal, sensitive, confidential, regulated and customer data; classify it before connecting services.
- [ ] Map data flows across collection, storage, retrieval, model inference, logs, analytics, backups, exports and deletion.
- [ ] Document purpose, authority or lawful basis where applicable, notices, consent where required and data-subject request handling.
- [ ] Minimise prompt content, retrieval scope, telemetry and stored conversation history. Do not place secrets or unnecessary personal data in prompts.
- [ ] Define retention and deletion periods for source data, vector indexes, caches, model inputs/outputs, logs, backups and exported datasets.
- [ ] Enforce user identity and source-system permissions; apply document/row-level access trimming where applicable.
- [ ] Verify data residency, cross-border transfers, subprocessors, service terms and support access for each external model or tool.
- [ ] Redact tokens, credentials, sensitive prompts and unnecessary identifiers from logs; control log access and retention.
- [ ] Assess privacy impact before high-risk processing, sensitive-data use, monitoring, profiling or AI-driven decisions.
- [ ] Test data deletion, access correction, export and incident response instead of assuming the underlying service handles them automatically.

## Governance lifecycle

\`\`\`mermaid
flowchart TD
    A[Business purpose and accountable owner] --> B[Data classification and privacy impact]
    B --> C[Threat model and architecture decision]
    C --> D[Build with controls and tests]
    D --> E[Independent review and risk acceptance]
    E --> F[Controlled deployment]
    F --> G[Monitor, audit and respond]
    G --> H[Periodic review or retirement]
    H --> B
\`\`\`

## Security baseline

### Identity and access
- Prefer Microsoft Entra ID, workload identities and managed identities for Azure workloads; use GitHub Actions OIDC federation when supported.
- Keep credentials in an approved secret manager. Never commit API keys, certificates, tokens, environment files or authenticated browser state.
- Use separate development, test and production identities. Never reuse production credentials in local model or agent test environments.
- Require MFA for privileged accounts and review repository, cloud, MCP and model-provider permissions regularly.

### Secure development and supply chain
- Protect the default branch with pull requests, required reviews, conversation resolution and meaningful required checks.
- Pin third-party GitHub Actions to verified full commit SHAs; update them through reviewed dependency changes.
- Use lockfiles, dependency review, secret scanning, static analysis, infrastructure/container scanning and SBOM/provenance for releasable artefacts where applicable.
- Treat MCP servers, agent skills, plugins, model files, prompt templates and downloaded datasets as supply-chain dependencies. Verify provenance, licence, integrity, permissions and update policy.
- Build reproducibly where practical. Do not auto-merge security-sensitive changes or updates that fail tests.

### AI and agent controls
- Treat user input, retrieved content, issues, repository files, model output and tool responses as untrusted.
- Enforce authorisation outside the model; model instructions are not an access-control mechanism.
- Limit tools to an allow-list and validate every argument server-side. Use read-only tools by default.
- Require explicit approval for external messages, data exports, production changes, financial transactions, permission changes and destructive operations.
- Test direct/indirect prompt injection, tool confusion, excessive agency, data leakage, cross-tenant access and unsafe generated code.
- Evaluate task quality, groundedness, privacy, safety, latency and cost before promotion; monitor regressions after release.
- Provide human override, bounded retries, timeouts, rate limits, audit trails and rollback.

## Governance artefacts

For material workloads, maintain:
- Architecture Decision Records, threat model and current data-flow diagram.
- Data inventory, classification, purpose, retention, residency and access matrix.
- Privacy impact assessment or equivalent where risk warrants it.
- AI system/model/tool inventory, owner, evaluation results and known limitations.
- Security exceptions with rationale, compensating controls, approver, owner and expiry.
- Incident response plan, restore/rollback instructions and review date.

## Australian context

For Australian deployments, assess applicability rather than assuming every law or control applies:
- [OAIC Australian Privacy Principles](https://www.oaic.gov.au/privacy/australian-privacy-principles)
- [OAIC Notifiable Data Breaches scheme](https://www.oaic.gov.au/privacy/notifiable-data-breaches)
- [ASD Information Security Manual](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/ism)
- [ASD Essential Eight](https://www.cyber.gov.au/resources-business-and-government/essential-cyber-security/essential-eight)
- [Australian AI Ethics Principles](https://www.industry.gov.au/publications/australias-artificial-intelligence-ethics-framework/australias-artificial-intelligence-ethics-principles)

Also assess the Privacy Act 1988, state/territory privacy laws, health-records requirements, contracts and overseas laws where relevant. Obtain qualified legal/privacy advice for regulated or high-risk use cases.

## Microsoft and cloud guidance

- [Microsoft Foundry responsible AI](https://learn.microsoft.com/en-us/azure/ai-foundry/responsible-use-of-ai-overview)
- [Foundry model data privacy](https://learn.microsoft.com/en-us/azure/ai-foundry/responsible-ai/openai/data-privacy)
- [Azure Well-Architected AI workloads](https://learn.microsoft.com/en-us/azure/well-architected/ai/)
- [GitHub Actions secure use](https://docs.github.com/en/actions/reference/security/secure-use)

## Definition of done

A release is not ready until applicable privacy, security and governance controls are evidenced, exceptions are approved and time-bound, the operational owner accepts residual risk, and monitoring and incident response are in place.
