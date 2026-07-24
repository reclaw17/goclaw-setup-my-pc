#!/usr/bin/env bash
# One-shot fill of a 32 GB USB project tree (Phase D complete kit).
# Downloads large artifacts onto the stick — does NOT commit them to git.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
chmod +x scripts/*.sh 2>/dev/null || true

log() { echo "==> $*"; }

log "fill-usb: project root = $ROOT"
mkdir -p apps config models skills/vendor docs/mirrors fabric goclaw

# 1) GoClaw Lite AppImage
log "[1/5] GoClaw Lite AppImage"
bash scripts/fetch-goclaw-appimage.sh

# 2) Fabric + model (checksums)
log "[2/5] Offline stack (Fabric + model)"
bash scripts/fetch-offline-stack.sh linux

# 3) Offline docs incl. upstream GoClaw markdown
log "[3/5] Offline docs (incl. GoClaw)"
bash scripts/fetch-offline-docs.sh

# 4) Full Human20-linked shortlist → skills/vendor/
log "[4/5] Full skills shortlist → skills/vendor/"
for slug in chip-docs-local backup-manager auto-model-router repo-task-proof-loop; do
  bash scripts/fetch-human20-skill.sh "$slug" || log "WARN: skip $slug"
done

# 5) .env on stick
log "[5/5] .env template on stick"
if [[ ! -f .env && -f .env.example ]]; then
  cp .env.example .env
  log "Created .env — edit on USB: XAI_API_KEY, PERPLEXITY_API_KEY, …"
else
  log ".env already exists (left unchanged)"
fi

echo
log "Phase D fill complete."
echo "  apps/GoClaw-Lite-x86_64.AppImage"
echo "  fabric/ + models/"
echo "  docs/mirrors/goclaw/"
echo "  skills/vendor/*"
echo "  .env  (fill keys on this stick only)"
echo
echo "Next: edit .env, then: bash start.sh"
