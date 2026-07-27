# WCAG AA — Web Content Accessibility Standards

> **Level AA conformance** covers all Level A and AA success criteria. This is the legal/compliance target for most jurisdictions (ADA, AODA, EN 301 549, EU Web Accessibility Directive, Australia DDA).

---

## Perceivable — Information must be presentable to users in ways they can sense

### 1.1.1 Non-text Content (A)
- [ ] All images have meaningful `alt` text
- [ ] Decorative images use `alt=""` (empty alt) or CSS background-image
- [ ] Complex images (charts, graphs) have long descriptions or data tables nearby
- [ ] Icons with meaning have text labels or `aria-label`

### 1.2.x Time-based Media (A/AA)
- [ ] Pre-recorded video has captions (A)
- [ ] Pre-recorded audio has a transcript (A)
- [ ] Live video has captions (AA)
- [ ] Auto-playing video/audio >3s has a pause/stop mechanism

### 1.3.x Adaptable (A/AA)
- [ ] Content structure is conveyed by semantic HTML (headings, lists, landmarks), not visual styling alone (A)
- [ ] Information, structure, and relationships are programmatically determinable (A)
- [ ] Reading order is correct when CSS is disabled (A)
- [ ] Instructions don't rely solely on sensory characteristics (shape, size, colour, location) (A)
- [ ] Content adapts without loss when viewport is zoomed to 400% (AA)
- [ ] Orientation is not locked (portrait/landscape) unless essential (AA)

### 1.4.x Distinguishable (A/AA)
- [ ] Colour is not the only way to convey information (A)
- [ ] Auto-playing audio can be stopped or volume controlled (A)
- [ ] **Colour contrast:** Normal text ≥ 4.5:1, large text (≥18px bold/≥24px) ≥ 3:1 (AA)
- [ ] **Non-text contrast:** UI components and graphical objects ≥ 3:1 (AA)
- [ ] Text can be resized to 200% without loss of content (AA)
- [ ] Images of text are avoided or essential (use real text) (AA)
- [ ] Reflow: content at 400% zoom does not require 2D scrolling (AA)
- [ ] Hover/focus indicators are visible (AA)

---

## Operable — Interface must be operable by all users

### 2.1.x Keyboard Accessible (A)
- [ ] All functionality is operable via keyboard
- [ ] No keyboard traps (focus can be moved away)
- [ ] No character-key shortcuts (single-key shortcuts require modification)

### 2.2.x Enough Time (A/AA)
- [ ] Time limits have an option to turn off, adjust, or extend (A)
- [ ] Moving, blinking, scrolling content can be paused (A)
- [ ] Timeouts are announced or user data is preserved for 20+ hours (AA)

### 2.3.x Seizures (A)
- [ ] No flashing content >3 flashes per second

### 2.4.x Navigable (A/AA)
- [ ] **Skip link** as first focused element (A)
- [ ] Pages have descriptive titles (`<title>`) (A)
- [ ] Focus order follows a logical sequence (A)
- [ ] Link purpose is clear from text alone or from context (A)
- [ ] More than one way to find a page (nav, sitemap, search) (AA)
- [ ] **Headings and labels** describe topic or purpose (AA)
- [ ] **Focus indicator** is visible (minimum 2px outline, 3:1 contrast) (AA)

### 2.5.x Input Modalities (A/AA)
- [ ] All functionality via pointer can also be activated via single click (A)
- [ ] Pointer cancellation — no down-event activation without ability to cancel (A)
- [ ] **Touch target** minimum 44x44 px (AA)
- [ ] Motion actuation can be disabled (AA)

---

## Understandable — Content and interface must be understandable

### 3.1.x Readable (A/AA)
- [ ] Page language set with `<html lang="...">` (A)
- [ ] Language changes indicated with `lang` attribute on the element (AA)

### 3.2.x Predictable (A/AA)
- [ ] Navigation is consistent across pages (A)
- [ ] Components with similar functionality are labelled consistently (A)
- [ ] No context change on input without warning (A)
- [ ] Navigation changes are consistent across pages (AA)

### 3.3.x Input Assistance (A/AA)
- [ ] Errors are identified and described to the user (A)
- [ ] Labels or instructions for all inputs (A)
- [ ] Suggestions for error correction (AA)
- [ ] Prevent serious consequences from reversible, checked, or confirmed actions (A)
- [ ] **Helpful error messages** with clear fix instructions (AA)

---

## Robust — Content must be interpretable by a wide range of user agents

