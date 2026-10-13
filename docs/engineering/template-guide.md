# Template guide

## Getting started

> *Replace with your project's actual getting-started guide.*

Welcome to your new project! This guide will help you get up and running quickly.

### Prerequisites

- [ ] Git
- [ ] [Language/Framework runtime] (e.g., Node.js 20+, .NET 10, Python 3.11+)
- [ ] [Package manager] (e.g., npm, dotnet, pip)
- [ ] Docker (optional, for containerized development)

### Option 1: Use This Template (Recommended)

```bash
## On GitHub, click "Use this template" to create a new repo, then:
git clone https://github.com/<your-org>/<your-repo>.git
cd <your-repo>
```

### Option 2: Clone and Reset

```bash
git clone https://github.com/peterjbardenhagen/repo-template.bardenhagen.xyz.git my-new-project
cd my-new-project
rm -rf .git && git init && git add -A && git commit -m "chore: initialise from repo-template"
```

### Option 3: Init Script

```bash
bash scripts/init-project.sh my-new-project
```

### Setup

```bash
## Install dependencies
## npm install        # for Node.js
## dotnet restore     # for .NET
## pip install -r requirements.txt  # for Python

## Copy environment variables
cp .env.example .env
## Edit .env with your configuration

## Start development
## npm run dev        # for Node.js
## dotnet watch       # for .NET
## docker compose up  # for Docker
```

### GitHub Setup

1. Push to your new GitHub repository
2. Copy the required secrets under Settings → Secrets and variables → Actions:
   - `VERCEL_TOKEN` — for Vercel preview/production deploys
   - `VERCEL_ORG_ID` — your Vercel team or personal org ID
   - `VERCEL_PROJECT_ID` — the Vercel project ID
3. Configure branch protection on `main`:
   - Require PR before merging
   - Require status checks (CI, CodeQL, Dependency Review)
   - Require linear history (squash merge)

### Vercel Setup

1. Import your repository into Vercel
2. Link it to the repo URL
3. Configure environment variables in Vercel dashboard
4. Push a feature branch to test preview deployments

### Development

```bash
## Run tests
npm test

## Lint code
npm run lint

## Format code
npm run format
```

### Project Structure

```
├── AGENTS.md           # AI agent instructions
├── CLAUDE.md           # Claude-specific config
├── docs/project/context.md       # Project context summary
├── docs/               # Documentation & ADRs
├── rules/              # Role-based agent skill files
├── .github/workflows/  # CI/CD pipelines
├── scripts/            # Automation scripts
├── seeds/              # Project type starter kits
└── src/                # Source code
```

### How to Contribute

This template is open to contributions from humans and AI agents alike.

1. **Read `CONTRIBUTING.md`** — conventions, commit format, PR checklist, and
   the human review loop for template propagation.
2. **Read `AGENTS.md`** — the source of truth for both human and AI-agent
   contributors.
3. **Open an issue** using the templates in `.github/ISSUE_TEMPLATE/` before
   writing code. Discuss the approach first.
4. **Branch from `main`**, commit using Conventional Commits, and ensure CI
   passes before opening a PR.
5. **Update docs in the same PR** — `README.md`, `docs/`, and `CHANGELOG.md`
   for user-facing changes.

### Template Uplifts

If you fixed a structural problem in a downstream project that would recur in
any project built from this template, use the **Template Uplift** issue template
to propose promoting the fix into the template. Two tests must pass:

1. **It would recur** — the cause is structural, not specific to one project's
   data, domain, or design.
2. **It is stateable as a rule** — "never X, always Y", applicable by someone
   who never saw the original bug.

### Next Steps

- Read `docs/agentic/sdlc.md` for the autonomous development workflow
- Read `AGENTS.md` for AI agent instructions
- Configure your editor with the `.editorconfig` and `.cursorrules`
- Set up GitHub repository secrets for CI/CD
- Explore the seed for your stack in `seeds/`

## Using the template

### Overview
This guide provides the standards and best practices for building marketing websites for all Bardenhagen projects. Based on the MyDesk marketing website implementation, these standards ensure:

