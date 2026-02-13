---
name: app-design-audit
description: Audit UI/UX execution against core visual design principles, layout, typography, color, accessibility (WCAG), motion, and consistency. Use when asked to review, critique, or improve an application's interface, product screens, website, dashboard, or design system, or to identify improvement opportunities and actionable fixes.
---

# App Design Audit

## Overview
Run a structured UI/UX audit and deliver a prioritized list of issues, opportunities, and concrete fixes. Tie findings to specific screens, components, or flows.

## Workflow

### 1. Scope and context
- Identify platform (web, mobile, desktop) and key user goals.
- Ask for entry points, critical flows, and constraints (brand, theme system, existing components).
- If assets or screens are missing, request them.

### 2. Visual design audit
Check core principles and note violations or opportunities:
- Contrast, hierarchy, alignment, proximity, repetition, balance.
- Layout/grid consistency and responsive behavior.
- Color system, palette limits, grayscale legibility, cultural implications when relevant.
- Typography: typeface pairing, scale, line-height, legibility, all-caps usage.
Reference: `references/design-principles.md` for detailed mechanics.

### 3. Component and consistency audit
- Verify consistent component behavior, spacing, and states.
- Identify patterns that should be consolidated into shared components.
- Check CTA visibility and affordances.

### 4. UX and flow audit
- Reduce cognitive load by simplifying layouts and copy.
- Evaluate task flows: steps, errors, and empty states.
- Review navigation and information architecture for findability.

### 5. Motion and feedback
- Ensure animations communicate state changes and do not harm performance.
- Validate hover/pressed/loading feedback and reduce motion risk.

### 6. Accessibility audit (WCAG-aligned)
- Check color contrast, focus states, and keyboard navigation.
- Verify target sizes and spacing for motor accessibility.
- Provide alternatives for non-text content and avoid color-only signals.

### 7. Deliverable format
Provide:
- A prioritized issue list (P0–P3) with evidence.
- For each item: location, why it matters, fix recommendation, expected impact.
- Quick wins vs larger refactors.
- If no issues: state that explicitly and note residual risks or untested areas.

## Output templates

Issue format:
- `Title` — Severity (P0–P3)
- `Where` — screen/component/path
- `Problem` — principle violated + user impact
- `Fix` — concrete change
- `Notes` — assumptions or constraints

## Resources
- `references/design-principles.md` for detailed principles, accessibility, typography, color, layout, and testing practices.
