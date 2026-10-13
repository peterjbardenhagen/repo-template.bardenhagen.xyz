# Brand Guidelines

> **Template.** Replace the bracketed placeholders with your brand's actual values.

## Brand Identity

| Field | Value |
|-------|-------|
| **Brand Name** | `[Brand Name]` |
| **Tagline** | `[Tagline — one sentence]` |
| **Brand Voice** | `[e.g. Professional yet approachable, technical but not jargon-heavy]` |
| **Brand Personality** | `[Adjectives: Innovative, Trustworthy, Bold, Friendly, etc.]` |
| **Target Audience** | `[Describe primary and secondary audiences]` |

---

## Logo

### Primary Logo

| Variant | File | Usage |
|---------|------|-------|
| Full logo (light bg) | `public/assets/logo.svg` | Most common — white/light backgrounds |
| Full logo (dark bg) | `public/assets/logo-white.svg` | Dark backgrounds |
| Mark / icon only | `public/assets/mark.svg` | Favicon, avatar, small spaces |
| Monochrome | `public/assets/logo-mono.svg` | Single-color applications (embroidery, stamps) |

### Logo Rules

- **Clear space:** Minimum `[X]` units of padding on all sides (equal to the height of the mark)
- **Minimum size:** `[XX]px` wide for full logo, `[XX]px` for mark
- **Do not:** stretch, rotate, recolour, add effects, or place on low-contrast backgrounds
- **Do not:** use the mark alone when the brand is not yet established in context

---

## Colour Palette

### Primary

| Swatch | Name | Hex | Usage |
|--------|------|-----|-------|
| ████ | Brand Primary | `#[code]` | CTAs, links, primary buttons |
| ████ | Brand Dark | `#[code]` | Headings, primary text |
| ████ | Brand Light | `#[code]` | Hover states, secondary elements |

### Neutral

| Swatch | Name | Hex | Usage |
|--------|------|-----|-------|
| ████ | Background | `#[code]` | Page background |
| ████ | Surface | `#[code]` | Cards, panels |
| ████ | Border | `#[code]` | Dividers, outlines |
| ████ | Text Primary | `#[code]` | Body text |
| ████ | Text Muted | `#[code]` | Secondary text, captions |

### Semantic

| Swatch | Name | Hex | Usage |
|--------|------|-----|-------|
| ████ | Success | `#[code]` | Positive states, confirmations |
| ████ | Warning | `#[code]` | Caution states |
| ████ | Error | `#[code]` | Errors, destructive actions |
| ████ | Info | `#[code]` | Informational states |

### Accessibility

- All text/background colour pairs must pass **WCAG AA**:
  - Normal text: contrast ratio ≥ **4.5:1**
  - Large text (≥18px bold or ≥24px regular): contrast ratio ≥ **3:1**
  - UI components and graphical objects: contrast ratio ≥ **3:1**

---

## Typography

### Primary Font: `[Font Name]`

| Weight | Size | Use Case |
|--------|------|----------|
| Light 300 | — | Large display text (optional) |
| Regular 400 | 16px | Body text |
| Medium 500 | — | Navigation, buttons |
| SemiBold 600 | — | Subheadings |
| Bold 700 | — | Headings |
| ExtraBold 800 | — | Hero headings (sparingly) |
| Black 900 | — | Display / marketing (sparingly) |

### Monospace Font: `[Font Name]`

| Weight | Use Case |
|--------|----------|
| Regular 400 | Code blocks, inline code |
| Medium 500 | Data, metrics, labels |
| Bold 700 | Emphasis in code context |

### Fallback Stack

```
Primary:  [font-name], [fallback], [generic]
Monospace: [font-name], [fallback], [generic]
```

### Type Scale

| Level | Size | Line Height | Weight | Use |
|-------|------|-------------|--------|-----|
| Hero | `[XX]rem` | `[1.0-1.2]` | Black 900 | Landing page hero |
| H1 | `[XX]rem` | `[1.1-1.3]` | Bold 700 | Page title |
| H2 | `[XX]rem` | `[1.2-1.4]` | Bold 700 | Section heading |
| H3 | `[XX]rem` | `[1.3-1.5]` | SemiBold 600 | Subsection heading |
| Body | `1rem` | `1.6-1.8` | Regular 400 | Paragraphs |
| Small | `0.875rem` | `1.5` | Regular 400 | Captions, metadata |
| Label | `0.75rem` | `1.4` | Medium 500 | Form labels, tags |
| Mono | `0.875rem` | `1.6` | Regular 400 | Code |

---

## Spacing

- **Base unit:** `[4px or 8px]`
- **Grid:** `[12 or 8]` column layout with `[24px or 32px]` gutter
- **Max content width:** `[1280px]`
- **Section padding:** `[4rem / 6rem / 8rem]` top and bottom

---

## Icons

- **Icon set:** `[Lucide / Phosphor / Custom / Other]`
- **Style:** `[Outline / Filled / Duotone]`
- **Default size:** `[20px or 24px]`
- **Stroke width:** `[1.5px or 2px]` (for outline sets)
- **Colour:** Inherit text colour by default; use brand primary for emphasis

