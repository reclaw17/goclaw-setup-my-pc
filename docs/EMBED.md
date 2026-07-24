# How programs live on the USB

**Git is slim. The 32 GB stick is not.**

Binaries and full skill trees are **downloaded onto the project folder / USB**, not stored in git.

## Layout

```text
USB/project/
  apps/GoClaw-Lite-x86_64.AppImage     # ~120 MB
  fabric/fabric-linux                  # offline server
  fabric/win/…                         # optional Windows
  models/qwen3.5-9b-q4_k_m.gguf      # ~5–6 GB OK on 32 GB stick
  skills/*/SKILL.md                    # procedure pack (in git)
  skills/vendor/<slug>/                # FULL upstream skills (on stick)
  docs/ + docs/mirrors/                # notes + optional big mirrors
  bootstrap/                           # AGENTS/SOUL/TOOLS for Lite
  .env                                 # secrets local only
```

## Fetch

```bash
bash prepare.sh                        # AppImage; ask offline stack
FETCH_OFFLINE=1 bash prepare.sh        # AppImage + Fabric + model
bash scripts/fetch-human20-skill.sh list
bash scripts/fetch-human20-skill.sh chip-docs-local
```

Capacity policy: [USB-CAPACITY.md](USB-CAPACITY.md).
