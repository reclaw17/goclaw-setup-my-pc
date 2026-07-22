# network-vpn

**Status:** Production-ready  
**Last update:** 2026-07-22

## Purpose

Help the user configure network, VPN and DNS on both the PC and OpenWrt router.

## When to use

- Setting up VPN clients (WireGuard preferred)
- Configuring DNS (including AdGuard)
- Basic network troubleshooting
- Tailscale / remote access

## Rules

1. Always prefer official methods and packages.
2. On OpenWrt use UCI and official documentation.
3. Always go through `safety-confirm`.
4. Prefer WireGuard over older protocols when possible.
5. First check local documentation.

## Integration

- Works closely with `openwrt` and `pc-setup`
- Uses `local-docs`
- Must respect `safety-confirm` and model wrappers
