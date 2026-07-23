# pc-setup

**Status:** Production-ready  
**Last update:** 2026-07-23

## Purpose
Help the user safely configure CachyOS / Arch Linux and Windows 11.

## When to use
- Installing packages
- Network, drivers, VPN
- Diagnostics and recovery
- Basic system setup

## Supported systems
- CachyOS / Arch Linux
- Windows 11

## Core workflow
1. Identify OS
2. Check local docs first (`docs/cachyos-arch/` or `docs/windows11/`)
3. If action changes the system → run `admin-check`
4. Propose minimal safe actions
5. Always use `safety-confirm` before changes
6. Prefer official package managers:
   - Arch/CachyOS → `pacman` / existing AUR helper
   - Windows → `winget`
7. Verify result after changes

## Admin rules
- Package install/remove/upgrade → check admin/sudo first
- Driver and service changes → check admin/sudo first
- If rights are missing:
  - say it plainly
  - show the command that will need elevation
  - ask confirmation
  - do not silently continue as if success is guaranteed

## Safety rules
- No destructive commands without explicit confirmation
- Prefer reversible actions
- Linux: avoid `rm -rf`, blind `dd`, forced overwrites
- Windows: avoid registry hacks unless necessary and confirmed

## Integration
- `admin-check`
- `safety-confirm`
- `local-docs`
- `network-vpn` / `backup` when relevant
