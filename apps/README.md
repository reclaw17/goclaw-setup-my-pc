# apps/

Put **GoClaw Lite** here (not committed to git):

```text
apps/GoClaw-Lite-x86_64.AppImage
```

## Download

From repo root:

```bash
bash prepare.sh
# or
bash scripts/fetch-goclaw-appimage.sh
```

Default release: **[v0.2.0-cachyos](https://github.com/reclaw17/goclaw-lite-cachyos/releases/tag/v0.2.0-cachyos)**  
Override: `GOCLAW_LITE_TAG=v0.2.0-cachyos bash scripts/fetch-goclaw-appimage.sh`

## Update

```bash
bash update.sh
# or on a newer AppImage:
./apps/GoClaw-Lite-x86_64.AppImage --update
```
