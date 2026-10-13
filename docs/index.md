---
title: Documentation
---

# Repo Template Documentation

A practical, security-conscious starter for software teams using AI coding agents across the software delivery lifecycle.

Use this guide to find the right standard, workflow, or setup instruction.

**Maintainer:** [Peter Bardenhagen — profile](https://peter.bardenhagen.xyz/) · [LinkedIn](https://au.linkedin.com/in/peterbardenhagen)

## Make this your repository template

Create a new repository from this template, then copy the prompt below into your preferred coding agent. The docs site supports copying code blocks using the copy icon.

[**Create a repository and copy the agent prompt →**](engineering/make-this-your-repo-template.md) · [MCP and agent skills](engineering/mcp-and-agent-skills.md) · [Review MCP configuration](https://github.com/peterjbardenhagen/repo-template.bardenhagen.xyz/blob/main/.mcp.json)

```text
Set up this repository using the Repo Template engineering contract. First read AGENTS.md, README.md, CONTRIBUTING.md, SECURITY.md and the relevant docs. Inspect the existing project before changing it. Adapt the template to the actual stack and requirements; do not blindly overwrite existing conventions. Identify the applicable skills under .agents/skills and follow their instructions. Keep secrets out of files and logs. Use least-privilege credentials and short-lived identity where supported. Propose a plan and acceptance criteria, implement on a feature branch, run relevant tests and security checks, and open a pull request with evidence. Do not bypass branch protections, approve your own PR, expose secrets, or deploy destructive changes without explicit human approval.
```

## Start here

- [Agentic AI ways of working](agentic/ways-of-working.md) — lifecycle, human/agent responsibilities, review, release, security, and retrospectives.
- [Use the template](engineering/using-the-template.md) — create a repository from this template or retrofit an existing repository safely.
- [Make this your repo template](engineering/make-this-your-repo-template.md) — GitHub CLI setup, agent prompt with copy control, and optional MCP setup.
- [GitHub CLI and secret management](engineering/github-cli-and-secret-management.md) — secure auth, Key Vault, Doppler, expiry and rotation.
- [Vercel, Node.js and AI Gateway](cloud/vercel-nodejs-ai-gateway.md) — Node.js setup, AI SDK, gateway and production security.
- [Repository settings and GitHub features](engineering/github-settings-and-features.md) — recommended settings, Pages, Discussions, security, automation, and governance.

## Engineering

- [Git workflow](engineering/git-workflow.md)
- [Agentic SDLC](agentic/sdlc.md)
- [Security guide](security/guide.md)
- [Privacy, governance and security](security/privacy-governance-and-security.md)
- [Foundry Local and Ollama](cloud/local-llm-platforms.md)
- [Accessibility](quality/accessibility.md)
- [Architecture decisions](decisions/)

## How to use this documentation

Read the relevant guidance, then adapt it to the actual project. This repository is a starter template, not a mandate to enable every feature in every derived repository. Keep only the controls that fit the project's risk, team size, hosting model, and delivery needs.

For code changes, use GitHub Issues for work that needs tracking and Pull Requests for reviewable changes. Use GitHub Discussions for questions, proposals, and community conversations that do not need to become tracked work.

[Open the source repository](https://github.com/peterjbardenhagen/repo-template.bardenhagen.xyz) · [Discussions](https://github.com/peterjbardenhagen/repo-template.bardenhagen.xyz/discussions)
