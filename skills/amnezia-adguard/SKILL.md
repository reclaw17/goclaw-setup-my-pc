# amnezia-adguard

**Status:** Production-ready (docs-driven)  
**Last update:** 2026-07-24

## Purpose
Help install and configure **AdGuard** (Home / DNS / VPN where applicable) and **Amnezia** clients using official flows and local USB docs.

**Primary knowledge:** `docs/adguard/`, `docs/amnezia/` on the USB.

## When to use
- User wants DNS filtering (AdGuard Home) on PC or LAN
- User wants Amnezia / AdGuard VPN client setup
- Align DNS + VPN so they do not fight each other

## Mandatory safety
1. `admin-check` before installing system services or changing host DNS.
2. `safety-confirm` for every install command and DNS switch.
3. Do not disable the user’s only working DNS/VPN without a rollback plan.
4. No pirated keys, cracked clients, or bypass instructions for illegal access.
5. Prefer official download sources and package names.

## AdGuard Home (typical LAN)
1. Confirm target machine (PC vs router vs NAS).
2. Install via official method for that OS.
3. Set admin UI password; tell user to store it offline.
4. Point LAN devices or router DHCP DNS to AdGuard only after testing from one client.
5. Backup AdGuard config if the product supports export.

## AdGuard DNS / VPN apps
- Follow vendor UI; map settings to user goals (block ads vs full VPN).
- If both VPN and custom DNS are used, state order of operations clearly.

## Amnezia
- Use official Amnezia client docs + `docs/amnezia/`.
- Import user-provided configs; never invent server endpoints.
- After connect: test DNS leak / IP only with user consent and simple checks.

## Integration
- `pc-setup`, `network-vpn`, `openwrt` (if DNS on router), `local-docs`, `safety-confirm`, `admin-check`

## Quality bar
One product at a time. Write a mini rollback (“to undo DNS, set …”).
