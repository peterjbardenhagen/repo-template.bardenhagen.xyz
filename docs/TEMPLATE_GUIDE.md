# Marketing Website Template & Standards Guide

## Overview
This guide provides the standards and best practices for building marketing websites for all Bardenhagen projects. Based on the MyDesk marketing website implementation, these standards ensure:

- ✅ Performance (Lighthouse 95+)
- ✅ SEO Excellence (Top rankings)
- ✅ Accessibility (WCAG 2.1 AA)
- ✅ Security (OWASP Top 10)
- ✅ User Experience (Engaging interactions)

---

## Quick Start

### 1. Clone Template
```bash
git clone https://github.com/peterjbardenhagen/repo-template.bardenhagen.xyz.git
cd project-name
npm install
```

### 2. Configure Environment
```bash
cp .env.example .env.local
# Update with your values:
# - Google Analytics ID
# - API endpoints
# - Email credentials
# - Database URLs
```

### 3. Customize
```bash
# Update project name
sed -i 's/MyDesk/YourProject/g' package.json app/layout.tsx

# Update branding colors in globals.css
# Update logo in public/logo.png
# Update favicon in public/favicon.ico
```

### 4. Run Tests
```bash
npm run type-check
npm run lint
npm run build
```

---

## Project Structure

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

## Component Templates

### 1. Hero Section
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

### 2. Feature Section with Cards
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

### 3. Analytics Integration
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

## Configuration Files

### .env.example
```bash
# Analytics
NEXT_PUBLIC_GA_ID=G-XXXXXXXXXX

# API
NEXT_PUBLIC_API_URL=https://api.example.com
SECRET_API_KEY=sk_test_...

# Email (if using contact form)
NEXT_PUBLIC_EMAIL_SERVICE=sendgrid
SECRET_SENDGRID_KEY=...

# Database (if applicable)
DATABASE_URL=postgresql://...
```

### CLAUDE.md
```markdown
# Claude Code Setup

## Workspace Configuration
- Branch: `main`
- Environment: Vercel
- Framework: Next.js 16

## Project Commands
- `npm run dev`: Start dev server
- `npm run build`: Production build
- `npm run lint`: Check code quality
- `npm run type-check`: TypeScript validation

## Key Standards
- TypeScript strict mode
- Tailwind CSS for styling
- Framer Motion for animations
- Accessibility: WCAG 2.1 AA
- SEO: All meta tags required

## Files to Know
- `app/layout.tsx`: Root layout
- `app/globals.css`: Global styles
- `app/page.tsx`: Homepage
- `MARKETING_STANDARDS.md`: All standards
```

### next.config.js
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

## Design System

### Color Palette
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

### Typography
- **Headings**: Playfair Display (serif)
- **Body**: Inter (sans-serif)
- **Mono**: Roboto Mono (monospace)

### Components
- `.doc-btn`: Standard button
- `.doc-btn-primary`: Primary action button
- `.doc-card`: Card container
- `.doc-heading`: Heading styles
- `.doc-body`: Body text

---

## Performance Checklist

Before launching, ensure:

```bash
# 1. Build succeeds
npm run build

# 2. No TypeScript errors
npm run type-check

# 3. No ESLint warnings
npm run lint

# 4. Check Lighthouse
# Run: npm run dev
# Open DevTools → Lighthouse
# Target scores: Performance 95+, SEO 95+, A11y 95+, Best Practices 95+

# 5. Check bundle size
npm run build-stats
# Target: < 500KB gzipped

# 6. Verify Core Web Vitals
# Navigate to https://web.dev/measure/
# All should be "Good"
```

---

## Deployment Checklist

### Pre-deployment
- [ ] All environment variables set
- [ ] Database migrations run
- [ ] Secrets rotated
- [ ] SSL certificate valid
- [ ] Backups configured
- [ ] Monitoring alerts set

### Post-deployment
- [ ] Analytics tracking verified
- [ ] Forms submission tested
- [ ] Email notifications working
- [ ] Search Console updated
- [ ] Sitemap submitted
- [ ] Performance monitored
- [ ] Error tracking active

---

## Content Guidelines

### Homepage Section Order
1. Hero (Value proposition + CTA)
2. Features (What makes you different)
3. How it Works (Implementation overview)
4. Testimonials (Social proof)
5. Pricing (Clear pricing structure)
6. CTA Section (Convert visitors)
7. FAQ (Address objections)
8. Final CTA (Last chance)
9. Footer (Legal + links)

### Copy Standards
- **Headlines**: Benefit-focused, emotional
- **Body**: Clear, concise, specific
- **CTAs**: Action-oriented, urgent
- **Testimonials**: Real, specific, quantified

### Image Standards
- **Format**: WebP with PNG fallback
- **Size**: Compressed (< 200KB for hero)
- **Alt text**: Descriptive, keyword-rich
- **Dimensions**: 16:9 or 4:3 aspect ratio

---

## Maintenance Schedule

### Daily
- Monitor error logs
- Check uptime
- Review critical alerts

### Weekly
- Review analytics
- Check user feedback
- Verify forms working
- Test critical paths

### Monthly
- Update content
- Review performance metrics
- Audit accessibility
- Check broken links
- Update testimonials

### Quarterly
- Full performance audit
- SEO audit
- Security scan
- Competitor analysis

### Annually
- Major version upgrades
- Design refresh evaluation
- Strategy review
- Technology stack assessment

---

## Troubleshooting Guide

### Lighthouse score dropped
1. Check recent commits
2. Profile JavaScript bundle
3. Optimize images
4. Remove unused code
5. Verify CDN caching

### Analytics not tracking
1. Check GA ID in environment
2. Verify gtag script loaded
3. Check browser console for errors
4. Test in GA4 real-time
5. Check CSP headers

### Accessibility issues
1. Run Axe DevTools
2. Check color contrast
3. Test keyboard navigation
4. Verify ARIA labels
5. Test with screen reader

### Slow page load
1. Check Core Web Vitals
2. Optimize LCP (images)
3. Reduce FID (JavaScript)
4. Fix CLS (fonts, images)
5. Enable caching

---

## Resources

### Documentation
- [MARKETING_STANDARDS.md](./MARKETING_STANDARDS.md)
- [SEO_CHECKLIST.md](./SEO_CHECKLIST.md)
- [SECURITY_GUIDE.md](./SECURITY_GUIDE.md)
- [ACCESSIBILITY_GUIDE.md](./ACCESSIBILITY_GUIDE.md)
- [IMPLEMENTATION_CHECKLIST.md](./IMPLEMENTATION_CHECKLIST.md)

### Tools
- **Performance**: Lighthouse, WebPageTest, GTmetrix
- **SEO**: Google Search Console, SEMrush, Moz
- **Accessibility**: Axe DevTools, WAVE, Lighthouse
- **Analytics**: Google Analytics 4, Hotjar

### Learning
- Next.js Docs: https://nextjs.org/docs
- Tailwind CSS: https://tailwindcss.com
- Web.dev: https://web.dev/
- MDN Web Docs: https://developer.mozilla.org/

---

## Getting Help

1. **Check the docs**: Start with MARKETING_STANDARDS.md
2. **Search issues**: Look for similar problems
3. **Ask the team**: Slack or GitHub discussions
4. **File an issue**: Detailed reproduction steps

---

**Last Updated**: 2026-07-28
**Version**: 1.0
**Maintained By**: Development Team
