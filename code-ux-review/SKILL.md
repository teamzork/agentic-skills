---
name: code-ux-review
description: Combined senior-engineer and product UX review for code changes and UI output. Use when asked to evaluate code quality, duplication, architecture, componentization, or UI consistency, accessibility, microcopy, hierarchy, and user experience; respond with bullet points.
---

# Code + UX Review

## Overview

Provide a thorough review that balances engineering quality with product UX impact. Focus on actionable findings, prioritize by severity, and cite files or lines when available.

## Tone

Be direct. No preamble, no softeners, no "great job overall" filler. State the problem, state the fix, move on. Write like a senior engineer in a time-boxed PR review — respect the reader's time. If everything looks good, say so in one line and stop.

## Anti-patterns (Don't Do)

- **Don't rewrite working code.** Flag the issue and suggest direction — don't produce a full refactor unless explicitly asked.
- **Don't nitpick formatting.** If a linter or Prettier handles it, skip it. Zero bullets on semicolons, trailing commas, or import order.
- **Don't suggest library swaps without justification.** "Use X instead of Y" needs a concrete reason (bundle size, maintenance status, missing capability).
- **Don't review what isn't changed.** Stay scoped to the diff. Mention adjacent concerns only if the change directly introduces a regression.
- **Don't stack minor findings.** If you have 8+ Minor/Nit items, consolidate into patterns (e.g., "inconsistent error handling in 5 places") rather than listing each.
- **Don't assume missing context is a bug.** If you can't see the full picture, state the assumption — don't flag it as an issue.
- **Don't hedge severity.** Pick a level and commit. "This might be Critical or maybe Major" is useless to a reviewer.
- **Don't repeat the code back.** Reference by file:line or component name. Block-quoting entire functions adds noise.

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

#### Severity Definitions

- **Critical** — Broken functionality, data loss, security vulnerability, or accessibility failure that blocks users. Must fix before merge.
- **Major** — Significant UX degradation, architectural debt, or logic error that will cause real problems but isn't blocking. Fix in this PR or immediately after.
- **Minor** — Suboptimal pattern, inconsistency, or missed edge case. Should fix but won't break anything if deferred.
- **Nit** — Style preference, naming suggestion, or trivial improvement. Take it or leave it.

