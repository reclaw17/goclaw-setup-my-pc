# STATUS

**Date:** 2026-07-23

## Binaries

Pinned and downloadable via `FETCH_BINARIES=1 ./scripts/prepare-usb.sh`:

| Component | Status |
|-----------|--------|
| GoClaw Linux amd64 (`v3.15.0-beta.177`) | Pinned + SHA256 |
| Fabric Linux Vulkan (`b7349`) | Pinned + SHA256 |
| Fabric Windows Vulkan (`b7349`) | Pinned + SHA256 |
| GoClaw Windows | Not published upstream yet |

Local verified copies were also prepared in project vendor cache for packaging tests.

## Model

```text
MODEL_SHA256=03b74727a860a56338e042c4420bb3f04b2fec5734175f4cb9fa853daf52b7e8
```

## Remaining user steps

1. Fill `.env`
2. Run `MVP-TEST-CHECKLIST.md` on real hardware
