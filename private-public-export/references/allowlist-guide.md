# Allowlist Guide

## Principles
- Start from zero and add only what is required for a clean public clone.
- Prefer template configs and sample data over real data.
- Keep runtime outputs excluded (logs, caches, credentials, data dumps).

## Pattern tips
- Include directories with `/**` to ensure nested files are captured.
- Include config templates with `.example`, `_template`, or `.dist` suffixes.
- Keep build artifacts out unless the public repo is meant to distribute binaries.

## Sanity checks
- Run the export in `--dry-run` mode.
- Review the temp export contents for secrets or data files.
- Confirm public README does not mention private resources.
