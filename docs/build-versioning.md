# Build Versioning

Every deployed artifact should be able to state which commit it came from.
Without it, "is my fix live?" can only be answered by digging through the host's
dashboard — and the answer is often wrong, because the dashboard shows the
*latest* deployment, not the one currently serving the URL you are looking at.

## The Problem This Solves

A hardcoded version string in a footer drifts silently. It is right on the day
it is written and wrong forever after. The symptom is subtle and expensive: you
ship a fix, reload, still see the bug, and start debugging code that was never
deployed.

The fix is to generate the version at build time from git, and never let a human
touch it.

## Setup

**1. Copy the generator**

```bash
cp templates/scripts/generate-build-info.mjs scripts/
```

**2. Wire it into `package.json`**

```json
{
  "scripts": {
    "predev": "node scripts/generate-build-info.mjs",
    "dev": "next dev",
    "prebuild": "node scripts/generate-build-info.mjs",
    "build": "next build"
  }
}
```

npm runs `pre*` hooks automatically before the matching script, so both local
dev and every production build regenerate the file. There is nothing to
remember.

**3. Ignore the output** — it is a build artifact, not source:

```gitignore
src/generated/
```

> **Committing it is the bug this exists to prevent.** A committed
> `build-info.json` is stale the moment the next commit lands, and it will
> confidently display the wrong commit.

**4. Render it**

```bash
cp templates/components/BuildInfo.tsx src/components/
```

```tsx
import { BuildInfo } from '@/components/BuildInfo';

export function Footer() {
  return (
    <footer>
      <BuildInfo appName="MyApp" />
    </footer>
  );
}
```

Set `NEXT_PUBLIC_REPO_URL` to make the commit hash a link to the diff.

## Output

```json
{
  "version": "2.3.0",
  "commit": "abc1234",
  "commitFull": "abc1234567890abcdef1234567890abcdef1234",
  "branch": "main",
  "buildTime": "2026-08-08T22:00:00.000Z"
}
```

`dirty: true` is added when the working tree had uncommitted changes at build
time — meaning the artifact corresponds to no commit at all. Expected locally;
in CI it means something modified the tree mid-build and is worth investigating.

## Why Env Vars Come Before Git

The generator reads CI environment variables first and only falls back to
`git`:

| Source | Vars |
|---|---|
| Vercel | `VERCEL_GIT_COMMIT_SHA`, `VERCEL_GIT_COMMIT_REF` |
| GitHub Actions | `GITHUB_SHA`, `GITHUB_HEAD_REF`, `GITHUB_REF_NAME` |
| Cloudflare Pages | `CF_PAGES_COMMIT_SHA`, `CF_PAGES_BRANCH` |
| Local | `git rev-parse` |

Build hosts check out shallow and usually detached. `git rev-parse --abbrev-ref HEAD`
returns `HEAD` rather than a branch name, and in a container with no `.git` at
all it fails outright. The env vars are the only reliable source in CI; git is
the only one available locally. Hence both, in that order.

On GitHub Actions, `GITHUB_HEAD_REF` is checked before `GITHUB_REF_NAME` because
on a `pull_request` event the latter is the synthetic merge ref
(`123/merge`), not the branch anyone would recognise.

## Verifying a Deployment

```bash
# What is actually serving right now?
curl -s https://your-app.example.com | grep -o 'v[0-9.]*  ·  [a-f0-9]\{7\}'

# What is at the head of main?
git rev-parse --short origin/main
```

If they differ, the deployment has not finished — or it failed and the host is
still serving the previous build. That is precisely the case a dashboard's green
checkmark hides.

## Vercel Analytics

Vercel projects include **Web Analytics** and **Speed Insights** for free. Both
are zero-config and auto-bound to the project.

### Next.js

Install the official packages:

```bash
npm install @vercel/analytics @vercel/speed-insights
```

Add to `app/layout.tsx`:

```tsx
import { Analytics } from '@vercel/analytics/react';
import { SpeedInsights } from '@vercel/speed-insights/next';

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en">
      <body>
        {children}
        <Analytics />
        <SpeedInsights />
      </body>
    </html>
  );
}
```

### Static / Non-Next.js

Add to the `<head>` of your HTML:

```html
<script defer src="https://analytics.vercel.app/main.js"></script>
<script defer src="https://analytics.vercel.app/speed-insights.js"></script>
```

Both respect Do Not Track and require no secrets.
