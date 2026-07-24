# pc-setup

**Status:** Production-ready  
**Last update:** 2026-07-24

## Purpose
Guide **PC setup and repair** from the console for **CachyOS / Arch Linux** and **Windows 11**, using official tools where possible.

**Primary knowledge:** `docs/cachyos-arch/`, `docs/windows11/` on the USB.

## When to use
- Install/configure packages, drivers, network on the PC
- Diagnose “no network”, broken packages, missing drivers
- Prepare a clean baseline before VPN/agent work

## Mandatory safety
1. Run **`admin-check`** before any elevated action (sudo / Administrator).
2. Run **`safety-confirm`** — show exact commands, wait for yes.
3. Prefer reversible package manager operations over manual file deletes.
4. No `rm -rf /`, blind `dd`, disk wipe, or registry mass-edits without explicit request + confirm.
5. Secrets (Wi‑Fi, VPN keys) never echoed into chat logs unnecessarily.

## Linux — CachyOS / Arch

### Baseline
```bash
sudo pacman -Syu
```
Explain that a full upgrade can take time; confirm first.

### Packages
- Install with `pacman -S` / remove with `pacman -Rns` only after naming packages and confirming.
- Prefer official repos; AUR only if user accepts the risk and tool (`paru`/`yay`) is present.

### Network
- `ip a`, `nmcli` or systemd-networkd depending on what the host uses
- DNS changes: show before/after; coordinate with `network-vpn`

### Drivers / GPU
- Identify hardware first (`lspci`, `nvidia-smi` if NVIDIA)
- Prefer distro packages (e.g. CachyOS/Arch NVIDIA stack) over random `.run` installers

### Diagnostics
- Logs: `journalctl -b -p err..alert --no-pager | tail`
- Disk: `df -h`, `btrfs filesystem show` if btrfs

## Windows 11

### Baseline
- Prefer **winget** for installs when available
- Elevated PowerShell only after `admin-check`

### Network / VPN
- Use Settings-compatible or official client instructions
- WireGuard / AdGuard / Amnezia: point to vendor docs + `docs/` on USB

### Diagnostics
- `ipconfig /all`, `Get-NetAdapter`, Event Viewer only as needed
- Avoid registry hacks unless user insists and confirms

## Integration
- `admin-check`, `safety-confirm`, `local-docs`, `network-vpn`, `backup`
- Router tasks → hand off to `openwrt`

## Quality bar
Short steps, copy-pasteable commands, no jargon without one-line explanation.
