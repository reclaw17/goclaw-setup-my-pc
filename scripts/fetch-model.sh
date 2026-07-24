#!/usr/bin/env bash
# Download local GGUF model with SHA256 check (offline fallback)
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
mkdir -p models

MODEL_URL="${MODEL_URL:-https://huggingface.co/unsloth/Qwen3.5-9B-GGUF/resolve/main/Qwen3.5-9B-Q4_K_M.gguf}"
OUT="${MODEL_OUT:-models/qwen3.5-9b-q4_k_m.gguf}"
EXPECT_SHA="${MODEL_SHA256:-03b74727a860a56338e042c4420bb3f04b2fec5734175f4cb9fa853daf52b7e8}"

log() { echo "==> $*"; }
err() { echo "==> ERROR: $*" >&2; exit 1; }

sha256_of() {
  if command -v sha256sum >/dev/null 2>&1; then sha256sum "$1" | awk '{print $1}'
  elif command -v shasum >/dev/null 2>&1; then shasum -a 256 "$1" | awk '{print $1}'
  else err "need sha256sum or shasum"; fi
}

if [[ -f "$OUT" ]]; then
  got="$(sha256_of "$OUT")"
  if [[ "$got" == "$EXPECT_SHA" ]]; then
    log "Model already present and checksum OK: $OUT"
    ls -lh "$OUT"
    exit 0
  fi
  log "Checksum mismatch — re-downloading"
  rm -f "$OUT"
fi

log "Downloading model (~several GB). One-time."
log "URL: $MODEL_URL"
tmp="$(mktemp)"
curl -fL --progress-bar --retry 3 --retry-delay 2 -o "$tmp" "$MODEL_URL" || { rm -f "$tmp"; err "download failed"; }
got="$(sha256_of "$tmp")"
if [[ "$got" != "$EXPECT_SHA" ]]; then
  rm -f "$tmp"
  err "SHA256 mismatch (got $got, expected $EXPECT_SHA)"
fi
mv -f "$tmp" "$OUT"
log "Saved: $OUT"
ls -lh "$OUT"
