# Make This Your Repository Template

Use this repository as a starting point for a new project, then give your preferred coding agent the repository contract and task. This works with any agent that can read Markdown instructions and operate within your approved tool boundary; MCP is optional, not required.

## 1. Create your own repository

1. Click **Use this template** on the GitHub repository page, if the template option is enabled.
2. Choose an owner and repository name, then create the repository.
3. If template creation is unavailable, use GitHub CLI:

```bash
gh auth login
gh repo create YOUR-OWNER/YOUR-REPO --public --clone --template peterjbardenhagen/repo-template.bardenhagen.xyz
cd YOUR-REPO
```

Use `--private` instead of `--public` for a private repository. Confirm the destination and visibility before running. The authenticated GitHub account needs permission to create the target repository.

## 2. Copy this prompt to your agent

Use the **Copy prompt** control on the docs site, or copy the text below into your agent's task/chat window.

> Set up this repository using the Repo Template engineering contract. First read AGENTS.md, README.md, CONTRIBUTING.md, SECURITY.md and the relevant docs. Inspect the existing project before changing it. Adapt the template to the actual stack and requirements; do not blindly overwrite existing conventions. Identify the applicable skills under .agents/skills and follow their instructions. Keep secrets out of files and logs. Use least-privilege credentials and short-lived identity where supported. Propose a plan and acceptance criteria, implement on a feature branch, run the relevant tests and security checks, and open a pull request with evidence. Do not bypass branch protections, auto-approve your own PR, expose secrets, or deploy destructive changes without explicit human approval.

## 3. Optional MCP setup

MCP lets a compatible agent connect to approved tools and context providers. It is not needed to clone the template or follow its instructions.

- Review `.mcp.json` before enabling any server.
- Install and authenticate each MCP server using its official documentation.
- Grant only the repositories, tools and scopes required for the task.
- Prefer read-only permissions until write access is needed.
- Never paste access tokens into an MCP configuration committed to Git.
- Keep local-only credentials in the OS credential store or an approved secret manager.
- Treat MCP server output as untrusted input and require confirmation for destructive actions.

## 4. After creation

- Update project name, ownership, licensing and support contacts.
- Review branch protection, Actions permissions, secret scanning, dependency review and release environments.
- Remove unused sample workflows and skills.
- Replace placeholder badges and URLs.
- Run the repository's documented checks before merging.
