---
name: vercel-deploy
description: Deploy to Vercel with environment switching (prod/dev/preview). Creates site if needed, ensures build works, and verifies accessibility. Installs Vercel CLI if missing. Defaults to Windows, falls back to Linux.
---

# Vercel Deploy

Deploy a project to Vercel with environment-aware configuration. Creates the site if it does not exist, otherwise deploys to the existing project. Ensures the build succeeds and the deployed site is accessible.

## Arguments

- `$1` — Target environment: `prod`, `dev`, or `preview`
  - Default: `preview`

## Prerequisites

- Node.js and npm available
- Vercel account and token (`VERCEL_TOKEN` or `vercel login`)
- Working directory is the repository root

## Workflow

1. **Detect environment**
   - If `$1` is provided, use it as the target environment.
   - Otherwise default to `preview`.

2. **Install Vercel CLI if missing**
   - **Windows**:
     ```powershell
     if (-not (Get-Command vercel -ErrorAction SilentlyContinue)) { npm install -g vercel }
     ```
   - **Linux/macOS**:
     ```bash
     if ! command -v vercel &> /dev/null; then npm install -g vercel; fi
     ```

3. **Authenticate Vercel**
   ```bash
   vercel whoami || vercel login
   ```
   - If not authenticated, prompt for token or login flow.

4. **Check if Vercel project exists**
   ```bash
   vercel project ls
   ```
   - Parse the output to find a project matching the current repo name or domain.

5. **If project does not exist, create it**
   ```bash
   vercel project add <PROJECT_NAME>
   ```
   - Link the local project:
     ```bash
     vercel link
     ```
   - Configure environment variables as needed (non-interactive if possible):
     ```bash
     vercel env add <KEY> <value> --environment <ENV>
     ```

6. **Run build locally first**
   ```bash
   npm run build
   ```
   - If build fails, report error and stop.
   - For Windows, prefer PowerShell or CMD equivalents.

7. **Deploy to the target environment**
   - **Preview**:
     ```bash
     vercel
     ```
   - **Dev**:
     ```bash
     vercel env pull .env.local
     vercel dev
     ```
     Or for a remote dev deployment:
     ```bash
     vercel deploy --environment=preview --target=development
     ```
   - **Prod**:
     ```bash
     vercel --prod
     ```

8. **Verify site accessibility**
   - Get the deployment URL:
     ```bash
     vercel ls
     ```
   - Probe the URL with a HEAD request and verify HTTP 200:
     ```bash
     curl -s -o /dev/null -w "%{http_code}" <DEPLOYMENT_URL>
     ```
   - If the response is not 200, report the failure and capture output:
     ```bash
     curl -v <DEPLOYMENT_URL>
     ```

9. **Report deployment**
   - Output the deployment URL, environment, and accessibility status.
   - If the site is not accessible, provide diagnostic details and suggest next steps.

## Error Handling

- If `vercel` CLI installation fails on Windows, fall back to Linux commands (`npm install -g vercel`).
- If `vercel login` is required and non-interactive, prompt for `VERCEL_TOKEN` environment variable.
- If build fails, do not proceed to deploy; fix the build error first.
- If deployment URL returns non-200, treat as failure and report curl diagnostics.
- If the project already exists but is linked to a different repo, confirm with the user before overwriting.

## Environment Variables

Common variables to configure on the Vercel project:
- `VERCEL_TOKEN` — Vercel authentication token
- `VERCEL_ORG_ID` — Organization ID (for team deployments)
- `VERCEL_PROJECT_ID` — Project ID
