# Next.js Project Seed

Use this seed when creating a new Next.js project from the template.

## Files to Add After Init

```bash
npx create-next-app@latest . --typescript --tailwind --app --src-dir
```

## Template Integration Checklist

- [ ] Run `bash scripts/init-project.sh <project-name>` or use GitHub template clone
- [ ] `npx create-next-app@latest . --typescript --tailwind --app --src-dir`
- [ ] Update `AI_CONTEXT.md` — stack to "Next.js / TypeScript / Node.js 20+"
- [ ] Update `docs/architecture.md` — document app router structure, route groups, layouts
- [ ] Add your Next.js env vars to `.env.example` (NEXT_PUBLIC_*, etc.)
- [ ] Configure `vercel link` to link the local repo to your Vercel project
- [ ] Verify preview deployments by opening a feature branch PR

## Recommended Packages

| Purpose | Package |
|---------|---------|
| Auth (simple) | `next-auth` |
| Auth (enterprise) | `@auth0/nextjs-auth0` or `@azure/msal-react` |
| Forms | `react-hook-form` + `zod` |
| Data fetching | `@tanstack/react-query` |
| Styling | `tailwindcss` (included) |
| Testing | `@playwright/test`, `@testing-library/react` |
