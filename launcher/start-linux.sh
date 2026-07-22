#!/usr/bin/env bash
# ============================================================
# goclaw-setup-my-pc — Linux Launcher (Production stub)
# ============================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
USB_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "=============================================="
echo " goclaw-setup-my-pc"
echo " Portable AI Agent — Linux Launcher"
echo "=============================================="
echo "USB root: $USB_ROOT"
echo ""

# Future production logic:
# 1. Check for internet
# 2. If offline → start Fabric + load Qwen3.5-9B
# 3. Select correct model wrapper
# 4. Launch goclaw with proper environment

echo "[INFO] This is a production-ready stub."
echo "[INFO] Full implementation will be completed in Phase 3."
echo ""
echo "Next steps when ready:"
echo "  - Detect internet connectivity"
echo "  - Start Fabric if needed"
echo "  - Launch goclaw binary with correct model + wrapper"
