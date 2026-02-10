---
name: private-public-export
description: "Create and maintain a clean public release repo from a private source using a strict allowlist and release-only commits. Use when a private repo should remain the source of truth but needs a public export with selected files, a one-time overwrite, and ongoing scripted syncs."
---

# Private Public Export

## Overview
Set up a repeatable export workflow where a private repo publishes a curated, clean public repo with release-only history.

## Workflow

### 1) Scope the public surface
- Enumerate files needed to clone, install, and run locally.
- Prefer a strict allowlist over denylist rules.
- Decide whether tests or sample data should be public.

### 2) Install the export kit
- Copy templates from `assets/` into the private repo:
  - `assets/allowlist.txt` -> `export/allowlist.txt`
  - `assets/export.sh` -> `export/export.sh`
  - `assets/README_PUBLIC.md` -> `export/README_PUBLIC.md`
  - `assets/EXPORT.md` -> `export/EXPORT.md`
- Edit the allowlist and public README to match the project.
- Keep the allowlist minimal; add only what the public needs.

### 3) Create the public repo
- Create an empty public repo and clone it locally.
- Run the export script once with a release label.

### 4) Release sync
- For each public release, run the export script with a new version.
- Push only from the public repo; keep private history private.

### 5) Guardrails
- Run `--dry-run` before releases.
- Ensure secrets, runtime artifacts, and local data are excluded.
- Keep the public README clean of private references.

## Allowlist tips
- Include install/run manifests (e.g., `requirements.txt`, `package.json`).
- Include only template configs (e.g., `config/*.example`), never real credentials.
- Prefer `data/.gitkeep` over real data files.

## Release versioning
- Use SemVer: PATCH for fixes/deps, MINOR for features, MAJOR for breaking changes.
- See `references/versioning.md` for examples.

## Resources

### assets/
Templates to copy into the target repo:
- `allowlist.txt`
- `export.sh`
- `README_PUBLIC.md`
- `EXPORT.md`

### references/
Optional deeper guidance:
- `versioning.md`
- `allowlist-guide.md`
