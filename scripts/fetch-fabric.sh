#!/usr/bin/env bash
# Download pinned Fabric/llama.cpp Vulkan builds into fabric/
# Linux: fabric/fabric-linux  |  Windows zip extracted under fabric/win/
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
mkdir -p fabric

OS="${1:-linux}"   # linux | windows
FABRIC_TAG="${FABRIC_TAG:-b7349}"

FABRIC_LINUX_URL="https://github.com/tetherto/qvac-fabric-llm.cpp/releases/download/${FABRIC_TAG}/llama-${FABRIC_TAG}-bin-ubuntu-vulkan-x64.tar.gz"
FABRIC_LINUX_SHA="fb42fb4f4b3ae623ba606f7bbbaebe620be4966e04a95a30b0fb6f9b670ce12a"
FABRIC_WIN_URL="https://github.com/tetherto/qvac-fabric-llm.cpp/releases/download/${FABRIC_TAG}/llama-${FABRIC_TAG}-bin-win-vulkan-x64.zip"
FABRIC_WIN_SHA="eb52db3cee6937edbf727a1ecf9a2eb9204e0a13c14c7e4ba78c83815d81d0bc"

verify_sha256() {
  local file="$1" expected="$2" actual
  if command -v sha256sum >/dev/null 2>&1; then
    actual="$(sha256sum "$file" | awk '{print $1}')"
  else
    actual="$(shasum -a 256 "$file" | awk '{print $1}')"
  fi
  if [[ "$actual" != "$expected" ]]; then
    echo "==> ERROR: SHA256 mismatch for $file"
    echo "    expected $expected"
    echo "    got      $actual"
    exit 1
  fi
  echo "==> SHA256 OK"
}

download() {
  local url="$1" out="$2"
  echo "==> Download: $url"
  curl -fL --progress-bar --retry 3 --retry-delay 2 -o "$out" "$url"
}

if [[ "$OS" == "windows" ]]; then
  if [[ -x fabric/win/llama-server.exe ]] || [[ -f fabric/win/llama-server.exe ]]; then
    echo "==> Windows Fabric already present under fabric/win/"
    exit 0
  fi
  tmp="$(mktemp)"
  download "$FABRIC_WIN_URL" "$tmp"
  verify_sha256 "$tmp" "$FABRIC_WIN_SHA"
  rm -rf fabric/win
  mkdir -p fabric/win
  if command -v unzip >/dev/null 2>&1; then
    unzip -q "$tmp" -d fabric/win
  else
    echo "==> ERROR: need unzip"; rm -f "$tmp"; exit 1
  fi
  rm -f "$tmp"
  echo "==> Extracted to fabric/win/"
  find fabric/win -maxdepth 3 -type f -name 'llama*' | head
  exit 0
fi

# linux default
if [[ -x fabric/fabric-linux ]]; then
  echo "==> fabric/fabric-linux already present"
  ls -lh fabric/fabric-linux
  exit 0
fi

tmp="$(mktemp)"
tdir="$(mktemp -d)"
download "$FABRIC_LINUX_URL" "$tmp"
verify_sha256 "$tmp" "$FABRIC_LINUX_SHA"
tar -xzf "$tmp" -C "$tdir"
# find a sensible binary
bin="$(find "$tdir" -type f -name 'llama-server' | head -n 1 || true)"
if [[ -z "$bin" ]]; then
  bin="$(find "$tdir" -type f -executable | head -n 1 || true)"
fi
if [[ -z "$bin" || ! -f "$bin" ]]; then
  echo "==> ERROR: no binary in archive"; rm -rf "$tmp" "$tdir"; exit 1
fi
cp -f "$bin" fabric/fabric-linux
chmod +x fabric/fabric-linux
rm -rf "$tmp" "$tdir"
echo "==> Saved fabric/fabric-linux"
ls -lh fabric/fabric-linux
echo "$FABRIC_TAG" > fabric/.fabric-version
