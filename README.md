# agentic-skills

A collection of Codex skills used by Team Zork agents. Each skill lives in its own folder and is defined by a `SKILL.md` file with clear instructions, references, and optional helper scripts.

## Skills in this repo

| Skill | Summary | Path |
| --- | --- | --- |
| app-design-audit | UI/UX audit against visual design principles, accessibility (WCAG), and consistency. | `app-design-audit/` |
| artis-automated-tests | Guidance for writing and validating automated tests in the Artis web app. | `artis-automated-tests/` |
| artis-class-naming | Artis HTML class naming conventions and semantic markup rules. | `artis-class-naming/` |
| artis-search-commands | Fast search and file-finding patterns for the Artis repo. | `artis-search-commands/` |
| artis-ui-review | UI review checklist for Artis (Astro/Tailwind). | `artis-ui-review/` |
| backstory-maker | StoryBrand 8-beat framework for founder/company backstories. | `backstory-maker/` |
| code-ux-review | Combined engineering and UX review checklist and output format. | `code-ux-review/` |
| reddit-growth-research-zero-to-100 | Research-driven Reddit growth guidance for first 100 users. | `reddit-growth-research-zero-to-100/` |

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
  app-design-audit/
    SKILL.md
  artis-automated-tests/
    SKILL.md
  artis-class-naming/
    SKILL.md
  artis-search-commands/
    SKILL.md
  artis-ui-review/
    SKILL.md
  backstory-maker/
    SKILL.md
  code-ux-review/
    SKILL.md
  reddit-growth-research-zero-to-100/
    SKILL.md
```
