# backup

**Status:** Production-ready  
**Last update:** 2026-07-24

## Purpose

Create and restore backups **before** risky changes on PC or OpenWrt.

## When to use (mandatory)

- Before OpenWrt config changes, package upgrades, sysupgrade
- Before major PC network / VPN / DNS changes
- When the user asks to “save settings” or “rollback”

## OpenWrt (official)

### Backup

```bash
ssh root@192.168.1.1 'sysupgrade -b /tmp/backup-$(date +%F).tar.gz'
scp root@192.168.1.1:/tmp/backup-*.tar.gz ./backups/
```

Store under USB `backups/openwrt/` when possible.

### Restore

```bash
scp ./backups/openwrt/backup-XXXX.tar.gz root@192.168.1.1:/tmp/
ssh root@192.168.1.1 'sysupgrade -r /tmp/backup-XXXX.tar.gz'
```

Always combine with `safety-confirm`. Prefer backup **before** restore verification story is clear to the user.

## PC (Linux)

- Prefer copying specific config files the user cares about (e.g. NetworkManager profiles, wireguard configs under home) into `backups/pc/YYYY-MM-DD/`
- Do not dump entire `/` 
- System-level paths may need `admin-check`

## PC (Windows)

- Export useful configs the user names (VPN profiles, etc.) to `backups/pc/`
- Avoid blind full-disk images unless user explicitly asks and understands size/time

## Rules

1. Offer backup **before** major changes (especially OpenWrt).
2. Show exact paths where backup files will live.
3. Never overwrite an existing backup file without a new timestamped name.
4. Integrate with `openwrt`, `pc-setup`, `safety-confirm`.