- ✅ Performance (Lighthouse 95+)
- ✅ SEO Excellence (Top rankings)
- ✅ Accessibility (WCAG 2.1 AA)
- ✅ Security (OWASP Top 10)
- ✅ User Experience (Engaging interactions)

---

### Quick Start

#### 1. Clone Template
```bash
git clone https://github.com/peterjbardenhagen/repo-template.bardenhagen.xyz.git
cd project-name
npm install
```

#### 2. Configure Environment
```bash
cp .env.example .env.local
## Update with your values:
## - Google Analytics ID
## - API endpoints
## - Email credentials
## - Database URLs
```

#### 3. Customize
```bash
## Update project name
sed -i 's/MyDesk/YourProject/g' package.json app/layout.tsx

## Update branding colors in globals.css
## Update logo in public/logo.png
## Update favicon in public/favicon.ico
```

#### 4. Run Tests
```bash
npm run type-check
npm run lint
npm run build
```

---

### Project Structure

```
project/
├── app/
│   ├── components/        # Reusable components
│   ├── lib/
│   │   ├── analytics.ts   # Event tracking
│   │   └── utils.ts       # Utilities
│   ├── hooks/             # Custom React hooks
│   ├── styles/            # Global CSS
│   ├── page.tsx           # Home page
│   └── layout.tsx         # Root layout
├── public/                # Static assets
├── docs/
│   ├── MARKETING_STANDARDS.md
│   ├── SEO_CHECKLIST.md
│   ├── SECURITY_GUIDE.md
│   ├── ACCESSIBILITY_GUIDE.md
│   └── IMPLEMENTATION_CHECKLIST.md
├── .env.example           # Environment template
├── CLAUDE.md              # Claude Code instructions
└── package.json           # Dependencies

```

---

### Component Templates

#### 1. Hero Section
```tsx
'use client';

import { motion } from 'framer-motion';
import Link from 'next/link';

export default function Hero() {
  return (
    <section className="relative min-h-dvh flex items-center doc-grid overflow-hidden pt-28 pb-20 px-6">
      {/* Ambient glow effects */}
      <div className="absolute inset-0 pointer-events-none">
        <div className="absolute top-1/4 left-1/3 w-[800px] h-[800px] bg-[rgba(232,201,90,0.03)] rounded-full blur-[160px]" />
      </div>

      <div className="relative z-10 max-w-7xl mx-auto w-full">
        <motion.div
          initial={{ opacity: 0, y: 30 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8 }}
        >
          <h1 className="font-['Playfair_Display'] text-6xl font-black text-white mb-4">
            Your Business,{' '}
            <span className="text-gradient-gold">Transformed</span>
          </h1>

          <p className="text-lg text-[#6b7280] max-w-2xl mb-8">
            Your value proposition here. Compelling copy that resonates.
          </p>

          <div className="flex gap-4">
            <Link href="/demo" className="doc-btn-primary">
              Get Started
            </Link>
            <Link href="#features" className="doc-btn">
              Learn More
            </Link>
          </div>
        </motion.div>
      </div>
    </section>
  );
}
```

#### 2. Feature Section with Cards
```tsx
'use client';

import { motion } from 'framer-motion';
import InteractiveFeatureCard from './InteractiveFeatureCard';

const features = [
  {
    icon: '✨',
    title: 'Feature One',
    description: 'Brief description',
    details: ['Benefit 1', 'Benefit 2', 'Benefit 3'],
  },
  // ... more features
];

export default function Features() {
  return (
    <section className="py-24 px-6">
      <div className="max-w-7xl mx-auto">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          className="text-center mb-16"
        >
          <h2 className="doc-heading text-4xl mb-4">Powerful Features</h2>
        </motion.div>

        <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
          {features.map((feature) => (
            <InteractiveFeatureCard key={feature.title} {...feature} />
          ))}
        </div>
      </div>
    </section>
  );
}
```

