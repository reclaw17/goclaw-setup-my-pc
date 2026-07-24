# Skills index

| Skill | Path | Role |
|-------|------|------|
| local-docs | `skills/local-docs/` | Prefer USB offline docs |
| safety-confirm | `skills/safety-confirm/` | Confirm before changes |
| admin-check | `skills/admin-check/` | sudo / Admin detection |
| openwrt | `skills/openwrt/` | Router OpenWrt workflow |
| pc-setup | `skills/pc-setup/` | Arch/CachyOS + Windows 11 PC |
| network-vpn | `skills/network-vpn/` | Network, VPN, DNS |
| amnezia-adguard | `skills/amnezia-adguard/` | AdGuard + Amnezia |
| fabric-offline | `skills/fabric-offline/` | Local LLM fallback |
| model-router | `skills/model-router/` | Cloud vs local routing |
| backup | `skills/backup/` | Backup discipline |
| coding-quality | `skills/coding-quality/` | Careful commands/code |

## Loading

GoClaw / agent should treat each `SKILL.md` as a tool description.  
System-changing actions: **admin-check → safety-confirm → act**.

## Priority for this product

1. safety-confirm + admin-check  
2. local-docs  
3. pc-setup / openwrt  
4. network-vpn / amnezia-adguard  
5. fabric-offline when offline  
