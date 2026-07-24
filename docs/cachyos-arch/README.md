# CachyOS / Arch Linux — offline notes

## Safety
- Need elevation → check admin/sudo first.
- Show full commands before running.
- Prefer `pacman` official repos over random scripts.

## Update system
```bash
sudo pacman -Syu
```

## Install packages
```bash
sudo pacman -S <packages>
```

## Network
```bash
ip a
# NetworkManager:
nmcli device status
nmcli connection show
```

## Drivers (high level)
1. Identify GPU: `lspci | grep -i vga`
2. Prefer distro packages (CachyOS/Arch NVIDIA/AMD stacks).
3. Avoid proprietary `.run` installers unless user accepts the risk.

## Logs
```bash
journalctl -b -p err..alert --no-pager | tail -n 50
```

## Disk
```bash
df -h
# if btrfs:
findmnt /
```

## Agent on this OS
Primary path: GoClaw **Lite AppImage** via `bash prepare.sh` && `bash start.sh`.