#### 3. Analytics Integration
```tsx
// app/components/Analytics.tsx
'use client';

import Script from 'next/script';
import { useEffect } from 'react';

export default function Analytics() {
  useEffect(() => {
    if (typeof window !== 'undefined') {
      window.dataLayer = window.dataLayer || [];
      window.gtag?.('config', process.env.NEXT_PUBLIC_GA_ID || '');
    }
  }, []);

  return (
    <Script
      src={`https://www.googletagmanager.com/gtag/js?id=${process.env.NEXT_PUBLIC_GA_ID}`}
      strategy="afterInteractive"
    />
  );
}
```

---

### Configuration Files

#### .env.example
```bash
## Analytics
NEXT_PUBLIC_GA_ID=G-XXXXXXXXXX

## API
NEXT_PUBLIC_API_URL=https://api.example.com
SECRET_API_KEY=sk_test_...

## Email (if using contact form)
NEXT_PUBLIC_EMAIL_SERVICE=sendgrid
SECRET_SENDGRID_KEY=...

## Database (if applicable)
DATABASE_URL=postgresql://...
```

#### CLAUDE.md
```markdown
## Claude Code Setup

### Workspace Configuration
- Branch: `main`
- Environment: Vercel
- Framework: Next.js 16

### Project Commands
- `npm run dev`: Start dev server
- `npm run build`: Production build
- `npm run lint`: Check code quality
- `npm run type-check`: TypeScript validation

### Key Standards
- TypeScript strict mode
- Tailwind CSS for styling
- Framer Motion for animations
- Accessibility: WCAG 2.1 AA
- SEO: All meta tags required

### Files to Know
- `app/layout.tsx`: Root layout
- `app/globals.css`: Global styles
- `app/page.tsx`: Homepage
- `MARKETING_STANDARDS.md`: All standards
```

#### next.config.js
```javascript
/** @type {import('next').NextConfig} */
const nextConfig = {
  // Image optimization
  images: {
    formats: ['image/avif', 'image/webp'],
  },

  // Security headers
  async headers() {
    return [
      {
        source: '/:path*',
        headers: [
          {
            key: 'Strict-Transport-Security',
            value: 'max-age=31536000; includeSubDomains',
          },
          {
            key: 'X-Content-Type-Options',
            value: 'nosniff',
          },
          {
            key: 'X-Frame-Options',
            value: 'DENY',
          },
        ],
      },
    ];
  },

  // Redirects
  async redirects() {
    return [
      {
        source: '/demo',
        destination: '/#demo-booking',
        permanent: false,
      },
    ];
  },
};

module.exports = nextConfig;
```

---

### Design System

#### Color Palette
```css
:root {
  --bg: #0a0a12;
  --bg-alt: #12121e;
  --bg-card: #1a1a28;
  --border: rgba(255,255,255,0.06);
  --text: #e4e4e7;
  --text-dim: #6b7280;
  --accent: #e8c95a;
  --accent-dim: rgba(232,201,90,0.15);
}
```

#### Typography
- **Headings**: Playfair Display (serif)
- **Body**: Inter (sans-serif)
- **Mono**: Roboto Mono (monospace)

#### Components
- `.doc-btn`: Standard button
- `.doc-btn-primary`: Primary action button
- `.doc-card`: Card container
- `.doc-heading`: Heading styles
- `.doc-body`: Body text

---

### Performance Checklist

Before launching, ensure:

```bash
## 1. Build succeeds
npm run build

## 2. No TypeScript errors
npm run type-check

## 3. No ESLint warnings
npm run lint

## 4. Check Lighthouse
## Run: npm run dev
## Open DevTools → Lighthouse
## Target scores: Performance 95+, SEO 95+, A11y 95+, Best Practices 95+

## 5. Check bundle size
npm run build-stats
## Target: < 500KB gzipped

