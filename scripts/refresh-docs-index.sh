#!/usr/bin/env bash
# Build docs/FILELIST.md for local-docs navigation
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUT="$ROOT/docs/FILELIST.md"
{
  echo "# docs FILELIST"
  echo
  echo "Generated: $(date -u +%Y-%m-%dT%H:%MZ)"
  echo
  (cd "$ROOT/docs" && find . -type f -name '*.md' | sed 's|^\./||' | sort)
} > "$OUT"
echo "==> Wrote $OUT"
