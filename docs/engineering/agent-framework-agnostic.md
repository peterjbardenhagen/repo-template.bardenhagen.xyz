# Agent-Framework-Agnostic Development

This template is not tied to Claude Code, OpenCode, Aider, a specific vendor, CLI, IDE, protocol or orchestration framework. It should work with any coding agent that can read repository instructions and operate within an approved tool boundary, and it must support human-only development.

## Compatibility model

- **Repository instructions:** AGENTS.md is the cross-tool baseline. Add provider-specific files only when needed, and keep them thin pointers to the canonical instructions.
- **Skills:** portable Markdown skill files with clear metadata, scope, prerequisites, safe operating boundaries and verification steps.
- **Tools and context:** MCP where the client supports it, plus ordinary CLI, APIs, browser testing and documented manual alternatives.
- **Change delivery:** branches, issues/specifications, tests, pull requests, reviews and release gates remain the same regardless of which agent authored the change.
- **Model/provider routing:** use provider adapters and explicit policy; never assume all agents or models support identical context, tool calling or structured output.
- **Human workflow:** every task can be completed or reviewed by a developer without a specific AI client.

## Agent lifecycle

\`\`\`mermaid
flowchart LR
    Request[Issue / user request] --> Context[Repository instructions and relevant skills]
    Context --> Plan[Plan and acceptance criteria]
    Plan --> Work[Agent or human implementation]
    Work --> Tests[Automated tests and security checks]
    Tests --> Review[Independent review and human accountability]
    Review --> PR[Pull request and merge policy]
    PR --> Release[Controlled release and observation]
\`\`\`

## Suggested repository layout

\`\`\`text
AGENTS.md
.agent/
  README.md
  profiles/
    agent-profile.example.yaml
  policies/
    tool-policy.example.yaml
  prompts/
    implementation.md
    review.md
    security-review.md
.agents/
  skills/
    skill-name/
      SKILL.md
.github/
  ISSUE_TEMPLATE/
  PULL_REQUEST_TEMPLATE.md
  workflows/
docs/
  architecture/
  security/
  engineering/
\`\`\`

This is a suggested layout. Existing project conventions take precedence; do not duplicate instructions when a link to the canonical source is enough.

## Portable skill contract

A skill should state:
1. Name and one-sentence purpose.
2. Clear triggers for when it should be used.
3. Required context, permissions, dependencies and tools.
4. Step-by-step workflow.
5. Security/privacy boundaries and prohibited actions.
6. Verification and acceptance criteria.
7. Expected output and authoritative references.
8. Maintainer, source, licence and review date when imported externally.

Prefer concise, vendor-neutral Markdown. If a skill requires provider-specific functionality, declare it explicitly and provide a manual or alternate-client path where practical. Never install external skills automatically without review.

## Agent permission tiers

| Tier | Allowed activity | Default controls |
|---|---|---|
| 0 — Read | Inspect code, docs, issues and logs | No writes or external side effects |
| 1 — Draft | Edit local files, write tests, create a branch | Diff review, tests, no production credentials |
| 2 — PR | Push branch, open/update PR | Scoped token, branch protections, required checks |
| 3 — Operate | Deploy, change infrastructure, modify production data | Explicit approval, environment gates, audit trail and rollback |
| 4 — Admin | Change permissions, secrets, branch rules or repository ownership | Separate human administrator approval; never autonomous by default |

An agent cannot elevate its own permissions by editing repository instructions or asking another tool to do so.

## Provider integration checklist

- [ ] Can the agent read AGENTS.md and relevant skills?
- [ ] Are supported tools and permissions declared?
- [ ] Is there a safe read-only mode?
- [ ] Are untrusted tool outputs treated as data, not policy?
- [ ] Can the agent run project tests and report evidence?
- [ ] Are write, merge, deployment and admin actions gated?
- [ ] Can a human reproduce and review the change without the same agent?
- [ ] Are provider-specific prompts/configuration kept separate from the canonical standard?