## 6. Verify Core Web Vitals
## Navigate to https://web.dev/measure/
## All should be "Good"
```

---

### Deployment Checklist

#### Pre-deployment
- [ ] All environment variables set
- [ ] Database migrations run
- [ ] Secrets rotated
- [ ] SSL certificate valid
- [ ] Backups configured
- [ ] Monitoring alerts set

#### Post-deployment
- [ ] Analytics tracking verified
- [ ] Forms submission tested
- [ ] Email notifications working
- [ ] Search Console updated
- [ ] Sitemap submitted
- [ ] Performance monitored
- [ ] Error tracking active

---

### Content Guidelines

#### Homepage Section Order
1. Hero (Value proposition + CTA)
2. Features (What makes you different)
3. How it Works (Implementation overview)
4. Testimonials (Social proof)
5. Pricing (Clear pricing structure)
6. CTA Section (Convert visitors)
7. FAQ (Address objections)
8. Final CTA (Last chance)
9. Footer (Legal + links)

#### Copy Standards
- **Headlines**: Benefit-focused, emotional
- **Body**: Clear, concise, specific
- **CTAs**: Action-oriented, urgent
- **Testimonials**: Real, specific, quantified

#### Image Standards
- **Format**: WebP with PNG fallback
- **Size**: Compressed (< 200KB for hero)
- **Alt text**: Descriptive, keyword-rich
- **Dimensions**: 16:9 or 4:3 aspect ratio

---

### Maintenance Schedule

#### Daily
- Monitor error logs
- Check uptime
- Review critical alerts

#### Weekly
- Review analytics
- Check user feedback
- Verify forms working
- Test critical paths

#### Monthly
- Update content
- Review performance metrics
- Audit accessibility
- Check broken links
- Update testimonials

#### Quarterly
- Full performance audit
- SEO audit
- Security scan
- Competitor analysis

#### Annually
- Major version upgrades
- Design refresh evaluation
- Strategy review
- Technology stack assessment

---

### Troubleshooting Guide

#### Lighthouse score dropped
1. Check recent commits
2. Profile JavaScript bundle
3. Optimize images
4. Remove unused code
5. Verify CDN caching

#### Analytics not tracking
1. Check GA ID in environment
2. Verify gtag script loaded
3. Check browser console for errors
4. Test in GA4 real-time
5. Check CSP headers

#### Accessibility issues
1. Run Axe DevTools
2. Check color contrast
3. Test keyboard navigation
4. Verify ARIA labels
5. Test with screen reader

#### Slow page load
1. Check Core Web Vitals
2. Optimize LCP (images)
3. Reduce FID (JavaScript)
4. Fix CLS (fonts, images)
5. Enable caching

---

### Resources

#### Documentation
- [MARKETING_STANDARDS.md](../marketing/standards.md)
- [SEO_CHECKLIST.md](../quality/seo.md)
- [SECURITY_GUIDE.md](../security/guide.md)
- [ACCESSIBILITY_GUIDE.md](../quality/accessibility.md)
- [IMPLEMENTATION_CHECKLIST.md](implementation-checklist.md)

#### Tools
- **Performance**: Lighthouse, WebPageTest, GTmetrix
- **SEO**: Google Search Console, SEMrush, Moz
- **Accessibility**: Axe DevTools, WAVE, Lighthouse
- **Analytics**: Google Analytics 4, Hotjar

#### Learning
- Next.js Docs: https://nextjs.org/docs
- Tailwind CSS: https://tailwindcss.com
- Web.dev: https://web.dev/
- MDN Web Docs: https://developer.mozilla.org/

---

### Getting Help

1. **Check the docs**: Start with MARKETING_STANDARDS.md
2. **Search issues**: Look for similar problems
3. **Ask the team**: Slack or GitHub discussions
4. **File an issue**: Detailed reproduction steps

---

**Last Updated**: 2026-07-28
**Version**: 1.0
**Maintained By**: Development Team

## Template lifecycle

The template is not a one-time starting point. Improvements flow **down** to
projects and **back up** from them. Without the second direction, every project
independently rediscovers the same bugs and the template slowly becomes the
least-current codebase in the estate.

```
                    repo-template.bardenhagen.xyz
                         ▲                 │
        (2) uplift       │                 │   (1) propagate
        issue form  ─────┘                 └────►  script
        or skill                                   downstream repos
                                                        │
                    ◄───────────────────────────────────┘
                         a fix worth generalising
