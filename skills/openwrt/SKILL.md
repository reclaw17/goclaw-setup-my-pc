# openwrt

## Description
Full workflow for working with OpenWrt routers: connection, backup/restore, package management, Wi-Fi, network, VPN and DNS.

**Primary reference:** local offline documentation in `docs/openwrt/` on the USB drive.
Always prefer local docs first. Use official OpenWrt documentation principles.

## Mandatory Safety Rules

1. **Backup first**  
   Before *any* configuration change, always offer and perform a configuration backup.

2. **Explicit confirmation**  
   Show the exact commands and wait for user approval before executing.

3. **No destructive actions without confirmation**  
   Never run `sysupgrade`, factory reset, or major network changes without clear permission.

4. **Prefer official methods**  
   Use `uci`, `opkg`, `sysupgrade`, `wifi` and standard OpenWrt tools.

---

## 1. Connection

- Prefer SSH (port 22, user `root`)
- Default IP is often `192.168.1.1`
- Always verify connectivity before proceeding

```bash
ssh root@192.168.1.1
```

---

## 2. Backup & Restore (Official method)

### Create backup
```bash
sysupgrade -b /tmp/backup-$(date +%F).tar.gz
```

Then copy the file from the router to the USB or computer:
```bash
scp root@192.168.1.1:/tmp/backup-*.tar.gz ./
```

### Restore backup
```bash
sysupgrade -r /tmp/backup-XXXX.tar.gz
```

**Note:** Configuration backup is file-level (settings). It does not include the full firmware image.

Official source: https://openwrt.org/docs/guide-user/troubleshooting/backup_restore

---

## 3. Update packages

```bash
opkg update
opkg list-upgradable
opkg upgrade
```

Always run `opkg update` before installing or upgrading packages.

---

## 4. Wi-Fi configuration

Configuration is stored in `/etc/config/wireless` and managed via UCI.

Basic flow:
1. Show current config: `uci show wireless`
2. Set SSID, encryption, key, country code
3. Enable radio if disabled
4. Commit and reload:

```bash
uci commit wireless
wifi reload
```

Official source: https://openwrt.org/docs/guide-user/network/wifi/basic

---

## 5. Network / Internet (WAN)

- Use UCI for network interfaces (`/etc/config/network`)
- Prefer checking current status first:

```bash
uci show network
ifstatus wan
```

---

## 6. VPN (WireGuard preferred)

Recommended approach (official):
1. Install packages: `wireguard-tools`, `kmod-wireguard`, `luci-proto-wireguard` (if LuCI is used)
2. Create WireGuard interface via UCI
3. Import or manually set private key, peer public key, endpoint, allowed IPs
4. Add firewall zone and forwarding rules
5. Commit and restart network

Always show the full set of commands and ask for confirmation.

Official sources:
- https://openwrt.org/docs/guide-user/services/vpn/wireguard/client
- https://openwrt.org/docs/guide-user/services/vpn/wireguard/server

---

## 7. DNS

Usually managed by `dnsmasq`.

Common tasks:
- Change upstream DNS servers
- Disable rebind protection if needed (with caution)
- Add custom host entries

Always prefer UCI for changes.

---

## 8. High-level network strategy

When the user asks for help with provider restrictions / RKN-style blocking:

- Discuss options at high level only (VPN, alternative DNS, split tunneling, etc.)
- Never provide ready-made bypass recipes that could be illegal or harmful
- Always require confirmation before implementing any networking changes
- Prefer well-known open-source solutions (WireGuard, standard OpenWrt packages)

---

## Workflow recommendation

1. Connect via SSH
2. Create backup
3. Update package lists
4. Make one logical change at a time
5. Test after each change
6. Create a new backup after successful configuration

---

## Local documentation priority

Always check first:

```
docs/openwrt/
```

If the needed information is missing in local docs — inform the user and only then use internet search.
