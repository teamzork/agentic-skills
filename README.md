# agentic-skills

A collection of Codex skills used by Team Zork agents. Each skill lives in its own folder and is defined by a `SKILL.md` file with clear instructions, references, and optional helper scripts.

## Skills in this repo

| Skill | Summary | Path |
| --- | --- | --- |
| ai-press-release-placement | Press release strategy for boosting AI/LLM visibility of digital products. | `ai-press-release-placement/` |
| app-design-audit | UI/UX audit against visual design principles, accessibility (WCAG), and consistency. | `app-design-audit/` |
| app-security-audit | Security and production-readiness audit for web apps — rate limiting, auth, secrets, payments, DB, logging, and LLM-specific risks. | `app-security-audit/` |
| artis-automated-tests | Guidance for writing and validating automated tests in the Artis web app. | `artis-automated-tests/` |
| backstory-maker | StoryBrand 8-beat framework for founder/company backstories. | `backstory-maker/` |
| code-ux-review | Combined engineering and UX review checklist and output format. | `code-ux-review/` |
| private-public-export | Create and maintain a clean public release repo from a private source using a strict allowlist and release-only commits. | `private-public-export/` |
| reddit-growth-research-zero-to-100 | Research-driven Reddit growth guidance for first 100 users. | `reddit-growth-research-zero-to-100/` |
| saas-launch-architect | Multi-threaded SaaS launch and GTM strategy — ICP inference from code, launch validation, and go-to-market planning. | `saas-launch-architect/` |
| zork-class-naming | Artis HTML class naming conventions and semantic markup rules. | `zork-class-naming/` |
| zork-mobile-responsiveness | Build responsive, mobile-first web applications. | `zork-mobile-responsiveness/` |
| zork-search-commands | Fast search and file-finding patterns for the Artis repo. | `zork-search-commands/` |
| zork-ui-review | UI review checklist for Artis (Astro/Tailwind). | `zork-ui-review/` |

## Using a skill

1. Open the skill folder and read `SKILL.md`.
2. Follow the workflow and checklists in order.
3. If the skill references extra files (for example `references/` or `templates/`), open those only as needed.
4. If the skill includes scripts, run them from the skill directory.

## Adding a new skill

1. Create a new folder with a kebab-case name (for example `my-new-skill/`).
2. Add a `SKILL.md` with YAML front matter and clear instructions.
3. Keep any supporting docs in `references/` and scripts in `scripts/`.

Minimal `SKILL.md` template:

```md
---
name: my-new-skill
description: One sentence on what the skill does and when to use it.
# Optional fields:
# homepage: https://example.com
# user-invocable: true
# metadata: {"author": "Your Name", "version": "1.0", "category": "category"}
---

# My New Skill

## Overview

What the skill does and why it exists.

## Workflow

1. Step one.
2. Step two.
```

## Conventions

- Folder name matches the `name` field in front matter.
- Keep instructions actionable and scoped to the task.
- Avoid secrets or environment-specific assumptions in skill docs.

## Repo layout

```
agentic-skills/
  README.md
  ai-press-release-placement/
    SKILL.md
  app-design-audit/
    SKILL.md
  app-security-audit/
    SKILL.md
  artis-automated-tests/
    SKILL.md
  backstory-maker/
    SKILL.md
  code-ux-review/
    SKILL.md
  private-public-export/
    SKILL.md
  reddit-growth-research-zero-to-100/
    SKILL.md
  saas-launch-architect/
    SKILL.md
  zork-class-naming/
    SKILL.md
  zork-mobile-responsiveness/
    SKILL.md
  zork-search-commands/
    SKILL.md
  zork-ui-review/
    SKILL.md
```
