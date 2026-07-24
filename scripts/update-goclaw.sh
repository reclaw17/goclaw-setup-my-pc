#!/usr/bin/env bash
# Update AppImage from goclaw-lite-cachyos Releases
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
mkdir -p apps

APP="apps/GoClaw-Lite-x86_64.AppImage"
REPO="${GOCLAW_LITE_REPO:-reclaw17/goclaw-lite-cachyos}"
ASSET="GoClaw-Lite-x86_64.AppImage"
API="https://api.github.com/repos/${REPO}/releases/latest"

echo "==> Checking $REPO releases..."
json="$(mktemp)"
curl -fsSL -H "Accept: application/vnd.github+json" -H "User-Agent: goclaw-setup-my-pc" "$API" -o "$json"

TAG="$(python3 -c 'import json,sys; print(json.load(open(sys.argv[1])).get("tag_name") or "")' "$json")"
URL="$(python3 -c '
import json,sys
r=json.load(open(sys.argv[1])); name=sys.argv[2]
for a in r.get("assets") or []:
  if a.get("name")==name:
    print(a.get("browser_download_url") or ""); break
' "$json" "$ASSET")"
rm -f "$json"

if [[ -z "$TAG" || -z "$URL" ]]; then
  echo "==> ERROR: cannot resolve latest AppImage"
  exit 1
fi

CUR="unknown"
[[ -f apps/.goclaw-lite-version ]] && CUR="$(tr -d '\r\n' < apps/.goclaw-lite-version)"
echo "==> Local:  $CUR"
echo "==> Latest: $TAG"

if [[ "$CUR" == "$TAG" && -f "$APP" ]]; then
  echo "==> Already up to date"
  exit 0
fi

echo "==> Downloading..."
tmp="$(mktemp)"
curl -fL --progress-bar -o "$tmp" "$URL"
chmod +x "$tmp"
if [[ -f "$APP" ]]; then
  cp -f "$APP" "${APP}.bak-$(date +%Y%m%d-%H%M%S)"
fi
mv -f "$tmp" "$APP"
echo "$TAG" > apps/.goclaw-lite-version
echo "==> Updated to $TAG"
ls -lh "$APP"
