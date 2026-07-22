# pc-setup

**Status:** Production-ready  
**Last update:** 2026-07-22

## Purpose
Help the user safely configure CachyOS / Arch Linux and Windows 11 from the console.

## When to use
- Installing packages
- Configuring network, drivers, VPN
- System diagnostics and recovery
- Basic performance and usability setup

## Supported systems
- CachyOS / Arch Linux (pacman, systemd, etc.)
- Windows 11 (winget, PowerShell, Device Manager via CLI where possible)

## Core workflow
1. Identify the operating system.
2. Check local documentation first (`docs/cachyos-arch/` or `docs/windows11/`).
3. Propose the minimal safe set of actions.
4. Always go through `safety-confirm` before any change.
5. Prefer official package managers:
   - Arch/CachyOS → `pacman` / `paru` or `yay` (if already present)
   - Windows → `winget`
6. After changes — verify and report the result.

## Safety rules
- Never run destructive commands without explicit confirmation.
- Prefer reversible actions.
- On Linux: avoid `rm -rf`, forced overwrites, and blind `dd`.
- On Windows: avoid registry hacks unless absolutely necessary and confirmed.

## Integration
- Must use `safety-confirm`
- Must use `local-docs` first
- Can use `network-vpn` and `backup` when relevant

## Quality principle
Help the user achieve a clean, working system without surprises.
