# OpenWrt — offline notes (USB agent)

Practical checklist for the agent and user. Prefer this file before the internet.

## Safety
1. Backup config before changes.
2. One change at a time.
3. Confirm with the user before `sysupgrade`, factory reset, or WAN edits.

## SSH
- Default LAN: often `192.168.1.1`, user `root`
- `ssh root@192.168.1.1`

## Backup / restore
```bash
sysupgrade -b /tmp/backup-$(date +%F).tar.gz
scp root@192.168.1.1:/tmp/backup-*.tar.gz .
# restore (confirm first):
# sysupgrade -r /tmp/backup-YYYY-MM-DD.tar.gz
```
Official idea: OpenWrt backup is **configuration**, not a full disk image.

## Packages
```bash
opkg update
opkg list-upgradable
# opkg install <pkg>   # after confirmation
```

## Wi-Fi (UCI)
```bash
uci show wireless
# edit SSID/key/country via uci set ...
uci commit wireless
wifi reload
```

## WAN / connectivity
```bash
uci show network
ifstatus wan
ping -c 2 1.1.1.1
```

## VPN
Prefer **WireGuard** packages + UCI. Install only after backup. Collect keys/endpoints from the user — never invent them.

## DNS
Coordinate with AdGuard notes in `docs/adguard/`. Changing LAN DNS affects all clients — test one device first.

## References (when online)
- https://openwrt.org/docs/guide-user/troubleshooting/backup_restore
- https://openwrt.org/docs/guide-user/network/wifi/basic
