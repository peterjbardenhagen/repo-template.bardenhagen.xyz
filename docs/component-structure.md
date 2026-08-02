# Component Structure

How to organise a React/Next.js App Router codebase so that pages stay thin,
styling stays shared, and swapping placeholder data for a real API touches one
file instead of twenty.

> Framework-specific. Skip for non-React projects — but the data-layer
> boundary in §3 applies to any stack.

---

## 1. Layout

```
src/
├── app/                    # Routes only — thin. One page.tsx per route
│   ├── layout.tsx          # Shared chrome (header, footer, providers)
│   ├── globals.css         # The shared visual language
│   └── <section>/
│       ├── page.tsx        # Composes components + calls the data layer
│       └── api/route.ts    # HTTP mirror of the same data function
├── components/             # Shared, reusable, presentational
├── lib/
│   └── data/               # Typed data access, one module per domain
└── generated/              # Build artifacts (gitignored)
```

The rule: **`app/` is for routing, not implementation.** A `page.tsx` that grows
past ~150 lines is holding something that belongs in `components/` or
`lib/data/`.

## 2. Server by Default, Client by Exception

Server Components are the default. Reach for `"use client"` only when the
component needs one of: state, effects, event handlers, refs, or browser APIs.

```tsx
// ✅ Server Component — no client JS shipped
export default async function ProjectsPage() {
  const projects = await getProjects();   // called directly, no fetch
  return <ProjectList projects={projects} />;
}
```

```tsx
// ✅ Client Component — genuinely interactive
'use client';
export function TabbedView({ tabs }: Props) {
  const [active, setActive] = useState(0);
  …
}
```

**Push `"use client"` down the tree, not up.** Marking a layout or page as a
client component opts its entire subtree out of server rendering. The usual
mistake is a page marked `"use client"` for one interactive widget; extract the
widget instead.

**A Server Component may render a Client Component, never the reverse.** Passing
a server-rendered element through as `children` is the escape hatch:

```tsx
<ClientProvider>
  <ServerRenderedContent />   {/* stays on the server */}
</ClientProvider>
```

Props crossing the boundary must be serialisable — no functions, no class
instances, no `Date` in some setups. Pass ISO strings and format on the far side.

## 3. The Data Layer

Every domain gets one module in `lib/data/` exporting typed functions. This is
the seam that lets placeholder data become a real API without touching the UI.

```ts
// lib/data/projects.ts
export interface Project {
  id: string;
  name: string;
  status: 'active' | 'archived';
}

export async function getProjects(): Promise<Project[]> {
  // Today: placeholder. Tomorrow: fetch(process.env.PROJECTS_API_URL).
  // Callers never change.
  return PLACEHOLDER_PROJECTS;
}
```

Rules:

- **Server Components call these functions directly.** Do not `fetch()` your own
  API route from a Server Component — it is an HTTP round-trip to your own
  process, and it breaks static rendering.
- **`app/api/*/route.ts` is a thin mirror** of the same function, existing only
  for client-side callers and external consumers.
- **Types live with the data**, exported alongside the function. One definition,
  imported everywhere.
- **Never let a component construct a URL or hold an API key.** If a component
  imports `process.env`, the boundary has leaked.

### The self-fetch trap

```tsx
// ❌ Breaks static rendering; fails at build time when nothing is listening
const res = await fetch(`${process.env.URL}/api/projects`, { cache: 'no-store' });

// ✅
const projects = await getProjects();
```

The first form forces the route to render dynamically and throws
`DYNAMIC_SERVER_USAGE` during a production build, because there is no server
running to answer.

## 4. Shared Chrome

Header, footer, navigation, and page headings belong in `components/` and are
rendered from `layout.tsx` — never re-implemented per page. When a page needs a
variant, add a prop; do not fork the component.

If shared chrome already renders the page title, the page body starts at `<h2>`.
See [`web-standards.md`](./web-standards.md#heading-hierarchy).

## 5. Styling

Three layers, in order of preference:

1. **Utility classes** for layout and one-off spacing.
2. **Shared component classes** in `globals.css` for anything appearing on more
   than one page (`.card`, `.btn`, `.page-header`).
3. **Inline `style={{}}`** only for genuinely dynamic values — a computed
   colour, a percentage width.

**Never per-page `<style>` blocks.** They are invisible to the linter, cannot be
reused, and are how a codebase ends up with six subtly different card styles.

Design tokens (colour, spacing, radius) belong in CSS custom properties in
`globals.css`, so a theme change is one edit:

```css
:root {
  --primary: #2563eb;
  --border:  #e2e8f0;
  --radius:  0.5rem;
}
```

## 6. Naming

| Kind | Convention | Example |
|---|---|---|
| Component file | `PascalCase.tsx` | `TaskCard.tsx` |
| Hook | `useCamelCase.ts` | `useMediaQuery.ts` |
| Data module | `kebab-case.ts` | `lib/data/user-profile.ts` |
| Route folder | `kebab-case` | `app/user-settings/` |
| Type/interface | `PascalCase`, no `I` prefix | `Project`, not `IProject` |

## Checklist

- [ ] No `page.tsx` over ~150 lines
- [ ] `"use client"` sits on leaf components, not pages or layouts
- [ ] Server Components call `lib/data/*` directly — no self-fetch
- [ ] Every `lib/data` function has an explicit return type
- [ ] No `process.env` outside `lib/` and config
- [ ] No per-page `<style>` blocks
- [ ] Repeated visual patterns are shared classes, not copy-paste
