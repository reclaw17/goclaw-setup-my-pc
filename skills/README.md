# Skills — procedure pack (v1)

## What this folder is

**Procedure pack** for the USB PC + router agent:

- Short `SKILL.md` playbooks the model should follow  
- Product-specific: OpenWrt, CachyOS/Arch, Win11 notes, VPN/DNS, safety  

## What this folder is NOT

| Not | Reality |
|-----|---------|
| Full **Human20** skills | Archive cards point to **GitHub/zip**; we did not vendor those trees |
| Native **GoClaw loader** skills (yet) | Upstream expects YAML frontmatter + managed skill dirs (docs/14–15). Wiring = plan Phase E |
| Guaranteed drop-in for OpenClaw/Codex | Written for *this* USB agent + GoClaw Lite context |

Human20 catalog mapping: [../docs/HUMAN20-SKILLS.md](../docs/HUMAN20-SKILLS.md)  
Optional download of real upstream zips: `bash scripts/fetch-human20-skill.sh --help`

## Inventory

| Skill | Role |
|-------|------|
| local-docs | Offline `docs/` first |
| safety-confirm | Confirm before changes |
| admin-check | sudo / Admin gate |
| openwrt | Router workflow |
| pc-setup | Arch/CachyOS + Windows 11 |
| network-vpn | Network / VPN / DNS |
| amnezia-adguard | AdGuard + Amnezia |
| fabric-offline | Local LLM path |
| model-router | Cloud vs local |
| backup | Backup discipline |
| coding-quality | Careful commands |

See [INDEX.md](INDEX.md).

## Principle

**admin-check → safety-confirm → act.**  
The LLM is the brain; these files are procedures.
