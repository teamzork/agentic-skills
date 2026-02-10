# Public Export Workflow

This repo is the source of truth. The public repo is a clean export that only receives release commits.

## One-time setup

1. Create a public repo (empty) and clone it locally.
2. Run the export script from this private repo:

```bash
./export/export.sh --public-repo /path/to/public-repo --release "v0.1.0"
```

3. Push from the public repo:

```bash
cd /path/to/public-repo
git push origin main
```

## Ongoing releases

Make changes in the private repo, then export again:

```bash
./export/export.sh --public-repo /path/to/public-repo --release "v0.1.1"
```

Only release commits are created in the public repo.

## Allowlist

Edit `export/allowlist.txt` to control what gets exported. Anything not listed is excluded.

## Notes

- The public repo is overwritten on each export (except its `.git` directory).
- Use `--dry-run` to preview changes.
