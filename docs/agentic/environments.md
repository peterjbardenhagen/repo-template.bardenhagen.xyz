# Standard Software Development Environments

This document defines the standard environment tiers and naming conventions for all projects in this organization.

## Environment Tiers

### Local / Dev (Developer Machine)
- **Scope**: Individual developer's machine
- **Entry points**:
  - `npx run dev` / `npm run dev` (Node.js projects)
  - `dotnet run` / Kestrel (ASP.NET Core)
  - IIS website (for IIS-hosted applications)
- **DNS pattern**: `dev.{subdomain}.{domain}` (e.g., `dev.classic.yourdomain.com`)
- **Infrastructure**: Can point to developer's machine via Tailscale DNS (e.g., `dev-machine.yourdomain.com` → `pb-legion`'s Tailscale DNS name)

### UAT (User Acceptance Testing)
- **Scope**: Shared staging environment for testing
- **DNS pattern**: `uat.{subdomain}.{domain}` (e.g., `uat.classic.yourdomain.com`)
- **Deployment**: Manual or automated from feature/release branches
- **Note**: Not all projects have a UAT environment

### Production
- **Scope**: Live customer-facing environment
- **DNS pattern**: `{subdomain}.{domain}` (e.g., `classic.yourdomain.com`)
- **Deployment**: Auto-deploy from `main` branch
- **Requirement**: All projects must have production deployment configured

## Branching Standards

| Requirement | Standard |
|------------|----------|
| Default branch | `main` (case-sensitive) |
| Legacy branch | `master` (must not exist) |
| Branch naming | `feat/`, `fix/`, `chore/`, `docs/` prefixes |

### Master Branch Handling
- **No `master` branch should exist** in any repository
- If `master` appears (legacy, fork, etc.):
  1. Auto-merge any worthwhile changes to `main`
  2. Delete `master` branch
  3. Update Vercel/hosting provider to use `main` as production branch
  4. Update all coding tools/CI configuration to reference `main`

## Hosting Provider Configuration

### Vercel
- Production branch: `main`
- Preview deployments: All non-`main` branches
- Remove `master` from branch list if present

### Other Providers (Netlify, Azure Static Web Apps, etc.)
- Apply same `main` branch standard
- Configure auto-deploy from `main` only

## Project-Specific Variations

| Project Type | Local/Dev | UAT | Production |
|--------------|-----------|-----|------------|
| Node.js (Next.js, Vite, etc.) | `npm run dev` | Optional | Auto from `main` |
| ASP.NET Core | Kestrel / IIS | Optional | Auto from `main` |
| Static Sites | `npx serve` / local server | Optional | Auto from `main` |
| Legacy IIS Apps | IIS on dev machine | Optional | Auto from `main` |

## DNS Resolution Examples

```
dev.classic.yourdomain.com
  → dev-machine.yourdomain.com
  → pb-legion's Tailscale DNS name
  → Developer's local machine

uat.classic.yourdomain.com
  → Shared UAT server

classic.yourdomain.com
  → Production (Vercel/Azure/IIS)
```

## Enforcement Checklist

- [ ] Default branch is `main` (not `master`)
- [ ] No `master` branch exists
- [ ] Vercel/hosting configured for `main` branch production deploys
- [ ] CI/CD pipelines reference `main` branch
- [ ] Local dev commands documented in README
- [ ] DNS records follow naming convention
- [ ] Tailscale/local tunnel configured for dev hostnames (if applicable)