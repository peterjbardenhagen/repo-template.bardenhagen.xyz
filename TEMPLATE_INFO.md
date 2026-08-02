# Using This Repository as a Template

This repository is designed to be used as a starting point when creating new repositories. Click the **"Use this template"** button on GitHub to generate a fresh copy.

## What Gets Copied

When you create a repo from this template, you receive:

- **Community files** — `README.md`, `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, `LICENSE`
- **Issue & PR templates** — `.github/ISSUE_TEMPLATE/bug_report.md`, `feature_request.md`, `PULL_REQUEST_TEMPLATE.md`
- **Automation** — `.github/workflows/ci.yml`, pre-commit hooks (`.pre-commit-config.yaml`)
- **Developer environment** — `.devcontainer/devcontainer.json` for Codespaces/VS Code
- **Project structure** — `docs/`, `rules/`, `scripts/`, `seeds/`, `templates/` directories
- **Agent configuration** — `AGENTS.md`, `CLAUDE.md`, `CODEX.md`, `.cursorrules`, `.windsurfrules`

## Post-Creation Checklist

After instantiating the template, update the following:

| File | Action |
|------|--------|
| `README.md` | Replace title, description, and project-specific content |
| `LICENSE` | Confirm the license is correct for your project (or replace) |
| `AGENTS.md` | Update project-specific conventions, owner, and rules |
| `CITATION.cff` | Update authors, title, and metadata |
| `.github/CODEOWNERS` | Configure default reviewers and team ownership |
| `.github/workflows/ci.yml` | Adjust language-specific steps and runtime setup |
| `.devcontainer/devcontainer.json` | Adjust extensions and image for your stack |
| `.github/dependabot.yml` | Verify or remove Dependabot configuration |

## Recommended Immediate Steps

1. **Set repository topics** on GitHub — use tags like `domain:<domain>`, `tech:<lang>`, `owner:<team>` for discoverability.
2. **Update the repository description** to reflect your project's purpose.
3. **Configure branch protection** on `main` and set required reviewers.
4. **Run the init script** — `bash scripts/init-project.sh` to automate initial setup.
5. **Run CI** to verify the baseline passes after your edits.

## Repository Naming Conventions

- Use **kebab-case** (lowercase + hyphens, no spaces/underscores).
- Suggested pattern: `<team-or-scope>-<product>-<component>[-<tech>]`
- Example: `payments-api`, `checkout-ui-react`
- Validation regex: `^[a-z0-9]+(-[a-z0-9]+){0,10}$`

## Language-Specific Scaffolding

The template ships with language-agnostic skeletons. To add language-specific scaffolds:

- **Python** — add `requirements.txt`, `pyproject.toml`, `tox.ini`, and a `pytest` skeleton
- **TypeScript/JavaScript** — add `package.json` and `tsconfig.json`
- **C++** — add `CMakeLists.txt` and an example `main.cpp`
- **Ruby** — add a `Gemfile` and test skeleton

See the `seeds/` directory for project-type examples and `rules/` for role-based agent instructions.
