#!/usr/bin/env bash
# Download GoClaw Lite AppImage into apps/
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
mkdir -p apps

REPO="${GOCLAW_LITE_REPO:-reclaw17/goclaw-lite-cachyos}"
TAG="${GOCLAW_LITE_TAG:-v0.2.0-cachyos}"
ASSET="GoClaw-Lite-x86_64.AppImage"
OUT="apps/${ASSET}"
URL="https://github.com/${REPO}/releases/download/${TAG}/${ASSET}"

echo "==> GoClaw Lite AppImage"
echo "==> $URL"

if [[ -f "$OUT" ]]; then
  echo "==> Already present: $OUT"
  ls -lh "$OUT"
  exit 0
fi

tmp="$(mktemp)"
if ! curl -fL --progress-bar -o "$tmp" "$URL"; then
  rm -f "$tmp"
  echo "==> ERROR: download failed"
  exit 1
fi
mv -f "$tmp" "$OUT"
chmod +x "$OUT"
echo "$TAG" > apps/.goclaw-lite-version
echo "==> Saved: $OUT"
ls -lh "$OUT"
