# CachyOS / Arch Linux — offline notes

## Safety
- Elevation → admin/sudo check first.
- Show full commands before running.
- Prefer official `pacman` repos.

## System update
```bash
sudo pacman -Syu
```

## Install packages
```bash
sudo pacman -S package1 package2
```

## Network
```bash
ip a
nmcli device status
nmcli connection show
```

## GPU / drivers
```bash
lspci | grep -iE 'vga|3d|display'
```
Prefer distro NVIDIA/AMD stacks (CachyOS/Arch packages), not random `.run` files.

## Logs / disk
```bash
journalctl -b -p err..alert --no-pager | tail -n 80
df -h
findmnt /
```

## This agent on Linux
```bash
bash prepare.sh          # apps/GoClaw-Lite-x86_64.AppImage
# optional offline brain:
bash scripts/fetch-offline-stack.sh linux
bash start.sh
```
See `docs/EMBED.md`.
