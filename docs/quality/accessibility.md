# Accessibility (WCAG 2.1 AA) Implementation Guide

## Overview
This guide ensures all marketing content is accessible to people with disabilities, including visual, auditory, motor, and cognitive impairments.

**Target**: WCAG 2.1 Level AA Compliance

---

## 1. Perceivable

### Color Contrast
- **Minimum ratio**: 4.5:1 for normal text
- **Minimum ratio**: 3:1 for large text (18pt+)
- **Tool**: https://webaim.org/resources/contrastchecker/

```tsx
// ✅ CORRECT - High contrast
<p className="text-white bg-[#0a0a12]">Content</p>

// ❌ WRONG - Low contrast
<p className="text-gray-500 bg-[#1a1a28]">Content</p>
```

### Text Sizing
```tsx
// ✅ CORRECT - Minimum 16px
<p className="text-base">16px (default)</p>

// ✅ CORRECT - Fluid sizing
<h1 className="text-4xl md:text-5xl lg:text-6xl">Responsive</h1>

// ❌ WRONG - Too small
<p className="text-xs">12px</p>
```

### Color Not Only Indicator
```tsx
// ❌ WRONG - Only uses color to show error
<input className="border-red-500" type="email" />

// ✅ CORRECT - Color + icon/text
<div className="flex gap-2">
  <span className="text-red-500">✕</span>
  <input className="border-red-500" type="email" />
  <span className="text-red-500">Invalid email</span>
</div>
```

### Images & Alt Text
```tsx
// ✅ CORRECT - Descriptive alt text
<Image
  src="/dashboard.png"
  alt="MyDesk dashboard showing real-time BI metrics and profit margins"
  width={1200}
  height={600}
/>

// ❌ WRONG - Generic alt text
<Image src="/dashboard.png" alt="dashboard" width={1200} height={600} />

// ✅ CORRECT - Decorative images
<Image src="/divider.png" alt="" width={1200} height={2} />
```

### Multimedia Captions
```tsx
// ✅ CORRECT - Video with captions
<video controls>
  <source src="/demo.mp4" type="video/mp4" />
  <track src="/demo-captions.vtt" kind="captions" srclang="en" />
</video>

// ✅ CORRECT - Transcript provided
<section>
  <video controls>...</video>
  <details>
    <summary>Video Transcript</summary>
    <p>Transcript text here...</p>
  </details>
</section>
```

---

## 2. Operable

### Keyboard Navigation
```tsx
// ✅ CORRECT - All interactive elements focusable
<button onClick={handleClick} tabIndex={0}>
  Click me
</button>

// ✅ CORRECT - Visible focus indicator
.doc-btn:focus-visible {
  outline: 2px solid var(--accent);
  outline-offset: 2px;
}

// ❌ WRONG - Outline removed
.doc-btn:focus {
  outline: none;
}
```

### Skip Navigation
```tsx
// ✅ CORRECT - Skip to main content link
<a href="#main-content" className="sr-only focus:not-sr-only">
  Skip to main content
</a>

<nav>
  {/* Navigation items */}
</nav>

<main id="main-content">
  {/* Main content */}
</main>
```

### Focus Order
```tsx
// ✅ CORRECT - Natural tab order
<form>
  <input type="text" placeholder="First name" />
  <input type="text" placeholder="Last name" />
  <input type="email" placeholder="Email" />
  <button type="submit">Submit</button>
</form>

// ❌ WRONG - Disrupted focus order
<input tabIndex={10} type="text" />
<input tabIndex={5} type="text" />
<input tabIndex={1} type="text" />
```

### No Keyboard Traps
```tsx
// ✅ CORRECT - Escape key to close modal
<div role="dialog" onKeyDown={(e) => {
  if (e.key === 'Escape') closeModal();
}}>
  {/* Modal content */}
</div>
```

### Target Size
```tsx
// ✅ CORRECT - Minimum 44x44px touch target
<button className="p-3 rounded-lg">Action</button> {/* 44px+ */}

// ❌ WRONG - Too small
<button className="p-1">Action</button> {/* ~24px */}
```

---

## 3. Understandable

### Readable Text
```tsx
// ✅ CORRECT - Clear, simple language
<p>Click the button to start a free trial.</p>

// ❌ WRONG - Complex jargon
<p>Instantiate user provisioning workflow initiation sequence.</p>
```

### Consistent Navigation
```tsx
// ✅ CORRECT - Consistent menu structure
<nav>
  <a href="/features">Features</a>
  <a href="/pricing">Pricing</a>
  <a href="/contact">Contact</a>
</nav>
// Same structure on every page
```

