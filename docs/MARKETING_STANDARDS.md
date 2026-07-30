# MyDesk Marketing Website Standards & Best Practices

## Overview
This document outlines the standards, patterns, and best practices for building and maintaining the MyDesk marketing website. These standards ensure consistency, performance, accessibility, and SEO excellence across all pages and components.

---

## Table of Contents
1. [Performance Standards](#performance-standards)
2. [SEO & Meta Data](#seo--meta-data)
3. [Accessibility (A11y)](#accessibility-a11y)
4. [Component Architecture](#component-architecture)
5. [Animation & Interactions](#animation--interactions)
6. [Mobile Responsiveness](#mobile-responsiveness)
7. [Analytics & Tracking](#analytics--tracking)
8. [Security Standards](#security-standards)
9. [Code Quality](#code-quality)

---

## Performance Standards

### Target Metrics
- **Largest Contentful Paint (LCP)**: < 2.5s
- **First Input Delay (FID)**: < 100ms
- **Cumulative Layout Shift (CLS)**: < 0.1
- **Bundle Size**: < 500KB (gzipped)
- **Time to First Byte (TTFB)**: < 600ms

### Implementation Guidelines

#### Image Optimization
```tsx
import Image from 'next/image';

// ✅ CORRECT - Using Next.js Image with optimization
<Image
  src="/hero.jpg"
  alt="Hero section"
  width={1200}
  height={600}
  priority={true}
  quality={80}
  sizes="(max-width: 768px) 100vw, (max-width: 1200px) 50vw, 100vw"
/>

// ❌ WRONG - Native img tag without optimization
<img src="/hero.jpg" alt="Hero" />
```

#### Code Splitting
```tsx
// ✅ CORRECT - Lazy load heavy components
import dynamic from 'next/dynamic';

const DemoVideo = dynamic(() => import('@/components/DemoVideo'), {
  loading: () => <div className="animate-pulse">Loading...</div>,
  ssr: false,
});

// Use in page
<Suspense fallback={<LoadingSpinner />}>
  <DemoVideo />
</Suspense>
```

#### Component Optimization
```tsx
// ✅ CORRECT - Memoize expensive components
const TestimonialCarousel = React.memo(function TestimonialCarousel() {
  // Component logic
});

// ✅ CORRECT - Use useMemo for expensive calculations
const processedData = useMemo(() => {
  return complexDataTransformation(data);
}, [data]);
```

### Performance Checklist
- [ ] Use Next.js Image component for all images
- [ ] Implement lazy loading for below-fold content
- [ ] Minimize JavaScript bundle size
- [ ] Use dynamic imports for heavy components
- [ ] Compress all assets (WebP with fallbacks)
- [ ] Enable GZIP compression on server
- [ ] Remove unused CSS/JavaScript
- [ ] Cache static assets (30 days minimum)

---

## SEO & Meta Data

### Meta Tags Template
```tsx
export const metadata = {
  title: 'MyDesk — AI Operating System for Enterprise',
  description: 'Enterprise-grade multi-tenant AI platform for smart quoting, customer portals, and business intelligence.',
  keywords: ['ERP', 'AI', 'Business Intelligence', 'Multi-tenant'],
  openGraph: {
    title: 'MyDesk — AI Operating System',
    description: 'Enterprise AI platform for automated workflows',
    url: 'https://mydesk.digitalresponse.com.au',
    siteName: 'MyDesk',
    images: [
      {
        url: 'https://mydesk.digitalresponse.com.au/og-image.jpg',
        width: 1200,
        height: 630,
        alt: 'MyDesk Platform',
      },
    ],
    type: 'website',
  },
  twitter: {
    card: 'summary_large_image',
    title: 'MyDesk — AI Operating System',
    description: 'Enterprise AI platform',
    images: ['https://mydesk.digitalresponse.com.au/twitter-image.jpg'],
  },
};
```

### Structured Data (JSON-LD)
```tsx
const schemaData = {
  '@context': 'https://schema.org',
  '@type': 'SoftwareApplication',
  name: 'MyDesk',
  description: 'Enterprise AI Operating System',
  url: 'https://mydesk.digitalresponse.com.au',
  image: 'https://mydesk.digitalresponse.com.au/logo.png',
  applicationCategory: 'BusinessApplication',
  aggregateRating: {
    '@type': 'AggregateRating',
    ratingValue: '4.8',
    ratingCount: '150',
  },
  offers: {
    '@type': 'Offer',
    price: '149.00',
    priceCurrency: 'AUD',
  },
};
```

### SEO Checklist
- [ ] Unique, descriptive title tags (50-60 chars)
- [ ] Meta descriptions (150-160 chars)
- [ ] H1 tags (one per page)
- [ ] Proper heading hierarchy (H1 → H2 → H3)
- [ ] Alt text on all images
- [ ] Internal linking strategy
- [ ] Sitemaps and robots.txt
- [ ] Schema markup (Organization, Product, Article)
- [ ] Open Graph tags
- [ ] Twitter Card tags
- [ ] Canonical URLs

---

## Accessibility (A11y)

### WCAG 2.1 Level AA Compliance

#### Color Contrast
```tsx
// ✅ CORRECT - Meets WCAG AA (4.5:1 for text)
<p className="text-white bg-[#0a0a12]">Good contrast</p>

// ❌ WRONG - Fails WCAG AA
<p className="text-gray-400 bg-[#1a1a28]">Poor contrast</p>

// Use WebAIM contrast checker: https://webaim.org/resources/contrastchecker/
```

#### ARIA Labels
```tsx
// ✅ CORRECT - Proper ARIA labels
<button
  onClick={toggleMenu}
  aria-label="Toggle navigation menu"
  aria-expanded={isOpen}
  aria-controls="nav-menu"
>
  <Menu className="w-5 h-5" />
</button>

// ✅ CORRECT - Semantic HTML
<nav aria-label="Main navigation">
  <ul role="navigation">
    <li><a href="#features">Features</a></li>
  </ul>
</nav>
```

#### Focus Management
```tsx
// ✅ CORRECT - Visible focus indicators
.doc-btn:focus-visible {
  outline: 2px solid var(--accent);
  outline-offset: 2px;
}

// ✅ CORRECT - Tab order management
<div role="region" aria-label="Content">
  <button tabIndex={0}>First</button>
  <button tabIndex={0}>Second</button>
</div>
```

#### Form Accessibility
```tsx
// ✅ CORRECT - Proper form labels
<label htmlFor="email">Email Address</label>
<input
  id="email"
  type="email"
  aria-required="true"
  aria-describedby="email-hint"
/>
<span id="email-hint">We'll never share your email</span>

// ❌ WRONG - Missing labels
<input type="email" placeholder="Enter email" />
```

### Accessibility Checklist
- [ ] Keyboard navigation works (Tab, Shift+Tab, Enter)
- [ ] Focus indicators visible
- [ ] ARIA labels on interactive elements
- [ ] Color contrast ≥ 4.5:1
- [ ] Semantic HTML (button, nav, main, section)
- [ ] Form labels properly associated
- [ ] Alt text descriptive (not "image" or "pic")
- [ ] Skip to main content link
- [ ] No keyboard traps
- [ ] Screen reader tested (NVDA, JAWS, VoiceOver)

### Testing Tools
- Axe DevTools: https://www.deque.com/axe/devtools/
- WAVE: https://wave.webaim.org/
- Lighthouse (built-in Chrome)
- Screen readers: NVDA (free), VoiceOver (Mac), JAWS

---

## Component Architecture

### Component Structure
```tsx
'use client'; // Mark client components

import { useState } from 'react';
import { motion } from 'framer-motion';
import Link from 'next/link';

interface ComponentProps {
  title: string;
  description?: string;
}

export default function Component({ title, description }: ComponentProps) {
  const [state, setState] = useState(false);

  // Animations
  const variants = {
    hidden: { opacity: 0, y: 20 },
    visible: { opacity: 1, y: 0 },
  };

  return (
    <section className="py-24 px-6">
      <motion.div
        initial="hidden"
        whileInView="visible"
        viewport={{ once: true, margin: '-100px' }}
        variants={variants}
      >
        {/* Component JSX */}
      </motion.div>
    </section>
  );
}
```

### Naming Conventions
- **Components**: PascalCase (`HeroSection`, `FeatureCard`)
- **Files**: Match component name (`HeroSection.tsx`)
- **CSS Classes**: kebab-case with `doc-` prefix (`.doc-card`, `.doc-btn`)
- **Variables**: camelCase (`isVisible`, `userEmail`)
- **Constants**: UPPER_SNAKE_CASE (`MAX_RETRIES`, `API_TIMEOUT`)

### Export Patterns
```tsx
// ✅ CORRECT - Named export with default
export function FeatureCard() { ... }
export default FeatureCard;

// ✅ CORRECT - Lazy loaded component
export const LazyComponent = dynamic(() => import('./Component'), {
  loading: () => <Skeleton />,
});
```

---

## Animation & Interactions

### Animation Standards
```tsx
// ✅ CORRECT - Framer Motion best practices
const fadeInUp = {
  hidden: { opacity: 0, y: 20 },
  visible: { opacity: 1, y: 0, transition: { duration: 0.6 } },
};

<motion.div
  initial="hidden"
  whileInView="visible"
  viewport={{ once: true, margin: '-100px' }}
  variants={fadeInUp}
>
  Content
</motion.div>

// ✅ CORRECT - Hover effects
<motion.button
  whileHover={{ scale: 1.05, y: -2 }}
  whileTap={{ scale: 0.95 }}
  transition={{ type: 'spring', stiffness: 300 }}
>
  Click me
</motion.button>
```

### Easing Functions
```
cubic-bezier(0.22, 1, 0.36, 1)  // Snappy (recommended)
cubic-bezier(0.34, 1.56, 0.64, 1)  // Bouncy
linear  // Mechanical (avoid for UI)
ease-in-out  // Smooth default
```

### Performance Considerations
- Animations must use GPU-accelerated properties (transform, opacity)
- Avoid animating layout properties (width, height, top, left)
- Use `will-change` CSS sparingly
- Test animations on low-end devices

---

## Mobile Responsiveness

### Breakpoints
```tsx
// Tailwind breakpoints (use as-is)
sm: 640px   // Tablets
md: 768px   // Small laptops
lg: 1024px  // Desktops
xl: 1280px  // Wide desktops
2xl: 1536px // Ultra-wide

// ✅ CORRECT - Mobile-first approach
<div className="text-sm sm:text-base md:text-lg lg:text-xl">
  Responsive text
</div>
```

### Touch Targets
```tsx
// ✅ CORRECT - Minimum 44x44px (WCAG standard)
<button className="p-3 rounded-lg">Click me</button>

// ❌ WRONG - Too small
<button className="p-1">Click me</button>
```

### Mobile Viewport Meta Tag
```html
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=5" />
```

### Mobile Checklist
- [ ] Responsive typography (clamp or fluid sizing)
- [ ] Touch-friendly buttons (≥44px)
- [ ] Readable on small screens (>16px text)
- [ ] No horizontal scrolling
- [ ] Mobile navigation tested
- [ ] Forms easy to fill on mobile
- [ ] Images scale properly
- [ ] 90+ Lighthouse score

---

## Analytics & Tracking

### Google Analytics 4 Setup
```tsx
'use client';

import { useEffect } from 'react';
import Script from 'next/script';

export function Analytics() {
  useEffect(() => {
    if (typeof window !== 'undefined') {
      window.dataLayer = window.dataLayer || [];
      function gtag() {
        dataLayer.push(arguments);
      }
      gtag('js', new Date());
      gtag('config', 'G-XXXXXXXXXX', {
        page_path: window.location.pathname,
      });
    }
  }, []);

  return (
    <>
      <Script
        src="https://www.googletagmanager.com/gtag/js?id=G-XXXXXXXXXX"
        strategy="afterInteractive"
      />
    </>
  );
}
```

### Event Tracking
```tsx
// ✅ CORRECT - Track user interactions
function trackEvent(eventName: string, eventData: Record<string, string>) {
  if (typeof window !== 'undefined' && window.gtag) {
    window.gtag('event', eventName, eventData);
  }
}

// Usage
<button onClick={() => trackEvent('CTA_Click', { section: 'hero' })}>
  Start Trial
</button>
```

### Key Events to Track
- CTA clicks (Start Trial, Demo, Pricing)
- Form submissions (Contact, Newsletter)
- Video plays (DemoVideo, testimonials)
- Scroll depth (25%, 50%, 75%, 100%)
- Navigation clicks (menu, internal links)
- Pricing plan selections
- Carousel interactions

### Analytics Checklist
- [ ] Google Analytics 4 configured
- [ ] Conversion tracking enabled
- [ ] Goal funnels set up
- [ ] Heatmaps installed (Hotjar)
- [ ] Session recordings enabled
- [ ] Custom events tracked
- [ ] Dashboard created for KPIs
- [ ] Weekly reporting routine

---

## Security Standards

### Content Security Policy (CSP)
```tsx
// next.config.js
const securityHeaders = [
  {
    key: 'Content-Security-Policy',
    value: `
      default-src 'self';
      script-src 'self' 'unsafe-inline' 'unsafe-eval' https://www.googletagmanager.com;
      style-src 'self' 'unsafe-inline';
      img-src 'self' data: https:;
      font-src 'self' https://fonts.googleapis.com;
      connect-src 'self' https://www.google-analytics.com;
    `.replace(/\s+/g, ' '),
  },
];
```

### Environment Variables
```bash
# .env.local (never commit)
NEXT_PUBLIC_GA_ID=G-XXXXXXXXXX
NEXT_PUBLIC_API_URL=https://api.example.com
SECRET_API_KEY=secret_key_never_expose

# .env.example (commit this)
NEXT_PUBLIC_GA_ID=G-XXXXXXXXXX
NEXT_PUBLIC_API_URL=https://api.example.com
SECRET_API_KEY=your_secret_here
```

### Security Checklist
- [ ] HTTPS enabled (automatic on Vercel)
- [ ] Content Security Policy headers
- [ ] No sensitive data in client code
- [ ] Secrets in environment variables
- [ ] CORS configured properly
- [ ] SQL injection prevention (if applicable)
- [ ] XSS protection (Next.js default)
- [ ] CSRF tokens on forms
- [ ] Rate limiting on API routes
- [ ] Regular dependency updates

---

## Code Quality

### TypeScript Standards
```tsx
// ✅ CORRECT - Proper typing
interface UserProfile {
  name: string;
  email: string;
  role: 'admin' | 'user';
}

function getUserProfile(id: string): Promise<UserProfile> {
  // Implementation
}

// ❌ WRONG - Using any
function getUserProfile(id: any): any {
  // Implementation
}
```

### Linting Rules
```json
// .eslintrc.json
{
  "rules": {
    "no-unused-vars": "error",
    "no-console": ["warn", { "allow": ["warn", "error"] }],
    "prefer-const": "error",
    "no-var": "error"
  }
}
```

### Code Organization
```
src/
  components/
    Hero.tsx
    Features/
      FeatureCard.tsx
      FeatureShowcase.tsx
  pages/
  lib/
    utils.ts
  styles/
    globals.css
```

### Code Review Checklist
- [ ] TypeScript strict mode enabled
- [ ] No console.log() in production code
- [ ] Proper error handling
- [ ] Tests pass (if applicable)
- [ ] No hardcoded values
- [ ] Accessible markup
- [ ] Performance optimized
- [ ] Security reviewed

---

## Deployment & CI/CD

### Pre-deployment Checklist
```bash
# Type checking
npm run type-check

# Linting
npm run lint

# Build
npm run build

# Tests
npm run test

# Performance audit
npm run build-stats
```

### Deployment Standards
- Deploy only from `main` branch
- All tests pass before merge
- Performance budget not exceeded
- No security vulnerabilities
- Lighthouse score ≥ 90
- All components responsive
- SEO metadata complete

---

## Maintenance & Monitoring

### Monthly Tasks
- [ ] Update dependencies
- [ ] Review analytics data
- [ ] Check Core Web Vitals
- [ ] Test accessibility
- [ ] Verify all links work
- [ ] Update testimonials/case studies
- [ ] Review competitor websites
- [ ] Check for broken images

### Quarterly Tasks
- [ ] Full accessibility audit
- [ ] Performance benchmarking
- [ ] SEO audit
- [ ] Competitor analysis
- [ ] Design refresh evaluation
- [ ] Content strategy review

---

## Resources & Tools

### Performance
- Lighthouse: Built-in Chrome DevTools
- WebPageTest: https://www.webpagetest.org/
- GTmetrix: https://gtmetrix.com/

### SEO
- Google Search Console: https://search.google.com/search-console
- SEMrush: https://semrush.com
- Moz: https://moz.com

### Accessibility
- Axe DevTools: https://www.deque.com/axe/devtools/
- WAVE: https://wave.webaim.org/
- Lighthouse A11y Audit

### Analytics
- Google Analytics 4: https://analytics.google.com/
- Hotjar: https://www.hotjar.com/
- Vercel Analytics: https://vercel.com/analytics

### Design System
- Tailwind CSS: https://tailwindcss.com
- Framer Motion: https://www.framer.com/motion/
- Radix UI: https://www.radix-ui.com/

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-07-28 | Initial standards documentation |

---

## Questions or Suggestions?

Contact the development team or open an issue in the repository.
