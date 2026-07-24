# AdGuard — offline notes

## Products (pick one goal at a time)
- **AdGuard Home** — LAN-wide DNS filtering (runs on PC/NAS/router).
- **AdGuard DNS / apps** — device-level filtering or DNS service.
- **AdGuard VPN** — separate from Home; do not confuse with DNS-only setup.

## Safety
- Changing system DNS can break internet — keep a rollback (e.g. DHCP/automatic DNS).
- Set a strong AdGuard Home admin password.
- Install only from official AdGuard sources.

## Typical Home flow
1. Install on a always-on machine in the LAN.
2. Open web UI, set password.
3. Point **one test client** DNS to that machine.
4. If OK, set router DHCP DNS for the LAN.
5. Export/backup config if the UI provides it.

## With VPN
Order matters: document whether DNS is via VPN provider, AdGuard, or split. Avoid loops.
