---
name: artis-ui-review
description: Review Artis (Astro/Tailwind) UI code for project-specific accessibility, component usage, theming, and UX conventions. Use for audits of .astro/.ts/.tsx/.css UI files in packages/admin or packages/site when asked to check UI guideline compliance.
---

# Artis UI Review

## Overview
Review UI code in Artis for project conventions and a11y/UX issues; report terse findings grouped by file.

## Review Checklist

### Project Conventions
- Use existing shared components before creating new UI.
- Use `Button` component for all actions.
- Use `Modal` component for confirmations; do not use `alert()` or `confirm()`.
- Use `Toast` for notifications via `window.dispatchEvent(new CustomEvent('artis:toast', ...))`.
- Use Tailwind with theme CSS variables; avoid hardcoded colors.
- Use semantic HTML and Artis class naming (`component-element`, `purpose-variant`, single dash).

### Accessibility & Semantics
- Icon-only buttons include `aria-label`.
- Form controls have `<label>` or `aria-label`.
- Use `<button>` for actions and `<a>` for navigation; no `<div>/<span>` click handlers.
- Non-native interactive elements include keyboard handlers and appropriate `role`.
- Images include `alt` (or `alt=""` if decorative).
- Decorative icons use `aria-hidden="true"`.
- Async updates (toasts/validation) announce with `aria-live="polite"` when applicable.

### Focus & Interactive States
- Provide visible focus with `:focus-visible` (Tailwind `focus-visible:*`).
- Avoid `outline-none` without a focus-visible replacement.
- Buttons/links include hover and active states.

### Forms
- Inputs include `name` and `autocomplete`.
- Use correct `type` and `inputmode` where relevant.
- Labels are clickable; checkboxes/radios share a single hit target with label.
- Do not block paste with `onPaste` + `preventDefault`.
- Inline errors next to fields; focus first error on submit when validating.
- Disable submit only after request starts; show spinner during request.
- Warn before navigation when there are unsaved changes.

### Content & Copy
- Use `…` (not `...`); loading states end with `…`.
- Use Title Case for headings and buttons.
- Use specific action labels (e.g., “Save Settings”).
- Handle long content (truncate/break-words, `min-w-0`).
- Provide empty states for empty lists/strings.

### Images
- Set explicit `width` and `height` on `<img>`.
- Use `loading="lazy"` for below-fold images.

### Motion
- Honor `prefers-reduced-motion`.
- Animate `transform`/`opacity`; avoid `transition: all`.

## Output Format
Group by file. Use `file:line` (VS Code clickable). Terse findings; no preamble. Skip explanation unless fix is non-obvious.

```text
## packages/admin/src/components/Example.astro

packages/admin/src/components/Example.astro:42 - icon button missing aria-label
packages/admin/src/components/Example.astro:18 - input lacks label
packages/admin/src/components/Example.astro:67 - transition: all → list properties

## packages/site/src/components/Card.astro

✓ pass
```
