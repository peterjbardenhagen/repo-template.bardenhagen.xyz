# Using Repo Template for a New or Existing Repository

This guide explains how to adopt [repo-template.bardenhagen.xyz](https://repo-template.bardenhagen.xyz) as the starting point for a GitHub repository.

## Choose the right path

| Situation | Recommended path |
|---|---|
| Creating a new repository | Use GitHub's **Use this template** workflow. This is the intended, clean bootstrap path. |
| Repository already exists | Run the retrospective adoption prompt below in your coding agent. Review and apply changes incrementally. |
| Need future template updates | Treat the template as a starter, not a live upstream sync. Deliberately cherry-pick or port improvements after assessing conflicts and project fit. |

**Important:** GitHub template selection happens when creating a repository. It does not retrofit an existing repository, and the new repository does not automatically stay synchronised with the template. For an existing repo, use the retrospective prompt in this guide.

## A. Create a repository from the template

1. Sign in to GitHub with the account or organisation that should own the new repository.
2. Open [peterjbardenhagen/repo-template.bardenhagen.xyz](https://github.com/peterjbardenhagen/repo-template.bardenhagen.xyz).
3. Select **Use this template → Create a new repository**.
4. Choose the owner, repository name, visibility, and any other requested settings. Use a descriptive, kebab-case name unless the project has an established convention.
5. Create the repository. If GitHub offers the option to include all branches, use the default branch unless you have a specific reason to copy template history.
6. Clone the new repository locally and open it in your preferred IDE or AI coding tool.
7. Start with `AGENTS.md`, then read `README.md`, `CONTRIBUTING.md`, and the relevant guides under `docs/`.
8. Run the repository's existing validation scripts before making changes. Record any baseline failures so they are not confused with regressions.

Example:

```bash
git clone https://github.com/<owner>/<new-repository>.git
cd <new-repository>
git status
```

## B. Bootstrap the generated repository before feature work

A template provides defaults, not finished project configuration. Have the team or agent review each of these:

- [ ] Replace template-specific names, URLs, badges, ownership, and sample text with project-specific values.
- [ ] Complete project context, product purpose, users, supported environments, and non-goals in the designated project docs.
- [ ] Confirm the stack, package manager, build commands, test commands, linting, type checks, and local development instructions.
- [ ] Review agent instructions for relevance; keep one canonical policy and avoid conflicting tool-specific copies.
- [ ] Review `.github/workflows/` and remove or adapt workflows that do not fit the project.
- [ ] Configure repository secrets, environments, deployment targets, permissions, and OIDC/secret-manager integration. Never commit actual secrets.
- [ ] Review `CODEOWNERS` and replace example or placeholder owners with real GitHub users/teams.
- [ ] Configure branch protection or rulesets for `main`: required checks, PR requirements, review policy, and appropriate bypass restrictions.
- [ ] Confirm licence, security reporting contact, contribution policy, dependency automation, and release/versioning strategy.
- [ ] Configure issue and PR templates, labels, project board, and team responsibilities.
- [ ] Create initial backlog items with acceptance criteria and priorities.
- [ ] Run the full applicable test/build/security checks and verify the actual deployment path before treating the repo as production-ready.

Do not blindly enable every workflow or copy every integration. Review permissions, third-party actions, costs, runtime requirements, and the project's threat model first.

## C. Recommended first AI session

Give the agent this task after cloning the newly created repository:

> Read AGENTS.md and the relevant template documentation first. Bootstrap this repository for its actual product without implementing a feature yet. Inspect the complete tree and Git state. Identify template placeholders, stale names/URLs, unsupported assumptions, mismatched scripts, unconfigured secrets, workflows, CODEOWNERS, branch governance, docs, and test gaps. Propose a prioritised plan, distinguish safe edits from decisions requiring my approval, then make only the agreed bootstrap changes. Do not expose or invent secrets. Run available checks and report evidence and blockers.

## D. Retrospectively adopt the ways of working in an existing repository

Do **not** replace the repository with the template or copy every file over the top. Existing repositories may contain product-specific conventions, workflows, licences, deployment rules, and user changes. Use a coding agent with this prompt, from the root of the existing repository.

### Copy/paste prompt

```text
You are the senior engineer responsible for safely adopting the engineering and agentic AI ways of working from:
https://repo-template.bardenhagen.xyz
Source repository: https://github.com/peterjbardenhagen/repo-template.bardenhagen.xyz

TARGET: the current repository open in this workspace.

OBJECTIVE
Retrospectively assess and incrementally adopt the relevant practices from the template without overwriting working product code, erasing history, weakening security, or breaking existing delivery.

MANDATORY PROCESS
1. Inspect the current Git branch and working tree. Preserve all uncommitted and untracked user work. Do not reset, clean, force-push, or discard changes.
2. Read the target repository's AGENTS.md and project documentation first. Then inspect its full structure, package/build scripts, CI workflows, tests, deployment configuration, security controls, CODEOWNERS, branch conventions, issue/PR templates, and existing team practices.
3. Inspect the source template documentation, especially:
   - docs/agentic/ways-of-working.md
   - docs/engineering/template-guide.md
   - docs/engineering/git-workflow.md
   - docs/engineering/github-standards.md
   - docs/agentic/e2e-sdlc.md
   - AGENTS.md and CONTRIBUTING.md
4. Produce an adoption assessment grouped into:
   A. Keep existing (already good or project-specific)
   B. Adopt now (low-risk and clearly beneficial)
   C. Adapt (requires changes for this stack/team)
   D. Human decision required (permissions, production, costs, licensing, security policy, migrations, or other high-impact choices)
   E. Do not adopt (irrelevant or conflicting)
   For each recommendation, include rationale, affected files, risk, dependencies, and validation.
5. Propose a staged plan with small, reviewable batches. Do not blindly copy template files or assume every tool, workflow, language, provider, or script applies.
6. Ask for approval before destructive, security-sensitive, access-control, production, data-migration, paid-service, licence, or broad architectural changes. Continue with safe, reversible improvements that are clearly within scope.
7. Implement the agreed changes in a short-lived branch. Merge template guidance into existing instructions rather than creating conflicting agent policies. Preserve project-specific requirements and the single source of truth for each rule.
8. Add or adapt the appropriate artefacts where useful: project context, ways of working, ADRs, issue/PR templates, CODEOWNERS, CI quality gates, security guidance, test scripts, documentation, and status/handoff notes.
9. Never introduce real secrets. Use placeholders and the project's approved secret manager. Do not weaken existing controls to make tests or deployments pass.
10. Run all relevant available checks: formatting, lint, type-check, unit/integration/e2e tests, build, dependency/security checks, and documentation validation. For UI changes, test important flows and desktop/tablet/mobile layouts where the environment supports it.
11. Separate pre-existing failures from regressions. Do not claim a check passed unless you ran it and observed the result. Clearly list checks blocked by missing credentials, services, or environments.
12. Open a focused PR with the assessment, summary, tests/evidence, risks, screenshots if useful, and rollout/rollback notes. Do not merge or deploy to production unless the repository's policy and my explicit authorisation permit it.

DEFINITION OF DONE
- Existing user work is preserved.
- Adopted practices fit the real stack and product.
- Agent instructions are consistent and discoverable.
- Security and branch governance are at least as strong as before.
- Changes are small, documented, tested, and reviewable.
- Remaining decisions and gaps have named next actions.
- Final report distinguishes implemented, tested, not tested, and awaiting approval.

Begin with inspection and the assessment. Do not immediately copy files or rewrite the repository.
```

## E. Keep future template improvements deliberate

A repository created from a template is independent after creation. To benefit from future improvements:

1. Review the template's changelog and relevant diff.
2. Select changes that solve a real need in the target repository.
3. Port them in a separate branch, adapting rather than overwriting.
4. Run target-repository checks and security review.
5. Merge through the target repository's normal PR policy.

Avoid periodic wholesale copies: they can erase product decisions, introduce irrelevant automation, or weaken controls.
