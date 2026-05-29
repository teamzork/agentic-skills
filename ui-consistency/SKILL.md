---
name: ui-consistency
description: "Scan UI code for repeated markup patterns and surface component extraction opportunities. Use when reviewing components, auditing a feature area, or preparing a refactor. Triggers on repeated JSX, duplicated className strings, inline style patterns, and inconsistent dark-mode pairing."
allowed-tools:
  - Read
  - Bash
  - Grep
  - Glob
---

# UI Consistency Scan

## Goal

Find markup patterns that appear 2+ times across the codebase. Each repetition is a candidate for a shared component. Report findings concisely; propose an extraction only when the pattern is stable enough to justify it.

## Scope

Default scan root: `src/`. Narrow with `$ARGUMENTS` (a directory or glob). Adjust the root if this project keeps UI elsewhere (`app/`, `components/`, `packages/*/src`).

## Load project seeds first (the bridge)

This skill is generic. Project-specific knowledge — known repeated patterns, the
light→dark palette, and baseline components to skip — lives **in the project
repo**, not in this skill. Before scanning:

1. If the project's `CLAUDE.md` / `AGENTS.md` routes you to a UI-consistency
   seeds file, read that file.
2. Otherwise probe the conventional path: `docs/ui-consistency-seeds.md`. If it
   exists, read it.

Treat the seeds file as authoritative for this repo: run its structural seed
greps in addition to the generic scan, use its palette for the dark-mode check,
and never propose re-creating a component it lists as baseline. If no seeds file
exists, proceed with the generic exact-duplicate scan alone.

## Process

### 1. Collect repetition candidates

**Primary mechanism — exact-duplicate scan (most reliable, never goes stale):**

```bash
# ripgrep (preferred — one engine across macOS/Linux, also catches plain class=)
rg -oI --no-filename 'class(Name)?="[^"]{60,}"' src/ -t ts | sort | uniq -d

# POSIX fallback if rg is unavailable (BRE interval works on BSD + GNU grep)
grep -roh 'className="[^"]\{60,\}"' src/ --include="*.tsx" | sort | uniq -d
```

Makes no assumption about *which* strings exist, so it survives utility-class reordering and churn. This is the workhorse. **Caveat:** `uniq -d` counts across the whole tree — it does NOT distinguish same-file vs cross-file duplicates. Treat output as candidates; confirm the ≥ 2-files rule in step 2 by re-grepping each string with `-l`.

**Structural seeds (from the project seeds file, if any):** run those greps too. For patterns that span multiple lines (e.g. `type="button"` on one line, its className on another), `grep`/`rg` line-mode cannot match the conjunction — use ripgrep multiline:

```bash
# NOTE: ripgrep files .tsx under the `ts` type — `-t tsx` errors. Use `-t ts` or `-g '*.tsx'`.
rg -U --multiline-dotall '<pattern spanning lines>' src/ -t ts -l
```

Keep only patterns with **≥ 2 hits** in **≥ 2 different files**.

### 2. Read each hit file

For every surviving pattern, read the relevant sections (not whole files). Extract the repeated block verbatim.

### 3. Classify each finding

| Class | Criteria | Action |
|-------|----------|--------|
| **Extract** | Identical or near-identical structure, no caller-specific logic | Draft a named component |
| **Token** | Same class string, structure varies | Propose a shared constant / design token |
| **Variant** | Semantically same but intentionally different styles | Flag for alignment, no extraction |
| **False positive** | Coincidental string overlap | Dismiss silently |

### 4. Report

For each **Extract** or **Token** finding:

```
## <Pattern name>
Files: <file1:line>, <file2:line>
Class: Extract | Token

Repeated markup:
<block>

Proposed extraction:
<component or constant — minimal>
```

Omit **Variant** / **False positive** unless the count is high enough to note.

### 5. Dark-mode pairing check (skip if project has no dark mode)

Spot-check that surface/text utilities carry a `dark:` counterpart. Report gaps in a **Dark-mode gaps** section, one line each: `file:line — missing dark counterpart for X`. The exact light→dark palette is project-specific; read it from the project seeds file.

## Extraction template

Keep proposals minimal. Do **not** implement — draft and present; the user decides.

```tsx
interface <Name>Props {
  // only what varies between callers
}

export function <Name>({ ... }: <Name>Props) {
  return (
    // extracted markup
  );
}
```
