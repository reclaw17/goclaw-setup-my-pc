#!/usr/bin/env bash
# Fetch Fabric + model into project folders (not git — local/USB only)
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
chmod +x scripts/fetch-fabric.sh scripts/fetch-model.sh 2>/dev/null || true

OS="${1:-linux}"
echo "==> Offline stack for: $OS"
bash scripts/fetch-fabric.sh "$OS"
bash scripts/fetch-model.sh
echo "==> Offline stack ready"
