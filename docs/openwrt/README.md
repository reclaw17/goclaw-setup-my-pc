# OpenWrt — offline notes (USB agent)

Prefer this folder before the internet. Official docs: https://openwrt.org/

## Safety
1. Backup before changes.
2. Show commands; wait for user OK.
3. No firmware `sysupgrade` image flash without explicit confirmation.

## Connect
Default LAN IP is often `192.168.1.1`:
```bash
ssh root@192.168.1.1
```

## Backup / restore
```bash
# on router
sysupgrade -b /tmp/backup-$(date +%F).tar.gz
# copy off router with scp from PC, keep on USB
```
Restore only when user confirms:
```bash
sysupgrade -r /tmp/backup-YYYY-MM-DD.tar.gz
```

## Packages
```bash
opkg update
opkg list-upgradable
# opkg install <pkg>   # after confirmation
```

## Wi-Fi (UCI)
```bash
uci show wireless
# edit SSID/key/country via uci set …
uci commit wireless
wifi reload
```
Treat Wi-Fi passwords as secrets.

## WAN / internet
```bash
uci show network
ifstatus wan
ping -c 2 1.1.1.1
```

## DNS
Change carefully; keep a rollback to ISP DHCP DNS.  
LAN-wide filtering → see `docs/adguard/` (AdGuard Home).

## VPN on router
Prefer **WireGuard** packages + UCI. Backup first.  
User must supply keys/endpoint — never invent them.

## Agent skill
Procedures: `skills/openwrt/SKILL.md`.
