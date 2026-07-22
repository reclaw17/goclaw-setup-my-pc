# Missing / Custom Skills to Create

Based on analysis of Human20 MCP archive (235 skills) + project requirements.

## Already adapted from archive / ready sources
- local-docs ← chip-docs-local
- backup ← backup-manager
- model-router ← auto-model-router
- safety-confirm ← clawguard + openclaw-safe-update
- coding-quality ← superpowers + workshop-shaw-coding-standard + repo-task-proof-loop
- network-vpn ← tailscale-as-exit-node + openclaw-tailscale-remote-access

## Still missing (need custom development)
1. **openwrt-full** — complete OpenWrt workflow: connect, backup/restore, packages update, Wi-Fi, internet, VPN, DNS, high-level RKN/bypass strategy (no ready skill in archive covers full router setup).
2. **pc-setup-arch** — CachyOS / Arch specific: console package install, drivers, network, diagnostics.
3. **pc-setup-windows** — Windows 11 specific: winget, drivers, VPN, diagnostics (partially covered by openclaw-windows-node).
4. **amnezia-adguard** — deep setup for Amnezia Premium + AdGuard Home / VPN / DNS.
5. **fabric-offline** — integration of Fabric (QVAC) as portable offline engine + model loading/unloading on 8GB VRAM.
6. **launcher-bootstrap** — USB launcher scripts + hardware detection.

## Plan
1. Improve existing SKILL.md stubs with more details from archive.
2. Create high-quality custom skills for the missing items above (starting with openwrt-full and fabric-offline).
3. Test offline flow with real model on target hardware.
