#!/usr/bin/env bash
# Optionally download a *full* Human20-linked skill from GitHub (not the thin procedure pack).
# Usage:
#   bash scripts/fetch-human20-skill.sh chip-docs-local
#   bash scripts/fetch-human20-skill.sh list
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DEST="$ROOT/skills/vendor"
mkdir -p "$DEST"

# slug → git clone URL (shallow). Extend as needed.
declare -A REPOS=(
  [chip-docs-local]="https://github.com/evgyur/chip-docs-local.git"
  [auto-model-router]="https://github.com/JoyyyceD/auto-model-router.git"
  [backup-manager]="https://github.com/ppopen/backup-manager.git"
  [repo-task-proof-loop]="https://github.com/DenisSergeevitch/repo-task-proof-loop.git"
)

list() {
  echo "Known slugs (full upstream, not procedure pack):"
  for k in "${!REPOS[@]}"; do echo "  $k  →  ${REPOS[$k]}"; done
  echo
  echo "Install example: bash scripts/fetch-human20-skill.sh chip-docs-local"
  echo "Output: skills/vendor/<slug>/  (gitignored recommended if huge)"
}

if [[ "${1:-}" == "list" || "${1:-}" == "--help" || -z "${1:-}" ]]; then
  list
  exit 0
fi

slug="$1"
url="${REPOS[$slug]:-}"
if [[ -z "$url" ]]; then
  echo "==> Unknown slug: $slug"
  list
  exit 1
fi

target="$DEST/$slug"
if [[ -d "$target/.git" ]]; then
  echo "==> Updating $target"
  git -C "$target" pull --ff-only || true
else
  echo "==> Cloning $url"
  git clone --depth 1 "$url" "$target"
fi
echo "==> Done: $target"
echo "==> This is upstream skill source, separate from skills/*/SKILL.md procedure pack."
