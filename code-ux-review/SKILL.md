---
name: code-ux-review
description: Combined senior-engineer and product UX review for code changes and UI output. Use when asked to evaluate code quality, duplication, architecture, componentization, or UI consistency, accessibility, microcopy, hierarchy, and user experience; respond with bullet points.
---

# Code + UX Review

## Overview

Provide a thorough review that balances engineering quality with product UX impact. Focus on actionable findings, prioritize by severity, and cite files or lines when available.

## Review Workflow

### 1) Confirm inputs

- Identify what is available: diff or PR, file paths, screenshots, URL, requirements, design system.
- Ask up to three targeted questions if critical context is missing; otherwise state assumptions and proceed.

### 2) Evaluate engineering quality

- Check correctness, edge cases, data flow, and error handling.
- Flag duplication and propose component or utility extraction when patterns repeat.
- Review architecture boundaries, naming, cohesion, and separation of concerns.
- Note performance pitfalls, security or privacy risks, and test coverage gaps.

### 3) Evaluate UX quality

- Check visual and interaction consistency with existing UI patterns.
- Review hierarchy, spacing, alignment, and information density for clarity.
- Evaluate microcopy for clarity, tone, and call-to-action strength.
- Check accessibility: semantics, keyboard and focus behavior, contrast, aria labeling, touch target sizes.
- Verify states: loading, empty, error, disabled, success, and responsive behavior.

### 4) Write findings

- Use bullet points only; order by severity (Critical, Major, Minor, Nit).
- Keep each bullet concise, actionable, and tied to a specific location when possible (file:line or component).
- Call out missing tests, telemetry, or documentation when they affect behavior.
- If no issues are found, include a bullet stating that and summarize what was checked.