### 4.1.x Compatible (A/AA)
- [ ] Complete start/end tags, no duplicate attributes, unique IDs (A)
- [ ] **Name, Role, Value** of all UI components are programmatically determinable (A)
- [ ] Status messages are programmatically determinable via `role="status"` or `aria-live` (AA)
- [ ] ARIA attributes follow the specification / valid for the element (AA)

---

## Practical Implementation Checklist

### HTML / Framework

- [ ] `<html lang="en">` (or correct lang code)
- [ ] Semantic HTML: `<nav>`, `<main>`, `<aside>`, `<article>`, `<section>`, `<header>`, `<footer>`
- [ ] One `<h1>` per page, sequential heading hierarchy
- [ ] All `<img>` have `alt` (meaningful or empty)
- [ ] All `<button>` have text content or `aria-label`
- [ ] All `<a>` have href or are `role="button"`
- [ ] All `<input>` / `<select>` / `<textarea>` have associated `<label>`
- [ ] Error messages use `aria-describedby` on the input
- [ ] Live regions (`aria-live="polite"`) for dynamic content updates
- [ ] `role="alert"` for important, time-sensitive messages

### CSS / Visual

- [ ] Focus styles never removed without replacement (`outline: none` → custom `:focus-visible`)
- [ ] `prefers-reduced-motion: no-preference` wraps animations
- [ ] `prefers-color-scheme` respected if supporting dark mode
- [ ] Touch targets ≥ 44x44 px
- [ ] Colour contrast verified with tool (axe, WAVE, Contrast Checker)

### Components

- [ ] Modals: focus trap, `aria-modal="true"`, `role="dialog"`, close on `Escape`, return focus on close
- [ ] Tabs: `role="tablist"`, `role="tab"`, `aria-selected`, `role="tabpanel"`, arrow-key navigation
- [ ] Accordions: `<button>` as trigger, `aria-expanded`, `aria-controls`
- [ ] Tooltips: hover + focus activation, dismissible
- [ ] Carousels: pause on hover/focus, next/prev buttons, live region if auto-rotating
- [ ] Forms: validation on blur + submit, inline error messages, `aria-invalid` on error fields
- [ ] Tables: `<th>` with `scope`, `<caption>` or `aria-label`, `role="rowheader"` for complex tables
- [ ] Skip link: visible on focus, links to `#main-content`

### Testing Tools

| Tool | What It Checks |
|------|---------------|
| axe DevTools (browser ext) | Automated WCAG AA rules |
| WAVE (browser ext/API) | Visual overlay of issues |
| Lighthouse | Automated a11y score |
| NVDA / JAWS | Screen reader testing |
| VoiceOver (macOS/iOS) | Screen reader testing |
| Chrome DevTools a11y pane | Full accessibility tree |
| Colour Contrast Analyser | Manual colour pair checking |
| Tab key test | Keyboard flow |

### Testing Protocol

```markdown
### [Feature Name] — Accessibility Test

- [ ] Keyboard navigation: Tab through all interactive elements — logical order?
- [ ] Focus visible at every stop?
- [ ] Screen reader: Navigate with headings (`H` key), landmarks, form fields
- [ ] Zoom to 200% — content still readable, no horizontal scroll?
- [ ] Reduced motion preference — animations disabled?
- [ ] High contrast mode (Windows) — all text visible?
- [ ] Voice dictation (macOS/iOS) — can activate all controls?
- [ ] Contrast check: every text/background pair ≥ 4.5:1
- [ ] Errors: submit empty form — error messages clear and associated?
```

### Automated CI Integration

```yml
# .github/workflows/a11y.yml (example snippet)
- name: Check a11y
  run: npx axe --exit --show-errors
```

Or integrate into your E2E test suite:

```ts
// Playwright + axe-core
import { injectAxe, checkA11y } from 'axe-playwright';
await injectAxe(page);
await checkA11y(page, null, { includedImpacts: ['critical', 'serious'] });
```

---

## Resources

- [WCAG 2.2 Quick Reference](https://www.w3.org/WAI/WCAG22/quickref/)
- [WebAIM Contrast Checker](https://webaim.org/resources/contrastchecker/)
- [A11y Project Checklist](https://www.a11yproject.com/checklist/)
- [Inclusive Components](https://inclusive-components.design/) — accessible component patterns
- [Heydon's Inclusive Design Principles](https://inclusive-components.design/)
- [UK Government Accessibility Blog](https://accessibility.blog.gov.uk/)
- [ARIA Authoring Practices Guide (APG)](https://www.w3.org/WAI/ARIA/apg/patterns/)
