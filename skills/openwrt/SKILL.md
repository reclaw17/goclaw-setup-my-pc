# openwrt

**Status:** Production-ready  
**Last update:** 2026-07-24

## Purpose

Safe workflow for OpenWrt routers: connect → backup → change → verify.

**Docs first:** `docs/openwrt/` on USB, then official OpenWrt wiki.

## Mandatory safety

1. **Backup first** — use skill `backup` (`sysupgrade -b`) before config changes.
2. **safety-confirm** — show exact commands; wait for clear yes.
3. No `sysupgrade` firmware flash / factory reset without explicit permission.
4. Prefer `uci`, `opkg`, `wifi`, `ifstatus` over ad-hoc file edits when possible.

Local PC admin is **not** required for router SSH (router root is separate). Still confirm every change.

## Standard session checklist

1. Reach router: `ping`, then `ssh root@192.168.1.1` (IP may differ).
2. Identify version: `cat /etc/openwrt_release`
3. **Backup** config to USB `backups/openwrt/`
4. `opkg update` before installs
5. Make **one** logical change set (Wi-Fi **or** WAN **or** VPN…)
6. `uci commit …` + reload service
7. Verify (`ifstatus wan`, `wifi status`, client connect test)
8. If broken — restore backup

## Connection

```bash
ssh root@192.168.1.1
```

## Packages

```bash
opkg update
opkg list-upgradable
# install only named packages after confirmation
opkg install <pkg>
```

## Wi-Fi

```bash
uci show wireless
# edit via uci set …
uci commit wireless
wifi reload
```

## WAN / internet

```bash
uci show network
ifstatus wan
```

## VPN

Prefer **WireGuard** with official packages (`wireguard-tools`, `kmod-wireguard`, LuCI proto if used).  
Configure interface + firewall zone carefully; confirm before commit.

## DNS

- Can point LAN clients to AdGuard Home / upstream DNS via DHCP options or firewall redirects — only with user confirmation.
- Local notes: `docs/adguard/`, `docs/amnezia/` when present.

## Integration

- `backup`, `safety-confirm`, `network-vpn`, `local-docs`
