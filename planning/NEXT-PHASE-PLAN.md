# Next Phase Plan — Competitive Response + Platform Acceleration

**Date:** July 23, 2026  
**Based on:** Competitive analysis, market research, platform audit  
**Context:** Phase 2 (Persistence & Auth) is in progress. This plan defines Phase 2+ priorities based on market intelligence.

---

## Executive Summary

The AI agent platform market is converging on "AI Operating System" as the category. Every major vendor (Microsoft, Google, IBM, Salesforce, Workday) now positions this way. YOUR_PROJECT_NAME has 3 genuine differentiators that none of them can match:

1. **Local-first + governed cloud burst** (sovereignty)
2. **Evolutionary DAG optimization** (gets smarter with use)
3. **Provenance-gated execution** (hash-chained, tamper-evident)

But we also have gaps. This plan closes them — in order of competitive urgency.

---

## Phase 2+: Close Competitive Gaps (Weeks 1-4)

### 🔴 Sprint 1: SSO & Pricing (Week 1-2)

| Task | Why | Effort |
|------|-----|--------|
| **OIDC/SSO middleware** | Every competitor has this. Required for any enterprise buyer. | 3 days |
| **Publish pricing page** | Competitors hide pricing. We publish transparently. CCL proposal already specifies $149-399. | 1 day |
| **Azure AD / Entra ID connector** | Legal firms run on Microsoft. Must have. | 2 days |

**Deliverable:** `/auth/login` with OIDC. Pricing on marketing site. Entra ID working end-to-end.

### 🔴 Sprint 2: SaaS Hosting Tier (Week 2-4)

| Task | Why | Effort |
|------|-----|--------|
| **Managed cloud deployment** | Not all firms can self-host GPU hardware. Offer Azure-hosted YOUR_PROJECT_NAME. | 2 weeks |
| **Per-tenant isolation** | Already schema-level. Need infra-level separation for managed tier. | 1 week |
| **Usage-based metering** | Track API calls, tokens, agent runs per tenant for billing. | 1 week |

**Deliverable:** `yourproject.com` offers "Managed" deployment option alongside "Self-Hosted."

---

## Phase 3+: Lean Into Differentiators (Weeks 4-10)

### 🟡 Sprint 3: Local-First Sovereignty Marketing (Week 4-5)

| Task | Why |
|------|-----|
| **Redesign marketing site** | Lead with "Your data never leaves your building — unless you choose" |
| **Add local-first comparison** | Side-by-side with Microsoft, Google, IBM |
| **Case study: CCL** | "How Carter Capner Law runs AI on their own hardware" |
| **Sovereignty whitepaper** | Technical deep-dive on data governance, on-prem architecture |

### 🟡 Sprint 4: Evolutionary Engine Showcase (Week 5-7)

| Task | Why |
|------|-----|
| **Wire completed-PDO feedback** | Currently seeds from live tasks. Must seed from completed-PDO corpus. |
| **Publish evolution benchmarks** | "50% faster planning after 10 projects" |
| **Dashboard: learning progress** | Show tenants how much the platform has improved for them |
| **Per-tenant population isolation** | Legal firm's genome stays separate from electrical contractor's |

### 🟡 Sprint 5: Legal Vertical Accelerator (Week 7-10)

| Task | Why | Competitor Reference |
|------|-----|---------------------|
| **Contract review agent** | AI clause extraction, obligation detection, risk scoring | IBM has 150 skills. We need 20 legal ones. |
| **Discovery agent** | Document classification, privilege logging, chronology |
| **Compliance agent** | Automated checklist review, gap analysis |
| **Precedent search agent** | RAG over knowledge base + external legal databases |
| **Legal billing agent** | AI time capture, trust accounting, UTBMS coding |

---

## Phase 4+: Ecosystem & Scale (Weeks 10+)

### 🟢 Sprint 6: Connector Marketplace

| Task | Why |
|------|-----|
| **Curated MCP skill catalog** | Package connectors as "YOUR_PROJECT_NAME Skills" with docs, examples |
| **Published API docs** | OpenAPI spec, SDK stubs for Python/TypeScript |
| **Community contribution guide** | How third parties build and publish skills |
| **Top 10 enterprise connectors** | Xero, MYOB, QuickBooks, Stripe, SendGrid, Twilio, Microsoft Graph, ServiceNow, Jira, Slack |

### 🟢 Sprint 7: Platform Observability

| Task | Why |
|------|-----|
| **Usage dashboard** | Tokens consumed, cost per agent, latency, success rate |
| **Tenant admin console** | User management, role assignment, audit log viewer |
| **SLA monitoring** | Uptime tracking, alerting, incident response runbook |

---

## Competitive Response Roadmap

```
Week 1-2:   🔴 SSO + Pricing
Week 2-4:   🔴 SaaS Hosting Tier
Week 4-5:   🟡 Sovereignty Marketing
Week 5-7:   🟡 Evolution Engine Showcase
Week 7-10:  🟡 Legal Vertical Accelerator
Week 10+:   🟢 Connector Marketplace
Week 10+:   🟢 Platform Observability
```

---

## What We Stop Doing

| Stop | Reason |
|------|--------|
| Android agent development | Not a buying criterion for any current prospect |
| Browser agent development | Not differentiated — Playwright is commodity |
| Raw feature count growth | Competitors drown in features. We need coherence, not count. |
| Multiple verticals at once | Legal is the beachhead. Finance and healthcare wait. |

---

## Key Risks

| Risk | Mitigation |
|------|------------|
| Phase 2 (Persistence & Auth) delayed | Everything depends on this. Secrets rot, auth missing, state in memory. |
| CCL pilot stalls | First legal vertical reference. Must succeed. |
| Microsoft adds on-prem inference capability | Unlikely (cloud is their business model), but monitor. |
| Competitor copies evolution engine | They can copy the algorithm. They can't copy per-tenant accumulated genomes. |
