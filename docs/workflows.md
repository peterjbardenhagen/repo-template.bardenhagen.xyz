# GitHub Actions Workflows — Complete Reference

All 10 workflows included in this template, with configuration guide.

---

## 1. ci.yml — Continuous Integration

**Trigger:** Push/PR to main, merge queue
**Purpose:** Lint, build, and test on every change
**Jobs:**
- `action-pins` — Verify all GitHub Actions use pinned SHA commits
- `lint` — Run ESLint/Prettier
- `build` — Compile the project
- `test` — Run Playwright/Jest/xUnit tests
- `gate` — Final status check for branch protection

**Customisation:** Replace `npm ci` and `npm run build` with your stack commands.

---

## 2. codeql-analysis.yml — Security Code Analysis

**Trigger:** Push/PR to main, weekly schedule (Monday noon)
**Purpose:** Static analysis for security vulnerabilities
**Features:**
- Auto-detects languages (JS/TS, Python, C#, Go, Java, Ruby)
- Only analyses languages present in the repo
- Skips analysis if no source files found

**No customisation needed** — works out of the box.

---

## 3. dependabot-auto-merge.yml — Auto-Merge Dependencies

**Trigger:** PR from dependabot[bot]
**Purpose:** Auto-approve and merge patch/minor dependency updates
**Safety:**
- Only triggers for dependabot actor
- Uses `pull_request_target` (safe for dependabot)
- Blocks semver-major updates (requires manual review)

**Required:** Dependabot must be enabled in repo settings.

---

## 4. dependency-review.yml — Dependency Vulnerability Check

**Trigger:** PR to main
**Purpose:** Check new/changed dependencies for known CVEs before merge
**Severity levels:**
- `critical` / `high` — Blocks merge
- `moderate` / `low` — Warning only

**No customisation needed.**

---

## 5. deploy-preview.yml — Vercel Preview Deployment

**Trigger:** PR to main
**Purpose:** Deploy a preview environment for every PR
**Requires secrets:**
- `VERCEL_TOKEN`
- `VERCEL_ORG_ID`
- `VERCEL_PROJECT_ID`

**Features:**
- Checks if secrets are configured (no-ops if not)
- Posts preview URL as PR comment
- Cleans up on PR close

**Setup:** Add Vercel secrets in repo settings.

---

## 6. deploy-prod.yml — Vercel Production Deployment

**Trigger:** Push to main
**Purpose:** Deploy to production on every merge to main
**Requires secrets:** Same as deploy-preview
**Features:**
- Uses Vercel OIDC token when available
- Falls back to VERCEL_TOKEN
- Production deployment (not preview)

**Setup:** Add Vercel secrets in repo settings.

---

## 7. ghcr-push.yml — Container Image Build

**Trigger:** Push to main, version tags, manual
**Purpose:** Build and push Docker image to GitHub Container Registry
**Features:**
- Multi-arch builds (amd64 + arm64)
- Semantic version tags (v1.2.3)
- Branch name tags (main)
- SHA tags (main-abc1234)

**Requires:** Dockerfile in repo root.

---

## 8. security-scan.yml — npm Audit

**Trigger:** Push/PR to main, weekly (Monday 6am UTC)
**Purpose:** Check for known vulnerabilities in npm dependencies
**Features:**
- Uploads scan results as artifact
- Adds results to GitHub Step Summary
- Fails only on actionable high/critical advisories
- Ignores advisories with only semver-major fixes

**No customisation needed.**

---

## 9. stale.yml — Stale Issue/PR Cleanup

**Trigger:** Daily schedule
**Purpose:** Auto-close inactive issues and PRs
**Configuration:**
- Stale after 60 days
- Close after 14 more days
- Exempt: pinned, security, in-progress labels
- Exempt: milestone-assigned items

**No customisation needed.**

---

## 10. auto-assign.yml — PR Auto-Assignment

**Trigger:** PR opened/reopened
**Purpose:** Automatically assign reviewers to new PRs
**Config:** `.github/auto_assign.yml`

**Default config:**
```yaml
addReviewers: true
addAssignees: false
reviewers:
  - peterjbardenhagen
```

**Customisation:** Edit `.github/auto_assign.yml` to add reviewers.

---

## Workflow Comparison Matrix

| Workflow | PR | Push | Schedule | Manual | Secrets |
|----------|:--:|:----:|:--------:|:------:|:-------:|
| ci.yml | ✅ | ✅ | - | - | - |
| codeql | ✅ | ✅ | Weekly | - | - |
| dependabot-auto-merge | ✅ | - | - | - | - |
| dependency-review | ✅ | - | - | - | - |
| deploy-preview | ✅ | - | - | - | VERCEL_* |
| deploy-prod | - | ✅ | - | - | VERCEL_* |
| ghcr-push | - | ✅ | - | ✅ | - |
| security-scan | ✅ | ✅ | Weekly | - | - |
| stale | - | - | Daily | ✅ | - |
| auto-assign | ✅ | - | - | - | - |
