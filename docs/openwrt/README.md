# OpenWrt — offline notes

Agent must prefer this folder before internet search.

## Safety order (always)

1. SSH in as root (or configured admin)
2. **Backup first** before any change
3. One change at a time; verify; then next
4. Keep a serial/console path if Wi‑Fi breaks

## Backup / restore

```sh
# Create backup (download from router or copy via SCP)
sysupgrade -b /tmp/backup-$(date +%Y%m%d).tar.gz

# Restore (careful — may reboot)
sysupgrade -r /tmp/backup-YYYYMMDD.tar.gz
```

Also export critical UCI:

```sh
uci export > /tmp/uci-export.txt
```

## Packages

```sh
opkg update
opkg list-upgradable
# Prefer selective upgrades over blind full upgrade on production routers
opkg install <package>
```

If `opkg update` fails: check WAN, DNS, time (`date`), and free space (`df -h`).

## Network basics (UCI)

```sh
uci show network
uci show wireless
uci show dhcp
uci commit
/etc/init.d/network reload
```

### Wi‑Fi (example pattern)

```sh
uci set wireless.radio0.disabled='0'
uci set wireless.default_radio0.ssid='MySSID'
uci set wireless.default_radio0.key='StrongPassword'
uci set wireless.default_radio0.encryption='sae-mixed'   # or psk2
uci commit wireless
wifi reload
```

Exact section names differ by device — always `uci show wireless` first.

### WAN / internet

```sh
uci show network.wan
ifstatus wan
ping -c 3 1.1.1.1
ping -c 3 openwrt.org
```

## DNS

Typical: dnsmasq on LAN. Optional upstream:

- Cloudflare `1.1.1.1`
- AdGuard DNS (if used with AdGuard Home elsewhere)

```sh
uci show dhcp.@dnsmasq[0]
```

## VPN (WireGuard sketch)

1. Install `wireguard-tools` / `kmod-wireguard` if missing
2. Create interface + peer via UCI or `/etc/config/network`
3. Firewall zone: VPN traffic allowed as intended (LAN→VPN or selective)
4. Test with `wg show` and external IP check

Prefer vendor/docs for Amnezia if that stack is required — see `docs/amnezia/`.

## Recovery ideas

- Failsafe mode / reset button (device-specific)
- Restore backup
- Serial console if soft-bricked Wi‑Fi/firewall

## Agent rules

- Never wipe config without explicit user confirm + backup
- Quote exact commands before running destructive ones
- After network changes: verify `ping`, `ifstatus`, client connectivity
