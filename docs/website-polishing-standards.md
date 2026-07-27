# Website Polishing Standards

A comprehensive checklist and reference for production-ready website polish — covering SEO, performance, accessibility, social sharing, favicon/iconography, and edge-case hardening.

## 1. Meta Tags & SEO

### Required for every page

```html
<title>Page Title — Brand Name</title>
<meta name="description" content="Compelling 120-160 char summary with primary keyword front-loaded." />
<meta name="keywords" content="relevant, keywords, comma, separated" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta charset="utf-8" />
<link rel="canonical" href="https://example.com/page" />
```

### Open Graph (Facebook, LinkedIn, Discord)

```html
<meta property="og:type" content="website" />
<meta property="og:url" content="https://example.com/page" />
<meta property="og:title" content="Page Title — Brand" />
<meta property="og:description" content="Same as meta description or tailored for social." />
<meta property="og:image" content="https://example.com/assets/og-image.png" />
<meta property="og:image:width" content="1200" />
<meta property="og:image:height" content="630" />
<meta property="og:locale" content="en_AU" />
<meta property="og:site_name" content="Brand Name" />
```

### Twitter Card

```html
<meta name="twitter:card" content="summary_large_image" />
<meta name="twitter:title" content="Page Title — Brand" />
<meta name="twitter:description" content="Social-optimised description." />
<meta name="twitter:image" content="https://example.com/assets/og-image.png" />
<meta name="twitter:creator" content="@brand_handle" />
```

### Structured Data (JSON-LD)

Include `SoftwareApplication`, `Organization`, `WebSite`, `BreadcrumbList`, `FAQPage`, `Article` or `Product` schemas as appropriate.

```html
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "SoftwareApplication",
  "name": "Brand Name",
  "description": "...",
  "url": "https://example.com",
  "applicationCategory": "BusinessApplication",
  "operatingSystem": "Web",
  "offers": { "@type": "Offer", "price": "0", "priceCurrency": "AUD" }
}
</script>
```

## 2. Favicon & Icons

| File | Size | Purpose |
|------|------|---------|
| `favicon.ico` | 32x32 | Legacy browsers (always include) |
| `favicon.svg` | any | Modern browsers (SVG supported in all major browsers since ~2020) |
| `favicon-16x16.png` | 16x16 | Tab icon fallback |
| `favicon-32x32.png` | 32x32 | Tab icon |
| `apple-touch-icon.png` | 180x180 | iOS home screen |
| `android-chrome-192x192.png` | 192x192 | Android / PWA |
| `android-chrome-512x512.png` | 512x512 | Android splash |
| `mstile-150x150.png` | 150x150 | Windows tile (deprecated but harmless) |

### HTML tags

```html
<link rel="icon" href="/favicon.ico" sizes="any" />
<link rel="icon" href="/favicon.svg" type="image/svg+xml" />
<link rel="apple-touch-icon" href="/apple-touch-icon.png" />
<link rel="manifest" href="/site.webmanifest" />
<meta name="theme-color" content="#your-brand-color" />
```

### site.webmanifest

```json
{
  "name": "Full Product Name",
  "short_name": "Short Name",
  "description": "...",
  "start_url": "/",
  "display": "standalone",
  "background_color": "#ffffff",
  "theme_color": "#brand-primary",
  "icons": [
    { "src": "/android-chrome-192x192.png", "sizes": "192x192", "type": "image/png" },
    { "src": "/android-chrome-512x512.png", "sizes": "512x512", "type": "image/png" },
    { "src": "/favicon.svg", "sizes": "any", "type": "image/svg+xml" }
  ]
}
```

## 3. Social Sharing Image (OG Image)

- **Dimensions:** 1200x630 px (1.91:1 aspect ratio)
- **Format:** PNG or JPG (SVG supported by some platforms, but PNG is safest)
- **Size:** Under 300 KB
- **Design rules:**
  - Brand logo top-left or centered
  - Single headline: 4-6 words, large type
  - Subtitle: 1 line descriptor
  - No clutter — social platforms crop to square in some views
  - Use brand colors and high contrast
- **Tools:** Canva, Figma (export 2x), or `@vercel/og` (programmatic)

### Dynamic OG generation (Next.js)

```ts
// app/opengraph-image.tsx
import { ImageResponse } from 'next/og';
export const runtime = 'edge';
export const alt = 'Brand — Tagline';
export const size = { width: 1200, height: 630 };
export default async function Image() {
  return new ImageResponse(
    <div style={{ /* your design */ }} />,
    { ...size },
  );
}
```

## 4. Sitemap

- **Dynamic sitemap** (Next.js `app/sitemap.tsx`) preferred over static XML
- Include every public page with correct `lastModified`, `changeFrequency`, `priority`
- Submit to Google Search Console

```ts
// app/sitemap.tsx — example
export default function sitemap(): MetadataRoute.Sitemap {
  const base = 'https://example.com';
  return [
    { url: base, lastModified: new Date(), changeFrequency: 'weekly', priority: 1.0 },
    { url: `${base}/about`, lastModified: new Date(), changeFrequency: 'monthly', priority: 0.8 },
    // ... all public routes
  ];
}
```

