---
name: artis-search-commands
description: Fast search and file-finding workflows for the Artis repo using rg/fd, including preferred commands, disallowed slow tools, and search strategy. Use when deciding how to locate files or content, or when replacing grep/find/ls -R patterns.
---

# Artis Search Commands

Use the fast tools and patterns below whenever searching this repo.

## Never use (slow)

- `grep` or `grep -r` (use `rg` instead)
- `find` (use `rg --files` or `fd`)
- `ls -R` (use `rg --files`)
- `cat file | grep` (use `rg pattern file`)

## Prefer these (fast)

```bash
# ripgrep (rg) - content search
rg "search_term"              # Search in all files
rg -i "case_insensitive"      # Case-insensitive
rg "pattern" -t yaml          # Only YAML files
rg "pattern" -g "*.astro"     # Only Astro files
rg -l "pattern"               # Filenames with matches
rg -n "pattern"               # Show line numbers

# ripgrep (rg) - file listing
rg --files                    # List files (respects .gitignore)
rg --files | rg "pattern"     # Find files by name

# fd - file finding
fd -e astro                   # All .astro files
fd -e yaml                    # All .yaml files
fd -x command {}              # Exec per-file
```

## Search strategy

1. Start broad, then narrow: `rg "partial" | rg "specific"`
2. Filter by type early: `rg -t yaml "title"`
3. Batch patterns: `rg "(pattern1|pattern2|pattern3)"`
4. Limit scope: `rg "pattern" packages/site/`

## Missing commands

Install missing tools on macOS using `brew`.
