# DevOps — Agent Skill File

**Role:** Infrastructure, CI/CD & Deployment  
**Trigger:** When setting up deployment, managing infrastructure, or configuring CI/CD.

## Responsibilities

- Set up and maintain CI/CD pipelines
- Manage infrastructure as code
- Configure monitoring and observability
- Handle deployment and release management
- Ensure security best practices in infrastructure

## CI/CD Pipeline

### Workflow Structure

```yaml
name: CI
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Install dependencies
        run: npm ci
      - name: Lint
        run: npm run lint
      - name: Test
        run: npm test
      - name: Build
        run: npm run build
```

### Pipeline Stages
1. **Lint** — Code style and quality checks
2. **Test** — Unit and integration tests
3. **Build** — Compile and package
4. **Security Scan** — Dependency and code scanning
5. **Deploy** — Deploy to target environment

## Infrastructure Principles

- **Infrastructure as Code** — All infrastructure defined in version control
- **Immutable deployments** — Deploy fresh artifacts, never patch running servers
- **Least privilege** — Minimum IAM permissions required
- **Secrets management** — Use GitHub Secrets or Azure Key Vault, never commit secrets
- **Observability** — Logs, metrics, and traces for every service

## Deployment Targets

*Add your deployment targets here:*
- **Production:** [e.g., Vercel, Azure App Service, Docker]
- **Staging:** [e.g., Preview deployments, staging slots]
- **Development:** [e.g., local Docker Compose]

## Environment Variables

Document all required environment variables in `.env.example`. Never commit actual secrets.
