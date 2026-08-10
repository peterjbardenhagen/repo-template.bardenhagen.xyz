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

#### The `minmax()` Grid Trap

The single most common way a card grid breaks on a phone:

```css
/* ❌ Overflows below ~340px. The 300px floor is a HARD minimum — when the
   viewport minus padding is narrower than 300px, the track still claims
   300px and the card's right edge is pushed outside the viewport. */
grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));

/* ✅ The floor collapses to the container width when that is the smaller
   of the two, so the card always fits. */
grid-template-columns: repeat(auto-fit, minmax(min(300px, 100%), 1fr));
```

Tailwind:

```tsx
❌ grid-cols-[repeat(auto-fit,minmax(300px,1fr))]
✅ grid-cols-[repeat(auto-fit,minmax(min(300px,100%),1fr))]
```

The failure is easy to miss because it is *asymmetric*: the left border of each
card stays visible while the right border is clipped off-screen, so it reads as
a styling bug rather than an overflow one. Any `auto-fit`/`auto-fill` track with
a fixed floor needs the `min()` wrapper.

#### Component-Level Responsiveness: Container Queries

Prefer container queries over viewport breakpoints when the behaviour belongs to
a *component* rather than the page. A card in a narrow sidebar should lay out as
though it is narrow, regardless of how wide the window is — which a media query
cannot express.

```css
.card-grid { container-type: inline-size; }

@container (min-width: 480px) {
  .card { grid-template-columns: auto 1fr; }
}
```

```tsx
<div className="@container">
  <div className="flex flex-col @md:flex-row">…</div>
</div>
```

Baseline across Chrome, Firefox, Safari, and Edge since late 2023 (>95% global).

Keep **media** queries for what they are still the right tool for: user
preferences (`prefers-color-scheme`, `prefers-reduced-motion`,
`prefers-contrast`), print styles, and genuine page-level layout shifts.

#### Fluid Type and Space

Prefer `clamp()` over stacked breakpoints — fewer rules, no jumps between them:

```css
h1 { font-size: clamp(1.75rem, 1.2rem + 2.5vw, 3rem); }
.section { padding-block: clamp(2rem, 5vw, 5rem); }
```

Body text must never resolve below `16px` — iOS Safari zooms the viewport on
focus of any input with a smaller computed font size.

#### Heading Hierarchy

Visual size must track semantic level. Exactly one `<h1>` per page, and no
heading larger than the one above it.

```tsx
❌ <PageHead title="Files" />        {/* h1 */}
   <h1 className="text-4xl">OneDrive Files</h1>   {/* second h1, and larger */}

✅ <PageHead title="Files" />        {/* h1 */}
   <h2 className="text-2xl">OneDrive Files</h2>
```

If a page already renders its title through shared chrome (`PageHead`, a layout,
a template), the page body starts at `<h2>`. Screen readers navigate by heading
level; a document with two `<h1>`s has no reliable outline.

#### Tables

A table is the most common overflow source after grids. Never let one set the
page width:

```tsx
<div className="w-full overflow-x-auto">
  <table className="min-w-[40rem]">…</table>
</div>
```

The `min-w-*` goes on the **table**, never on the wrapper — on the wrapper it
forces the page wide, which is the exact bug it is meant to prevent.

### Banned Patterns

| ❌ Never | ✅ Instead |
|---------|-----------|
| `w-screen` | `w-full` |
| `width: 100vw` | `w-full` |
| `minmax(300px, 1fr)` in `auto-fit`/`auto-fill` | `minmax(min(300px, 100%), 1fr)` |
| `w-[600px]` on decoration | `w-[min(600px,120vw)]` or `<Blob size={600} />` |
| `-left-20` / `-right-20` outside clipping parent | Wrap in `<DecorLayer>` |
| `overflow-x: hidden` on `html`/`body` | `overflow-x: clip` |
| `min-w-[400px]` on layout | `min-w-0` + responsive `max-w-*` |
| `min-w-*` on a table's scroll wrapper | `min-w-*` on the `<table>` itself |
| Fixed-width tables | Wrap in `overflow-x-auto` |
| Font size < 16px on inputs | ≥ 16px (prevents iOS zoom-on-focus) |
| A second `<h1>`, or `<h2>` larger than the `<h1>` | One `<h1>`; descending sizes |

### Quality Gates

**Linting:**
```bash
# Hard-coded viewport widths
rg -n "w-screen|100vw|w-\[[0-9]{3,}px\]" src/app src/components

# The minmax() grid trap: an auto-fit/auto-fill floor that cannot shrink.
# Matches minmax(300px, …) but not minmax(min(300px, 100%), …)
rg -n "minmax\(\s*[0-9]+(px|rem)" src/app src/components src/styles

# Both should return nothing.
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
- [ ] `rg -n "minmax\(\s*[0-9]+(px|rem)" src` returns nothing
- [ ] Every table wrapped in `overflow-x-auto`, with `min-w-*` on the table
- [ ] One `<h1>` per page; no heading larger than its parent level
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

---

## 2026 Updates & AI-Native Considerations

### Core Web Vitals (2026 Thresholds)

| Metric | Good | Needs Improvement | Poor |
|--------|------|-------------------|------|
| LCP | ≤ 2.0s | 2.0s – 4.0s | > 4.0s |
| FID | ≤ 80ms | 80ms – 200ms | > 200ms |
| CLS | ≤ 0.08 | 0.08 – 0.2 | > 0.2 |
| INP | ≤ 150ms | 150ms – 400ms | > 400ms |

**AI-generated content note:** Agents must optimise for INP (Interaction to Next Paint) when adding dynamic AI widgets, chatbots, or streaming responses. Debounce input handlers, skeleton-load states, and avoid layout shifts during async fetches.

### WCAG 2.2 / 2.3 Essentials

- **Target size:** Interactive elements must be at least 24x24 CSS pixels (WCAG 2.2 Level AAA)
- **Dragging movements:** Provide single-pointer alternatives for all drag-and-drop interfaces
- **Redundant entry:** Auto-fill or suggest previously entered information across multi-step forms
- **Focus not obscured:** Ensure active focus indicators are not covered by sticky headers or modals
- **Consistent help:** Help mechanisms in the same relative order across the whole site

### AI Content Accessibility

When agents generate content:
- **Alt text:** Every meaningful image gets descriptive alt text; decorative images get `alt=""`
- **Error messages:** LLM-generated errors must include plain-language cause, remediation steps, and support links
- **Empty states:** Use `role="status"` or `aria-live="polite"` for dynamic empty-state content
- **Color contrast:** Never rely on color alone. Use icons, labels, or patterns alongside color coding
- **Language declaration:** Set `lang` attribute on `<html>` and update dynamically for multilingual agents

### Responsive Patterns (2026)

- **Container queries** preferred over media queries for component-level responsiveness
- **`has()` selector** for parent-state styling without extra classes
- **`field-sizing: content`** for auto-resizing form inputs
- **CSS anchor positioning** for tooltips, popovers, and dropdowns without JS positioning libraries
- **`:user-invalid`** and `:user-valid` for real-time form validation styling

### Banned Patterns (Updated)

- ❌ `overflow-x: hidden` — breaks `position: sticky`; use `overflow-x: clip`
- ❌ Fixed-width layouts that exceed viewport at 320px
- ❌ Auto-playing media without explicit user consent
- ❌ `alert()` for user-facing messages; use accessible inline notifications
- ❌ Placeholder text used as the only label
