---
name: ai-security-testing
description: Threat-model and test AI agents, MCP tools, prompts, retrieval, dependencies and deployment pipelines. Use for AI security reviews and release-readiness testing.
---

# AI Security Testing Skill

## Safety boundary

Use a dedicated test environment with synthetic data. Do not run destructive tests, exploit production systems, access data outside the authorised scope, or disable security controls without explicit approval.

## Workflow

1. Identify assets, identities, trust boundaries, entry points, tools, data flows and side effects.
2. Threat-model prompt injection, indirect injection, sensitive-data disclosure, excessive agency, tool abuse, identity confusion, supply-chain compromise and denial of service.
3. Define risk-based test cases and expected safe outcomes before execution.
4. Test least privilege, authentication, authorisation, tenant isolation, approval gates, logging, rate limits, retries and circuit breakers.
5. Run dependency, secret, static-analysis, IaC/container and API security checks relevant to the stack.
6. Evaluate AI outputs for groundedness, policy adherence, refusal behaviour, data leakage and regression.
7. Report reproducible evidence, severity, affected version, mitigation, owner and retest result.

## Required test families

- Direct/indirect prompt injection and hostile retrieved content.
- Attempts to reveal prompts, credentials, private files or cross-tenant information.
- Tool name/schema spoofing, malicious tool descriptions, invalid arguments and server identity changes.
- Unapproved writes, privilege escalation, destructive calls and external side effects.
- Expired/revoked credentials, scope changes and user-vs-service identity boundaries.
- Command/path/HTML/Markdown injection and unsafe generated code handling.
- Timeout, malformed output, retry storm, resource exhaustion and rate limiting.
- Audit completeness without leaking secrets into logs.
- Dependency typosquatting signals, lockfile integrity, action SHA pins and untrusted build artifacts.

## Release gates

- No unmitigated critical/high exploitable issue unless an authorised, time-limited exception is recorded.
- No secrets in source, logs, artifacts, prompts or test output.
- High-impact tool actions are gated by independent policy or human approval.
- Evaluation thresholds, monitoring, incident response and rollback are documented and tested.
- Findings are tracked to closure or have an approved exception owner and expiry.

## References

- https://modelcontextprotocol.io/specification/draft/basic/security_best_practices
- https://docs.github.com/en/actions/security-for-github-actions/security-guides/security-hardening-for-github-actions
- https://owasp.org/www-project-top-10-for-large-language-model-applications/
- https://learn.microsoft.com/en-us/azure/well-architected/ai/responsible-ai
