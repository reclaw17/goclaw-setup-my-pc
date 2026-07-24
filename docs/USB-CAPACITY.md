# USB capacity (32 GB)

User kit target: **~32 GB** flash drive. **Do not under-fill** the stick out of caution.

## Policy

| Store | On USB (32 GB) | In git |
|-------|----------------|--------|
| GoClaw AppImage (~120 MB) | **Yes** | No |
| Fabric binaries | **Yes** | No |
| Local GGUF model (~5–6 GB) | **Yes** | No |
| Full Human20 skill trees (`skills/vendor/`) | **Yes** | No (clone on stick) |
| Offline doc mirrors (`docs/mirrors/`) | **Yes** | No if huge |
| Procedure pack `skills/*/SKILL.md` | Yes | **Yes** |
| Scripts, bootstrap, thin docs | Yes | **Yes** |
| Real `.env` secrets | Yes (private) | **Never** |

Rough budget on a 32 GB stick (exFAT/ext4):

```text
AppImage + Fabric     ~0.2 GB
Qwen3.5 9B Q4         ~5–6 GB
Skill vendor clones   ~0.1–1 GB
Doc mirrors           optional several GB
Free space            plenty for backups / OpenWrt dumps
```

## Default recommendation (Linux prepare)

```bash
FETCH_OFFLINE=1 bash prepare.sh
bash scripts/fetch-human20-skill.sh chip-docs-local
bash scripts/fetch-human20-skill.sh backup-manager
bash scripts/fetch-human20-skill.sh auto-model-router
bash scripts/fetch-human20-skill.sh repo-task-proof-loop
```

Full skills are **first-class on the stick**; procedure pack remains the always-present baseline in git.
