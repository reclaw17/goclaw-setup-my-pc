# pc-setup

**Status:** Production-ready  
**Last update:** 2026-07-24

## Purpose

Safely configure **CachyOS / Arch Linux** and **Windows 11** from the portable agent.

## When to use

- Install / remove packages
- Drivers, network, VPN client on the PC
- Diagnostics and recovery hints
- First-time system setup tasks the user names

## Workflow

1. Detect OS (Linux vs Windows).
2. Read local docs first: `docs/cachyos-arch/` or `docs/windows11/`.
3. System-changing action → **`admin-check`**.
4. Propose **minimal** steps.
5. **`safety-confirm`** with exact commands.
6. Prefer official package managers:
   - Arch/CachyOS → `pacman` (AUR helper only if already present / user accepts)
   - Windows → `winget`
7. Verify after change.

## Linux examples (always confirm first)

```bash
sudo pacman -Syu
sudo pacman -S <package>
```

## Windows examples (always confirm first)

```bat
winget search <name>
winget install <id>
```

## Admin rules

- Missing sudo/admin → say so; do not fake success.
- Show the elevated command and ask once.

## Safety

- No destructive disk/partition commands without explicit multi-step confirmation.
- Prefer reversible package installs over manual file deletes.

## Integration

- `admin-check`, `safety-confirm`, `local-docs`, `network-vpn`, `backup`, `coding-quality`
