---
name: mobile-responsiveness
description: Build responsive, mobile-first web applications. Use when implementing responsive layouts, touch interactions, mobile navigation, or optimizing for various screen sizes. Triggers on responsive design, mobile-first, breakpoints, touch events, viewport.
---

# Mobile Responsiveness

## Core Principles

1. **Mobile-first:** Start with mobile styles, layer on complexity at larger breakpoints
2. **Touch-friendly:** Minimum 48px touch targets, generous spacing
3. **Progressive disclosure:** Show less on mobile, reveal more as space allows

## Quick Reference

| Task | Reference |
|------|-----------|
| Breakpoints & media queries | ./references/breakpoints.md |
| Typography scaling | ./references/typography.md |
| Modals & drawers | ./references/modals.md |
| Tables | ./references/tables.md |
| Touch interactions | ./references/touch.md |
| Form inputs | ./references/inputs.md |
| Spacing, rhythm & stacking | ./references/vertical-rhythm.md, ./references/stacking.md |

## Usage

1. Identify which patterns apply to the task
2. Read relevant reference file(s)
3. Apply mobile styles first, then add `sm:`, `md:`, `lg:` variants
4. Verify touch targets meet 48px minimum
5. Test stacking behavior at narrow widths

## Important

Mobile optimizations must not compromise desktop functionality. Ensure hover states, pointer precision targets, keyboard navigation, and cursor behaviors remain intact. Use feature queries and media queries to scope touch-specific behavior:

- `@media (hover: hover)` — apply hover effects only when supported
- `@media (pointer: coarse)` — target touch devices specifically
- Avoid removing `:hover` or `:focus` states globally
- Don't inflate touch targets in ways that break desktop density

## Mobile Navigation

```tsx
import { useState } from 'react';

function MobileNav() {
  const [isOpen, setIsOpen] = useState(false);

  return (
    <>
      {/* Hamburger button - visible on mobile */}
      <button
        className="md:hidden p-2"
        onClick={() => setIsOpen(!isOpen)}
        aria-expanded={isOpen}
        aria-label="Toggle menu"
      >
        <span className={`hamburger ${isOpen ? 'open' : ''}`} />
      </button>

      {/* Mobile menu */}
      <nav
        className={`
          fixed inset-0 bg-white z-50 transform transition-transform
          ${isOpen ? 'translate-x-0' : '-translate-x-full'}
          md:static md:translate-x-0 md:bg-transparent
        `}
      >
        <ul className="flex flex-col md:flex-row gap-4 p-4 md:p-0">
          <li><a href="/">Home</a></li>
          <li><a href="/about">About</a></li>
          <li><a href="/contact">Contact</a></li>
        </ul>
      </nav>

      {/* Backdrop */}
      {isOpen && (
        <div
          className="fixed inset-0 bg-black/50 z-40 md:hidden"
          onClick={() => setIsOpen(false)}
        />
      )}
    </>
  );
}
```

## Safe Areas (Notch/Home Indicator)

```css
/* Account for iPhone notch and home indicator */
.container {
  padding-left: env(safe-area-inset-left);
  padding-right: env(safe-area-inset-right);
  padding-bottom: env(safe-area-inset-bottom);
}

/* Fixed bottom navigation */
.bottom-nav {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  padding-bottom: max(1rem, env(safe-area-inset-bottom));
}
```

## Viewport Meta Tag

```html
<meta 
  name="viewport" 
  content="width=device-width, initial-scale=1, viewport-fit=cover"
/>
```

## useMediaQuery Hook

```tsx
import { useState, useEffect } from 'react';

function useMediaQuery(query: string): boolean {
  const [matches, setMatches] = useState(false);

  useEffect(() => {
    const media = window.matchMedia(query);
    setMatches(media.matches);

    const listener = (e: MediaQueryListEvent) => setMatches(e.matches);
    media.addEventListener('change', listener);
    
    return () => media.removeEventListener('change', listener);
  }, [query]);

  return matches;
}

// Usage
function Component() {
  const isMobile = useMediaQuery('(max-width: 767px)');
  const isTablet = useMediaQuery('(min-width: 768px) and (max-width: 1023px)');
  const isDesktop = useMediaQuery('(min-width: 1024px)');

  return isMobile ? <MobileView /> : <DesktopView />;
}
```

## Native-Feeling Interactions

Mobile web apps should match platform conventions and feel responsive.

### Feedback & States

```tsx
// Tactile button feedback
<button className="active:scale-95 transition-transform duration-100">
  Tap Me
</button>

// Touch highlight
<button className="hover:bg-gray-100 active:bg-gray-200 transition-colors">
  Press Me
</button>

// Disable text selection on interactive elements
<div className="select-none touch-manipulation">
  Interactive Area
</div>
```

### Gestures & Scrolling

```tsx
// Smooth momentum scrolling
<div className="overflow-y-auto overscroll-contain scroll-smooth">
  {/* scrollable content */}
</div>

// Prevent pull-to-refresh on custom scroll areas
<div className="overflow-y-auto overscroll-none">
  {/* content */}
</div>

// Snap scrolling for carousels
<div className="flex overflow-x-auto snap-x snap-mandatory gap-4">
  {items.map((item) => (
    <div key={item.id} className="snap-start shrink-0 w-[85vw]">
      {item.content}
    </div>
  ))}
</div>
```

### Performance Perception

```tsx
// Optimistic UI feedback
const [isSubmitting, setIsSubmitting] = useState(false);

<button
  disabled={isSubmitting}
  className="relative disabled:opacity-70"
>
  {isSubmitting && (
    <span className="absolute inset-0 flex items-center justify-center">
      <Spinner className="h-5 w-5 animate-spin" />
    </span>
  )}
  <span className={isSubmitting ? 'invisible' : ''}>Submit</span>
</button>
```

### Key Principles

- Add immediate visual feedback on touch (scale, color change)
- Use `touch-manipulation` to eliminate 300ms tap delay
- Match platform scroll physics with `overscroll-contain`
- Disable unwanted behaviors: text selection, context menus on UI elements
- Provide loading states for any action over 100ms
- Use CSS transitions (100–200ms) for responsive-feeling state changes


## Resources

- **Responsive Design**: https://web.dev/learn/design/
- **Mobile-First CSS**: https://developer.mozilla.org/en-US/docs/Learn/CSS/CSS_layout/Responsive_Design
- **Viewport Units**: https://developer.mozilla.org/en-US/docs/Web/CSS/length#viewport-percentage_lengths
