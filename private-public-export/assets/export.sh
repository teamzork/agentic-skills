#!/usr/bin/env bash
set -euo pipefail
shopt -s extglob

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_FILE="$ROOT_DIR/export/allowlist.txt"
PUBLIC_README="$ROOT_DIR/export/README_PUBLIC.md"

PUBLIC_REPO=""
RELEASE_TAG=""
DRY_RUN=0
KEEP_TMP=0

usage() {
  cat <<USAGE
Usage: export.sh --public-repo /path/to/public-repo [--release "vX.Y.Z"] [--dry-run] [--keep-tmp]

Options:
  --public-repo   Path to the public repo working tree (required)
  --release       Release tag or label used for the commit message (optional)
  --dry-run       Show what would change without copying or committing
  --keep-tmp      Keep the temporary export directory for inspection
  -h, --help      Show this help
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --public-repo)
      PUBLIC_REPO="$2"
      shift 2
      ;;
    --release)
      RELEASE_TAG="$2"
      shift 2
      ;;
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    --keep-tmp)
      KEEP_TMP=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage
      exit 1
      ;;
  esac
done

if [[ -z "$PUBLIC_REPO" ]]; then
  echo "Error: --public-repo is required." >&2
  usage
  exit 1
fi

if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "Error: allowlist file not found at $CONFIG_FILE" >&2
  exit 1
fi

PUBLIC_REPO="$(cd "$PUBLIC_REPO" && pwd)"

if [[ "$PUBLIC_REPO" == "$ROOT_DIR" ]]; then
  echo "Error: public repo path cannot be the same as the private repo." >&2
  exit 1
fi

if [[ ! -d "$PUBLIC_REPO/.git" ]]; then
  echo "Error: $PUBLIC_REPO does not look like a git repo (missing .git)." >&2
  exit 1
fi

TMP_DIR="$(mktemp -d)"
FILTER_FILE="$(mktemp)"

cleanup() {
  if [[ $KEEP_TMP -eq 0 ]]; then
    rm -rf "$TMP_DIR"
  else
    echo "Keeping temp dir: $TMP_DIR"
  fi
  rm -f "$FILTER_FILE"
}
trap cleanup EXIT

# Build rsync filter from allowlist
{
  echo "+ */"
  while IFS= read -r raw_line; do
    line="$raw_line"
    line="${line%$'\r'}"
    line="${line##+([[:space:]])}"
    line="${line%%+([[:space:]])}"

    if [[ -z "$line" || "$line" == \#* ]]; then
      continue
    fi

    if [[ "$line" != /* ]]; then
      line="/$line"
    fi

    echo "+ $line"
  done < "$CONFIG_FILE"
  echo "- *"
} > "$FILTER_FILE"

RSYNC_DRY=""
if [[ $DRY_RUN -eq 1 ]]; then
  RSYNC_DRY="--dry-run"
fi

# Export allowlisted files into temp dir
rsync -a --delete --prune-empty-dirs $RSYNC_DRY \
  --filter="merge $FILTER_FILE" \
  "$ROOT_DIR/" "$TMP_DIR/"

# Use public README if provided
if [[ -f "$PUBLIC_README" ]]; then
  if [[ $DRY_RUN -eq 0 ]]; then
    cp "$PUBLIC_README" "$TMP_DIR/README.md"
  else
    echo "Dry run: would replace README.md with export/README_PUBLIC.md"
  fi
fi

# Sync temp export into public repo (excluding .git)
rsync -a --delete $RSYNC_DRY --exclude ".git" "$TMP_DIR/" "$PUBLIC_REPO/"

if [[ -n "$RELEASE_TAG" ]]; then
  if [[ $DRY_RUN -eq 1 ]]; then
    echo "Dry run: would commit release $RELEASE_TAG in $PUBLIC_REPO"
  else
    pushd "$PUBLIC_REPO" > /dev/null
    if [[ -n "$(git status --porcelain)" ]]; then
      git add -A
      git commit -m "Release $RELEASE_TAG"
    else
      echo "No changes to commit."
    fi
    popd > /dev/null
  fi
fi
