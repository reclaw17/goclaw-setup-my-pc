# network-vpn

**Status:** Production-ready  
**Last update:** 2026-07-23

## Purpose
Help configure network, VPN and DNS on PC and OpenWrt.

## When to use
- VPN clients (WireGuard preferred)
- DNS (including AdGuard)
- Basic network troubleshooting
- Tailscale / remote access

## Rules
1. Prefer official methods and packages
2. On OpenWrt use UCI and official docs
3. On PC system-level network/VPN/DNS changes → run `admin-check` first
4. Always use `safety-confirm`
5. Prefer WireGuard when possible
6. Check local docs first

## Admin notes
- Installing VPN packages / changing host firewall / system DNS on PC needs elevation
- OpenWrt changes use router credentials over SSH, not local PC admin
- Still require confirmation in both cases

## Integration
- `admin-check` (for PC-side elevated actions)
- `openwrt`, `pc-setup`, `local-docs`, `safety-confirm`
