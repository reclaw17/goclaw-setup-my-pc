#!/usr/bin/env bash
# Fetch recommended full Human20-linked skills onto the USB stick (32 GB OK).
# Does not replace skills/*/SKILL.md procedure pack.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
chmod +x scripts/fetch-human20-skill.sh 2>/dev/null || true

SHORTLIST=(
  chip-docs-local
  backup-manager
  auto-model-router
  repo-task-proof-loop
)

echo "==> Skills shortlist → skills/vendor/"
for slug in "${SHORTLIST[@]}"; do
  echo
  bash scripts/fetch-human20-skill.sh "$slug" || echo "==> WARN: skip $slug"
done
echo
echo "==> Shortlist done. Procedure pack remains in skills/*/SKILL.md"