## 5. robots.txt

```txt
User-agent: *
Allow: /
Sitemap: https://example.com/sitemap.xml
```

Block admin, API, staging paths:
```txt
Disallow: /api/
Disallow: /admin/
Disallow: /_next/
```

## 6. Performance

| Metric | Target | Tool |
|--------|--------|------|
| LCP | ≤ 2.5s | Lighthouse, Web Vitals |
| FID / INP | ≤ 100ms / ≤ 200ms | Lighthouse, Web Vitals |
| CLS | ≤ 0.1 | Lighthouse, Web Vitals |
| TTFB | ≤ 800ms | WebPageTest |
| First Load JS | ≤ 150 KB (critical) | Next.js bundle analyzer |

### Checklist

- [ ] Lazy-load below-fold images (`loading="lazy"`)
- [ ] Set explicit `width` + `height` on images (prevents CLS)
- [ ] Use modern image formats (WebP, AVIF)
- [ ] Preconnect to critical origins (`<link rel="preconnect">`)
- [ ] Preload critical fonts and hero images
- [ ] Inline critical CSS (or use Next.js `style` tags)
- [ ] Code-split heavy libraries
- [ ] Enable compression (Brotli on Vercel)
- [ ] Use CDN for static assets
- [ ] Set proper cache headers (`Cache-Control: public, max-age=31536000, immutable` for hashed assets)

## 7. Accessibility (WCAG AA Quick-Fire)

- [ ] All images have meaningful `alt` text (or `alt=""` for decorative)
- [ ] Color contrast ≥ 4.5:1 for normal text, ≥ 3:1 for large text
- [ ] All form inputs have associated `<label>` elements
- [ ] Skip-to-content link as first focusable element
- [ ] Heading hierarchy: one `h1` per page, sequential `h2-h6`
- [ ] Focus indicators visible (never `outline: none` without replacement)
- [ ] All interactive elements are keyboard-accessible
- [ ] ARIA labels where native semantics are insufficient
- [ ] Touch targets ≥ 44x44 px on mobile
- [ ] `prefers-reduced-motion` respected
- [ ] Error messages associated with inputs via `aria-describedby`
- [ ] Page language set (`<html lang="en">`)

See `wcag-aa-standards.md` for full guide.

## 8. Security Headers

```
Strict-Transport-Security: max-age=31536000; includeSubDomains; preload
X-Content-Type-Options: nosniff
X-Frame-Options: DENY
Referrer-Policy: strict-origin-when-cross-origin
Permissions-Policy: camera=(), microphone=(), geolocation=()
Content-Security-Policy: default-src 'self'; script-src 'self'; style-src 'self' 'unsafe-inline'; img-src 'self' data: https:; connect-src 'self'; font-src 'self'; frame-ancestors 'none'; base-uri 'self'; form-action 'self'
```

## 9. Edge-Case Hardening

- [ ] 404 page — styled on-brand, includes search or link to home
- [ ] 500 / error page — user-friendly message, "Try Again" or contact link
- [ ] Loading state — skeleton or spinner matching the design system
- [ ] Empty state — helpful message with CTA (no blank pages)
- [ ] Offline state — basic offline page or PWA service worker fallback
- [ ] Long content — "Back to top" button after ~2 viewports
- [ ] Print styles — `@media print` hides nav, footer, CTAs
- [ ] Reduced motion — `@media (prefers-reduced-motion: no-preference)` for animations

## 10. SEO Technical

- [ ] Submit sitemap to Google Search Console & Bing Webmaster Tools
- [ ] Verify domain ownership (DNS TXT record or meta tag)
- [ ] Set up `_redirects` or `next.config.js` redirects for old URLs
- [ ] Implement hreflang for multi-language sites
- [ ] Paginated content uses `rel="next"` / `rel="prev"`
- [ ] Breadcrumb structured data on all interior pages
- [ ] Noindex/nofollow on admin, staging, duplicate content

## 11. Monitoring & Maintenance

| Tool | Purpose |
|------|---------|
| Google Search Console | Crawl errors, index coverage, search analytics |
| Lighthouse CI | Performance/accessibility regression detection |
| Calibre / SpeedCurve | Real-user monitoring (RUM) |
| Plausible / Fathom | Privacy-first analytics |
| Datadog RUM | Full observability |
| Checkly | Synthetic monitoring + Playwright E2E |

## 12. Brand Asset Checklist

- [ ] Logo (SVG + PNG, light and dark variants)
- [ ] OG image template (Figma or programmatic)
- [ ] Brand colours in CSS custom properties or Tailwind config
- [ ] Typography system (headings, body, mono, sizes, weights)
- [ ] Icon set (consistent style — Lucide, Phosphor, custom)
- [ ] Illustration style guide or component library
- [ ] Spacing scale (4px or 8px grid)
- [ ] Border radius rules (e.g. sm=4px, md=8px, lg=16px, full=9999px)
- [ ] Shadow/elevation system
