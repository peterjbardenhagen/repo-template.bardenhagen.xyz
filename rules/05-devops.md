# DevOps — Agent Skill File

**Role:** Infrastructure, CI/CD & Deployment  
**Trigger:** When setting up deployment, managing infrastructure, or configuring CI/CD.

## Responsibilities

- Set up and maintain CI/CD pipelines
- Manage infrastructure as code
- Configure monitoring and observability
- Handle deployment and release management
- Ensure security best practices in infrastructure
- Maintain GitHub Actions workflows with least-privilege permissions
- Automate dependency updates with Dependabot or Renovate

## CI/CD Pipeline

### Workflow Structure (2026 Best Practices)

```yaml
name: CI
on: [push, pull_request]

concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: true

permissions:
  contents: read

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@b4ffde65f46336ab88eb53be808477a3936bae11 # v4.3.1
      - run: npm ci
      - run: npm run lint
      - run: npm test
      - run: npm run build
```

### Pipeline Stages
1. **Lint** — Code style and quality checks
2. **Test** — Unit, integration, and property-based tests
3. **Build** — Compile and package
4. **Security Scan** — CodeQL, dependency review, container scan
5. **Deploy** — Deploy to target environment (preview or production)

## Vercel Deployment

- **Preview:** `deploy-preview.yml` deploys every PR and comments the URL
- **Production:** `deploy-prod.yml` deploys `main` with environment protection rules
- **Secrets:** Configure `VERCEL_TOKEN`, `VERCEL_ORG_ID`, `VERCEL_PROJECT_ID`
- **OIDC:** See `docs/vercel-oidc.md` for Vercel OIDC Federation setup

## Container Registry

- **GHCR:** `ghcr-push.yml` builds multi-arch images on push to main and tags
- **Path filtering:** Lockfile changes to `src/` and `tests/` trigger full CI
- **Authentication:** Uses built-in `GITHUB_TOKEN` with `packages: write`

## Infrastructure Principles

- **Infrastructure as Code** — All infrastructure defined in version control
- **Immutable deployments** — Deploy fresh artifacts, never patch running servers
- **Least privilege** — Minimum IAM permissions required; least-privilege `GITHUB_TOKEN`
- **Secrets management** — Use GitHub Secrets or Vercel env vars, never commit secrets
- **Observability** — Logs, metrics, and traces for every service
- **Supply-chain hardening** — Pin action SHAs, enable Dependency Review, use OIDC where possible

## Dependency Automation

Two options are included:
- **Dependabot:** `.github/dependabot.yml` — native GitHub, auto-merge for patch/minor
- **Renovate:** `.github/renovate.json` — more configurable, supports package grouping

Choose one and delete the other's config to avoid duplicate PRs.

## Environment Variables

Document all required environment variables in `.env.example`. Never commit actual secrets.

## Deployment Targets

*Add your deployment targets here:*
- **Production:** [e.g., Vercel, Azure App Service, Docker]
- **Staging:** [e.g., Preview deployments, staging slots]
- **Development:** [e.g., local Docker Compose, .devcontainer]
