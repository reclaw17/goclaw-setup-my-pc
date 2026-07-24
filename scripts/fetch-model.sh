#!/usr/bin/env bash
# Download pinned local GGUF model into models/ (checksum verified)
# Default: Qwen3.5-9B Q4_K_M — fits ~8GB VRAM class hardware
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
mkdir -p models

MODEL_URL="${MODEL_URL:-https://huggingface.co/unsloth/Qwen3.5-9B-GGUF/resolve/main/Qwen3.5-9B-Q4_K_M.gguf}"
MODEL_FILE="${MODEL_FILE:-models/qwen3.5-9b-q4_k_m.gguf}"
MODEL_SHA256="${MODEL_SHA256:-03b74727a860a56338e042c4420bb3f04b2fec5734175f4cb9fa853daf52b7e8}"

if [[ -f "$MODEL_FILE" ]]; then
  echo "==> Model already present: $MODEL_FILE"
  ls -lh "$MODEL_FILE"
  exit 0
fi

echo "==> Downloading local model (several GB — one-time)"
echo "==> $MODEL_URL"
tmp="$(mktemp)"
curl -fL --progress-bar --retry 3 --retry-delay 5 -o "$tmp" "$MODEL_URL"

if command -v sha256sum >/dev/null 2>&1; then
  actual="$(sha256sum "$tmp" | awk '{print $1}')"
elif command -v shasum >/dev/null 2>&1; then
  actual="$(shasum -a 256 "$tmp" | awk '{print $1}')"
else
  echo "==> ERROR: need sha256sum or shasum"; rm -f "$tmp"; exit 1
fi

if [[ "$actual" != "$MODEL_SHA256" ]]; then
  echo "==> ERROR: SHA256 mismatch"
  echo "    expected $MODEL_SHA256"
  echo "    got      $actual"
  rm -f "$tmp"
  exit 1
fi
echo "==> SHA256 OK"
mv -f "$tmp" "$MODEL_FILE"
echo "$MODEL_SHA256  $MODEL_FILE" > models/SHA256SUMS
ls -lh "$MODEL_FILE"
echo "==> Saved $MODEL_FILE"