---

## Imagery & Illustrations

- **Style:** `[Flat / 3D / Isometric / Hand-drawn / Photographic]`
- **Source:** `[Unsplash / Custom / Dribbble / etc.]`
- **Tone:** `[Warm, professional / Bright, energetic / Minimal, corporate]`
- **Photography rules:** `[e.g. "People should appear genuine, not staged. Desaturated filters. No stock photo clichés."]`

---

## Components

### Buttons

| Type | Background | Text | Border | Hover |
|------|-----------|------|--------|-------|
| Primary | Brand Primary | White | None | Darker shade |
| Secondary | Transparent | Brand Primary | Brand Primary | Filled with 10% opacity |
| Ghost | Transparent | Text Primary | None | Light grey bg |

- **Border radius:** `[6px / 8px / 9999px]`
- **Padding:** `[0.75rem 1.5rem]`
- **Font:** Label style, uppercase tracking `[0.1em]`

### Cards

- **Background:** Surface colour
- **Border:** `1px solid [border colour]`
- **Border radius:** `[8px / 12px / 16px]`
- **Shadow:** `[subtle / medium / prominent]`
- **Padding:** `[1.5rem / 2rem]`

### Forms

- **Input height:** `[44px]` (WCAG touch target minimum)
- **Border:** `1px solid [border colour]`, focus: `[brand primary]`
- **Border radius:** `[6px / 8px]`
- **Label:** Above input, `[0.875rem]`, medium weight
- **Error state:** Red border + `aria-describedby` error message
- **Placeholder:** Text muted colour

---

## Motion & Animation

- **Duration:** `[200-300ms]` for micro-interactions, `[400-600ms]` for page transitions
- **Easing:** `ease-out` for enter, `ease-in` for exit
- **Motion respect:** Always wrap animations in `@media (prefers-reduced-motion: no-preference)`
- **Parallax / scroll-triggered:** Use sparingly — degrade gracefully when disabled

---

## Writing Style

| Principle | Guideline |
|-----------|-----------|
| Tone | `[Professional, clear, concise]` |
| Readability | Short sentences, active voice, avoid jargon unless appropriate |
| Capitalisation | Sentence case for headings ("Get started today" not "Get Started Today") |
| Numbers | Numerals for 10+, words for 1-9, except dates and measurements |
| Currency | AUD$ [amount] (e.g. AUD$49) |
| Abbreviations | Spell out on first use, then abbreviate |
| Emoji | Use only in informal/marketing contexts, never in UI labels or errors |
| Inclusive language | Use gender-neutral terms, avoid idioms |

---

## Tone of Voice by Channel

| Channel | Tone | Example |
|---------|------|---------|
| Marketing site | `[Aspirational, benefit-driven]` | "Transform your workflow with AI." |
| App UI | `[Direct, helpful]` | "You have 3 overdue invoices." |
| Emails | `[Personal, warm]` | "Hi [Name], here's your weekly summary." |
| Error messages | `[Apologetic, solution-oriented]` | "Something went wrong. Please try again." |
| Social media | `[Conversational, energetic]` | "We just shipped [feature]! 🚀" |
| Documentation | `[Technical, precise]` | "The API accepts POST requests to /v1/endpoint." |

---

## File Naming

| Asset | Convention | Example |
|-------|-----------|---------|
| Components | `PascalCase.tsx` | `FeatureCard.tsx` |
| Pages | `kebab-case` | `case-study-lighting` |
| Images | `descriptive-kebab-case` | `hero-illustration.svg` |
| Icons | `kebab-case` | `icon-arrow-right.svg` |
| Documents | `kebab-case` | `brand-guidelines-template.md` |

---

## Implementation

### CSS Custom Properties

```css
:root {
  --brand-primary: #XXXXXX;
  --brand-dark: #XXXXXX;
  --brand-light: #XXXXXX;
  --bg: #XXXXXX;
  --surface: #XXXXXX;
  --text-primary: #XXXXXX;
  --text-muted: #XXXXXX;
  --border: #XXXXXX;
  --font-sans: '[Font Name]', [fallback], sans-serif;
  --font-display: '[Font Name]', [fallback], serif;
  --font-mono: '[Font Name]', [fallback], monospace;
  --radius-sm: 4px;
  --radius-md: 8px;
  --radius-lg: 16px;
  --space-unit: 4px;
  --max-width: 1280px;
}
```

### Tailwind Config

```ts
theme: {
  extend: {
    colors: {
      brand: { DEFAULT: '#XXXXXX', dark: '#XXXXXX', light: '#XXXXXX' },
      surface: { DEFAULT: '#XXXXXX', 50: '#XXXXXX', /* etc. */ },
    },
    fontFamily: {
      sans: ['"Font Name"', 'fallback', 'sans-serif'],
      display: ['"Font Name"', 'fallback', 'serif'],
      mono: ['"Font Name"', 'fallback', 'monospace'],
    },
  },
}
```
