#!/usr/bin/env bash
# Beginner prepare: fetch GoClaw Lite AppImage (+ optional Fabric/model later)
set -euo pipefail

if [[ -z "${IN_TERMINAL:-}" && ( ! -t 0 || ! -t 1 ) ]]; then
  SELF="$(readlink -f "$0" 2>/dev/null || realpath "$0" 2>/dev/null || echo "$0")"
  DIR="$(cd "$(dirname "$SELF")" && pwd)"
  if [[ -f "$DIR/scripts/run-in-terminal.sh" ]]; then
    chmod +x "$DIR/scripts/run-in-terminal.sh" 2>/dev/null || true
    exec bash "$DIR/scripts/run-in-terminal.sh" "$SELF"
  fi
fi

cd "$(cd "$(dirname "$0")" && pwd)"
export IN_TERMINAL=1

echo
echo "======================================"
echo " Prepare USB agent (CachyOS / Arch)"
echo "======================================"
echo
echo "This will download GoClaw Lite AppImage into apps/"
echo "Source: github.com/reclaw17/goclaw-lite-cachyos (v0.2.0-cachyos)"
echo

if [[ -t 0 ]]; then
  read -r -p "Continue? [Y/n]: " ans
  case "${ans,,}" in n|no|н|нет) echo "Cancelled."; exit 0 ;; esac
fi

chmod +x scripts/*.sh 2>/dev/null || true
mkdir -p apps config models skills docs fabric goclaw

echo
echo "==> 1/2 Fetch GoClaw Lite AppImage"
bash scripts/fetch-goclaw-appimage.sh

if [[ ! -f .env && -f .env.example ]]; then
  cp .env.example .env
  echo "==> Created .env — edit and put API keys (XAI_API_KEY / etc.)"
fi

echo
echo "==> 2/2 Optional: Fabric + local model (offline fallback)"
if [[ -t 0 ]]; then
  read -r -p "Download Fabric/model later tooling notes only for now? [y/N]: " m
  case "${m,,}" in
    y|yes|д|да)
      echo "==> See MODELS.md — full Fabric auto-download can be re-enabled later"
      ;;
    *)
      echo "==> Skipped"
      ;;
  esac
fi

echo
echo "======================================"
echo " Ready"
echo "======================================"
echo
echo "Next:"
echo "  1) Edit .env — add XAI_API_KEY=... (or other cloud keys)"
echo "  2) bash старт.sh"
echo
echo "Update AppImage later:"
echo "  bash scripts/update-goclaw.sh"
echo "  or: ./apps/GoClaw-Lite-x86_64.AppImage --update"
echo
if [[ -t 0 ]]; then
  read -r -p "Press Enter to exit..." _
fi
