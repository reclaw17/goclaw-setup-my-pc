# AdGuard — offline notes

## Products (one goal at a time)
- **AdGuard Home** — DNS filtering for the LAN (PC/NAS/router).
- **AdGuard DNS / apps** — per-device filtering.
- **AdGuard VPN** — not the same as Home; do not mix instructions blindly.

## Safety
- Changing DNS can break internet — write down how to revert to automatic/DHCP DNS.
- Strong admin password on AdGuard Home.
- Official downloads only.

## AdGuard Home (short flow)
1. Install on an always-on host in the LAN.
2. Open web UI → set password.
3. Point **one test device** DNS to that host.
4. If OK, set router DHCP DNS for the whole LAN.
5. Export config/backup if UI supports it.

## With VPN
State the order: VPN DNS vs AdGuard vs ISP. Avoid DNS loops.  
Skill: `skills/amnezia-adguard/SKILL.md`.
