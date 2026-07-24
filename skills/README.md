# Skills

Agent tool instructions for GoClaw (the “brain”).

See **[INDEX.md](INDEX.md)** for when to load each skill.

## Production set

| Skill | Role |
|-------|------|
| safety-confirm | Confirm before changes |
| admin-check | sudo / Administrator detection |
| local-docs | Prefer offline `docs/` |
| backup | OpenWrt/PC backups |
| openwrt | Router workflow |
| pc-setup | Arch/CachyOS + Windows 11 |
| network-vpn | Network / VPN / DNS |
| coding-quality | Safe scripts |
| model-router | Cloud vs local |
| fabric-offline | Offline engine path |

## Principle

Skills guide the model.  
PC system changes: **admin-check → safety-confirm → execute**.  
OpenWrt: **backup → safety-confirm → execute**.
