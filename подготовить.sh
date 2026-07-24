#!/usr/bin/env bash
# Deprecated filename — use: bash prepare.sh
exec "$(cd "$(dirname "$0")" && pwd)/prepare.sh" "$@"