```

---

### Direction 1 — Template → Projects

`scripts/propagate-template.sh` syncs template files into every repo in
`DOWNSTREAM_REPOS`.

```bash
./scripts/propagate-template.sh --dry-run              # always first
./scripts/propagate-template.sh --repo owner/one-repo  # a single repo
./scripts/propagate-template.sh                        # everything
```

#### Ownership rules

Which side wins on a conflict is per-file, and it matters:

| Files | Winner | Why |
|---|---|---|
| `AGENTS.md`, `CLAUDE.md`, `.cursorrules`, `rules/*`, `.claude/skills/*` | **Template** | Agent instructions must be identical everywhere |
| `docs/engineering/git-workflow.md`, `web-standards.md`, `component-structure.md`, `build-versioning.md`, `github-standards.md`, `agentic-sdlc.md` | **Template** | Standards, by definition the same everywhere |
| `docs/engineering/architecture.md`, `docs/engineering/template-guide.md` | **Project** | Genuinely project-specific |
| `.github/workflows/*` | **Project** if present | Projects legitimately customise pipelines |
| Anything not listed in `TEMPLATE_FILES` | **Project** | Never touched |

> A file the template owns but that is missing from `TEMPLATE_FILES` **never
> reaches downstream repos at all** — the commonest way an improvement gets
> written and then silently goes nowhere. Adding the file to the template is
> only half the job.

#### Never run it unprompted

Propagation overwrites AI-config files across every repo. Run `--dry-run`, read
the diff, then decide. It is a human's call, not an agent's.

### Direction 2 — Projects → Template

The direction that decays if it is not deliberate.

#### Route A — the `template-uplift` skill (in-session)

When a fix lands in a project and the cause would recur elsewhere, invoke the
skill: it attaches the template repo, generalises the fix, places it, adds an
enforcement check, and opens a draft PR. See
[`.claude/skills/template-uplift/SKILL.md`](../../.claude/skills/template-uplift/SKILL.md).

#### Route B — the uplift issue form (asynchronous)

When you notice it but cannot act now, open a
[template uplift issue](../../../../issues/new?template=template_uplift.yml). It
requires the failure mode, the generalised rule, a destination, and an
enforcement check — the same discipline the skill applies, captured while it is
fresh.

#### The filter — most fixes should not be promoted

Both routes apply the same two tests, and both must pass:

1. **It would recur.** The cause is structural, not specific to one project's
   data, domain, or design.
2. **It is stateable as a rule.** "Never X, always Y", applicable by someone who
   never saw the original bug.

**A bloated template is worse than a thin one**, because every rule in it is
read by every agent on every project. Rejecting an uplift is a normal outcome.

#### Generalise, or it rots

The downstream fix is *evidence*; the template needs the *rule*. Strip project
nouns, lead with the failure mode rather than the fix — "below 340px the card's
right edge is clipped while its left stays visible" is what makes a reader
recognise the bug in their own code — and state *why*, so nobody simplifies it
back out later.

#### Make it enforceable

A rule in prose is a suggestion. Where the improvement admits a check, add one:
a `rg` regex in the doc's Quality Gates section, a case in an audit script, or a
CI step. **Verify the check against a passing *and* a failing example before
shipping it** — a regex that matches both, or neither, is worse than nothing
because it will be trusted.

### Cadence

| When | Do |
|---|---|
| A fix lands whose cause would recur | Uplift it, then and there |
| After a project milestone | Review the diff for generalisable patterns |
| Quarterly | Skim open `template-uplift` issues; batch-merge or close with a reason |
| After a template release | Propagate with `--dry-run`, review, then apply |

### Health checks

The template is drifting out of usefulness if any of these are true:

- A project has been generated but never re-synced
- The same bug has been fixed independently in two projects
- `TEMPLATE_FILES` is missing a doc the template owns
- An uplift issue has sat untriaged for a quarter
- `./scripts/verify-action-pins.sh` fails
- A standards doc contradicts what the projects actually do