### Error Identification & Correction
```tsx
// ✅ CORRECT - Clear error messages
<div role="alert" className="text-red-500">
  <p>Email format is invalid</p>
  <p>Please use format: name@example.com</p>
</div>

// ❌ WRONG - Vague error
<p className="text-red-500">Error</p>
```

### Form Labels
```tsx
// ✅ CORRECT - Proper labels
<label htmlFor="email">Email Address</label>
<input
  id="email"
  type="email"
  aria-required="true"
  aria-describedby="email-hint"
/>
<span id="email-hint">Required. Format: name@example.com</span>

// ❌ WRONG - No label
<input type="email" placeholder="Email" />
```

---

## 4. Robust

### Semantic HTML
```tsx
// ✅ CORRECT - Semantic structure
<header>
  <nav>Navigation</nav>
</header>
<main>
  <section>
    <article>Blog post</article>
  </section>
</main>
<footer>Footer</footer>

// ❌ WRONG - Only divs
<div>
  <div>Navigation</div>
</div>
```

### ARIA (Accessible Rich Internet Applications)
```tsx
// ✅ CORRECT - ARIA labels for complex components
<button
  aria-label="Close menu"
  aria-expanded={isOpen}
  onClick={toggleMenu}
>
  <X className="w-5 h-5" />
</button>

// ✅ CORRECT - Live regions for dynamic content
<div role="status" aria-live="polite">
  {successMessage && <p>{successMessage}</p>}
</div>

// ✅ CORRECT - Landmarks
<nav aria-label="Main navigation">
  {/* Navigation items */}
</nav>
```

### Form Validation
```tsx
// ✅ CORRECT - Accessible validation
<div>
  <label htmlFor="password">Password</label>
  <input
    id="password"
    type="password"
    aria-invalid={!isValid}
    aria-describedby={!isValid ? "password-error" : undefined}
  />
  {!isValid && (
    <span id="password-error" role="alert" className="text-red-500">
      Password must be at least 8 characters
    </span>
  )}
</div>
```

---

## Testing Checklist

### Automated Testing
- [ ] Axe DevTools: 0 violations
- [ ] WAVE: 0 errors
- [ ] Lighthouse A11y: 100
- [ ] Jest accessibility tests pass

### Manual Testing
- [ ] Keyboard only navigation (no mouse)
- [ ] Tab order is logical
- [ ] Focus visible at all times
- [ ] No keyboard traps
- [ ] Form errors clear

### Screen Reader Testing
- [ ] NVDA (Windows)
- [ ] JAWS (Windows, paid)
- [ ] VoiceOver (Mac, iOS)
- [ ] TalkBack (Android)

### User Testing
- [ ] Test with actual users with disabilities
- [ ] Blind/low vision users
- [ ] Motor impairment users
- [ ] Deaf/hard of hearing users
- [ ] Cognitive impairment users

---

## Tools

### Testing & Audit
- Axe DevTools: https://www.deque.com/axe/devtools/
- WAVE: https://wave.webaim.org/
- Lighthouse: Built-in Chrome DevTools
- Screen readers: NVDA (free), VoiceOver (Mac), TalkBack (Android)

### Reference
- WCAG 2.1 Guidelines: https://www.w3.org/WAI/WCAG21/quickref/
- WebAIM: https://webaim.org/
- MDN Accessibility: https://developer.mozilla.org/en-US/docs/Web/Accessibility

---

## Common Issues & Fixes

| Issue | Solution |
|-------|----------|
| Images without alt text | Add descriptive alt text |
| Low color contrast | Use WebAIM contrast checker |
| Missing form labels | Add `<label htmlFor>` |
| No focus indicator | Add CSS `:focus-visible` |
| Color only indicator | Add icon/text with color |
| Modal without focus trap | Use `<dialog>` or manage focus |
| Missing ARIA labels | Add `aria-label` or `aria-labelledby` |
| Keyboard traps | Test with keyboard only |
| Inaccessible PDFs | Re-export or provide HTML version |
| Video without captions | Add WebVTT caption file |

---

## Resources for Learning

1. **WebAIM** (Web Accessibility In Mind)
   - Color contrast: https://webaim.org/resources/contrastchecker/
   - Articles: https://webaim.org/

2. **A11ycasts** (Google Chrome)
   - Video series: https://www.youtube.com/playlist?list=PLNYkxOF6rcICWx0C9Xc-RgEzwLvePng7V

3. **The A11Y Project**
   - Resources: https://www.a11yproject.com/

---

**Last Updated**: 2026-07-28
**Version**: 1.0
