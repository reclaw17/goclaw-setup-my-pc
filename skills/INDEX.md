# Skills index (for the agent)

Load and obey these skills when the task matches.  
**Priority:** `safety-confirm` + `admin-check` override speed.

| Skill | Use when |
|-------|----------|
| [safety-confirm](safety-confirm/SKILL.md) | Any system/router change |
| [admin-check](admin-check/SKILL.md) | PC package/service/firewall needs elevation |
| [local-docs](local-docs/SKILL.md) | Always prefer USB `docs/` before web |
| [backup](backup/SKILL.md) | Before OpenWrt/PC risky changes |
| [openwrt](openwrt/SKILL.md) | Router SSH, UCI, opkg, Wi-Fi, WAN, VPN |
| [pc-setup](pc-setup/SKILL.md) | CachyOS/Arch or Windows 11 setup |
| [network-vpn](network-vpn/SKILL.md) | VPN, DNS, Tailscale, routing |
| [coding-quality](coding-quality/SKILL.md) | Generating scripts/commands |
| [model-router](model-router/SKILL.md) | Choosing cloud vs local model |
| [fabric-offline](fabric-offline/SKILL.md) | Offline Fabric path |

## User profile

- Non-developer; explain simply.
- Cloud primary (Grok); local Fabric = fallback when offline (Phase D runtime).
