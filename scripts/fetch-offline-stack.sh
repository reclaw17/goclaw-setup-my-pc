#!/usr/bin/env bash
# One-shot: Fabric tools + local model (checksummed)
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
chmod +x scripts/fetch-fabric.sh scripts/fetch-model.sh 2>/dev/null || true
echo "==> Offline stack (Fabric + model)"
bash scripts/fetch-fabric.sh
bash scripts/fetch-model.sh
echo "==> Offline stack ready"
