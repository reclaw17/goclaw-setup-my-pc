# Human20 skills vs this repo

## Archive

`human20mcp-20260722.zip`:

- **235 cards** — summary, tags, GitHub/zip links  
- **Not** full skill implementations inside the zip  
- `h20-curs/` — workshop/Cursor ops knowledge  

## Two layers in goclaw-setup-my-pc

| Layer | Path | Meaning |
|-------|------|---------|
| **Procedure pack (v1)** | `skills/*/SKILL.md` | Our short playbooks for PC/router USB agent |
| **Full upstream skills** | `skills/vendor/<slug>/` after fetch | Real GitHub trees from Human20 cards |

```bash
bash scripts/fetch-human20-skill.sh list
bash scripts/fetch-human20-skill.sh chip-docs-local
```

## Shortlist

| Need | Slug | Fetch |
|------|------|--------|
| Offline doc mirrors | chip-docs-local | `fetch-human20-skill.sh chip-docs-local` |
| Model routing ideas | auto-model-router | yes |
| Backups | backup-manager | yes |
| Proof loop | repo-task-proof-loop | yes |
| Safety / coding workshop | clawguard, workshop-* | card in archive; add URL when needed |

Procedure pack stays the default for the agent. Vendor trees are optional power-ups (Phase E).
