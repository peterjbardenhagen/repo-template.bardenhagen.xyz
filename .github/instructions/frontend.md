---
applyTo: "**/*.{tsx,jsx,vue,svelte,css,scss,html}"
---

# Frontend and user-interface instructions

These are adaptable defaults. Follow the existing design system and root `AGENTS.md`; do not introduce a second component or styling system without a reason.

- Design for mobile-first responsive layouts and verify representative desktop, tablet and mobile sizes.
- Cover loading, empty, partial, error, success and permission-denied states where applicable.
- Preserve keyboard navigation, visible focus, semantic structure, screen-reader labels and WCAG AA contrast.
- Use existing design tokens and shared components; avoid hard-coded brand-specific values in generic components.
- Keep interactive targets comfortable for touch and prevent horizontal overflow at narrow viewport widths.
- Avoid exposing secrets or sensitive data in client bundles, URLs, console output or analytics.
- Add component and interaction tests for important behaviour, not only snapshots.
- Check reduced-motion preferences and provide meaningful feedback for async actions.
