# openwrt

**Status:** Production-ready  
**Last update:** 2026-07-24

## Purpose
Help set up and recover an **OpenWrt** router from the USB agent: SSH access, backup/restore, packages, Wi‑Fi, WAN, VPN, DNS.

**Primary knowledge:** `docs/openwrt/` on the USB (offline). Prefer local docs, then official OpenWrt docs.

## When to use
- First-time router setup
- Restore after bad config
- Wi‑Fi / internet / DNS / VPN on the router
- Package updates on OpenWrt

## Mandatory safety
1. **Backup before changes** — offer `sysupgrade -b` (or LuCI backup) first.
2. **Show commands, wait for approval** — use `safety-confirm`.
3. No `sysupgrade` firmware flash, factory reset, or WAN-breaking change without explicit yes.
4. Prefer **UCI** + official packages (`opkg`), not random scripts from the web.
5. Router work uses **router root SSH**, not PC admin — still confirm every step.

## Workflow (default order)

### 1. Connect
- Typical LAN IP: `192.168.1.1` (confirm with user)
- `ssh root@192.168.1.1`
- If unreachable: check PC is on LAN, cable/Wi‑Fi, IP conflict

### 2. Backup
```bash
sysupgrade -b /tmp/backup-$(date +%F).tar.gz
# then copy off the router, e.g. scp to USB/PC
```
Restore only with user confirmation: `sysupgrade -r /path/to/backup.tar.gz`

### 3. Packages
```bash
opkg update
opkg list-upgradable
# upgrade only after confirmation
```

### 4. Wi‑Fi
- Inspect: `uci show wireless`
- Change SSID / key / country via UCI
- `uci commit wireless && wifi reload`
- Never print the Wi‑Fi password back in logs if user pastes it — treat as secret

### 5. WAN / internet
- `uci show network`, `ifstatus wan`, `ping -c 2 1.1.1.1`
- Prefer minimal UCI edits; commit + `reload_config` or interface restart as documented

### 6. DNS
- Prefer clear DNS (e.g. provider, or user-chosen AdGuard/DoH path)
- Coordinate with skill `network-vpn` and docs under `docs/adguard/`

### 7. VPN on router
- **Prefer WireGuard** via official packages + UCI
- Install only after backup + confirmation
- Document peer/endpoint needs from the user; do not invent private keys

### 8. Access restrictions (high level)
If the user asks about ISP/region blocks:
- Stay **high-level**: legal VPN/DNS options, split routing, official clients
- Do **not** provide evasion playbooks for crime or fraud
- Prefer documented WireGuard/OpenVPN/Amnezia-style setups the user already licensed

## Integration
- `safety-confirm`, `backup`, `local-docs`, `network-vpn`
- PC-side network changes → also `admin-check` + `pc-setup`

## Quality bar
Explain each step in plain language for a non-developer. One change at a time.
