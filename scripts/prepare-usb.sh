#!/usr/bin/env bash
# ============================================================
# prepare-usb.sh — prepare a clean USB structure for the agent
# Production quality helper
# ============================================================

set -euo pipefail

ROOT="${1:-.}"

echo "Preparing USB structure in: $ROOT"

mkdir -p \
  "$ROOT/goclaw" \
  "$ROOT/fabric" \
  "$ROOT/models" \
  "$ROOT/docs/openwrt" \
  "$ROOT/docs/cachyos-arch" \
  "$ROOT/docs/windows11" \
  "$ROOT/docs/adguard" \
  "$ROOT/docs/amnezia" \
  "$ROOT/docs/custom" \
  "$ROOT/prompts/wrappers" \
  "$ROOT/skills" \
  "$ROOT/config" \
  "$ROOT/launcher"

touch "$ROOT/docs/custom/.gitkeep"

echo "[OK] Directory structure created."
echo "[INFO] Next: place or download binaries into goclaw/ and fabric/"
echo "[INFO] Model will be auto-downloaded on first offline run into models/"
echo "[INFO] See SOURCES.md and FIRST-RUN.md for details."
