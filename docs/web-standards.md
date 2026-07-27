# Web Standards — Digital Response

One standards package, applied to every project built with this template.

> **Reference:** [digitalresponse.com.au/standards](https://digitalresponse.com.au)  
> **Updated:** 2026-07-27

---

## The Five Rules

1. **Document width equals viewport width** at every size. No horizontal scroll, ever. Enforced in CI.
2. **Every page carries the view-source header** — repo, timestamp, version, build, commit, environment, URL, server IP.
3. **Every footer credits "Website design & development by Digital Response"** with the green mark.
4. **No link surprises the user** — external links and file downloads announce themselves with an icon before the tap.
5. **Nothing ships without** SEO metadata, generated share images, sitemap, robots, privacy policy, structured logging and alerts.

---

## 01 — Responsive & Mobile Width

### The Rule

**On every viewport from 320px up, the document width equals the viewport width.** The page never scrolls horizontally. No exceptions.

### Implementation

#### Global Guard (Required First)

Import `dr-guard.css` at the **very beginning** of your global styles:

```css
@import 'path/to/dr-guard.css';
@import 'tailwindcss';
```

Key rules:

```css
html,
body {
  max-width: 100%;
  overflow-x: clip;  /* NOT hidden — preserves sticky headers */
}
```

⚠️ **Critical:** Use `overflow-x: clip` not `overflow-x: hidden`. The latter breaks `position: sticky`.

#### Section Clipping

Every `<section>` wrapping decorative elements:

```tsx
<section className="relative isolate overflow-hidden">
  {/* content and decoration */}
</section>
```

- `relative` = establishes positioning context
- `isolate` = creates stacking context
- `overflow-hidden` = clips decorative blobs

#### Decorative Elements

✅ **CORRECT:**
```tsx
import { DecorLayer, Blob } from '@/components/DecorLayer';

<DecorLayer>
  <Blob size={600} blur={120} className="top-0 left-1/4 bg-blue-500/10" />
</DecorLayer>
```

❌ **WRONG:**
```tsx
<div className="absolute top-0 left-1/4 w-[600px] h-[600px]">
```

`Blob` emits responsive widths: `min(600px, 120vw)`.

#### Container Pattern

```tsx
<div className="mx-auto w-full max-w-6xl px-5 sm:px-8">
  {/* content stays within max-width with min 20px gutter */}
</div>
```

### Banned Patterns

| ❌ Never | ✅ Instead |
|---------|-----------|
| `w-screen` | `w-full` |
| `width: 100vw` | `w-full` |
| `w-[600px]` on decoration | `w-[min(600px,120vw)]` or `<Blob size={600} />` |
| `-left-20` / `-right-20` outside clipping parent | Wrap in `<DecorLayer>` |
| `overflow-x: hidden` on `html`/`body` | `overflow-x: clip` |
| `min-w-[400px]` on layout | `min-w-0` + responsive `max-w-*` |
| Fixed-width tables | Wrap in `overflow-x-auto` |

### Quality Gates

**Linting:**
```bash
rg -n "w-screen|100vw|w-\[[0-9]{3,}px\]" src/app src/components
# Should return nothing
```

**Automated Testing:**
```bash
npm run audit:overflow
# Tests at 320 / 360 / 390 / 412 / 430 / 768 / 1024px
```

**Manual Testing:**
- [ ] Test on real device (not devtools)
- [ ] Rotate to landscape (420px width)
- [ ] Verify no tap target < 44x44px
- [ ] Verify body text ≥ 16px (prevents iOS zoom-on-focus)
- [ ] Address bar tap doesn't shift document

---

## 02 — SEO & Metadata

### Required on Every Page

```tsx
export const metadata: Metadata = {
  title: 'Page Title | Your Site',
  description: 'Concise summary under 160 chars',
  openGraph: {
    title: 'Page Title',
    description: 'Summary for social share',
    images: [{ url: '/og-image.png', width: 1200, height: 630 }],
  },
  twitter: {
    card: 'summary_large_image',
    title: 'Page Title',
    description: 'Summary',
    images: ['/og-image.png'],
  },
};
```

### Sitemap & Robots

```
public/
├── sitemap.xml
└── robots.txt
```

**sitemap.xml:**
```xml
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>https://example.com/</loc>
    <lastmod>2026-07-27</lastmod>
    <priority>1.0</priority>
  </url>
</urlset>
```

**robots.txt:**
```
User-agent: *
Allow: /
Disallow: /admin
Sitemap: https://example.com/sitemap.xml
```

### Structured Data (JSON-LD)

```tsx
<script type="application/ld+json">
  {JSON.stringify({
    '@context': 'https://schema.org',
    '@type': 'Organization',
    name: 'Your Company',
    url: 'https://example.com',
    logo: 'https://example.com/logo.png',
  })}
</script>
```

---

## 03 — Link Behavior

### External Links

Always announce with icon:

```tsx
<a href="https://external.com" target="_blank" rel="noopener noreferrer">
  Link Title <ExternalIcon />
</a>
```

### File Downloads

Always announce file type and size:

```tsx
<a href="/files/document.pdf" download>
  Download Document <FileIcon /> (2.3 MB)
</a>
```

### Internal Links

No icon needed — stay within the app:

```tsx
<Link href="/about">About Us</Link>
```

---

## 04 — Footer & Attribution

Every footer must include:

```tsx
<footer className="site-footer">
  <div>© 2026 Your Company</div>
  <div>
    Design & development by{' '}
    <a href="https://digitalresponse.com.au" target="_blank" rel="noopener">
      Digital Response
      <img src="/digital-response-mark.svg" alt="" />
    </a>
  </div>
</footer>
```

---

## 05 — Logging & Alerts

### Structured Logging

```typescript
import { logger } from '@/lib/logger';

logger.info('page_loaded', {
  path: '/products',
  user_id: 'user123',
  timestamp: new Date().toISOString(),
});

logger.error('payment_failed', {
  reason: 'insufficient_funds',
  amount: 9999,
  user_id: 'user123',
});
```

### Alert Routing

Critical errors → Slack/Teams notifications:

```typescript
logger.critical('database_down', {
  error: 'Connection refused',
  severity: 'critical',
});
```

---

## Rollout Checklist

- [ ] `dr-guard.css` imported first in global styles
- [ ] All `<section>` tags use `relative isolate overflow-hidden`
- [ ] Zero decorative elements outside `<DecorLayer>`
- [ ] `rg -n "w-screen|100vw" src` returns nothing
- [ ] `npm run audit:overflow` passes at all widths
- [ ] Tested on real device (not devtools)
- [ ] Metadata on all pages (title, description, OG)
- [ ] Sitemap and robots.txt in place
- [ ] External links have icons
- [ ] Footer credits Digital Response
- [ ] Structured logging configured
- [ ] No horizontal scroll at any viewport

---

## Reference

- **Digital Response Standards:** [digitalresponse.com.au](https://digitalresponse.com.au)
- **Techlight Reference:** [techlight.com.au](https://techlight.com.au)
- **MDN: Responsive Web Design:** [developer.mozilla.org](https://developer.mozilla.org/en-US/docs/Learn/CSS/CSS_layout/Responsive_Design)
