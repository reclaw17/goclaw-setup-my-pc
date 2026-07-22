# safety-confirm

**Status:** Production-ready  
**Inspiration:** Cursor approval model + clawguard / openclaw-safe-update patterns  
**Last update:** 2026-07-22

## Purpose

This skill is the mandatory safety layer of the agent.  
The model (brain) must use it before any action that can change the system or the router.

## When to use (mandatory)

Before performing any of the following actions:

- Installing, removing or upgrading software
- Changing system settings
- Modifying network, VPN, DNS or firewall
- Any change on OpenWrt (including package updates and Wi-Fi)
- Writing files outside clearly safe directories
- Running commands with elevated privileges (sudo / root)
- Factory reset or sysupgrade

## Strict Workflow

1. Prepare the exact command(s)
2. Show them to the user in a clear code block
3. Briefly explain the effect
4. Ask for explicit confirmation (examples):
   - «Выполнить эти команды?»
   - «Подтвердите, пожалуйста»
   - «Can I run this?»
5. Wait for a clear positive answer from the user
6. Only then execute

## Rules

- Never skip confirmation for dangerous actions
- If the user says «нет», «no», «подожди», «не уверен» — stop immediately
- Offer a safer alternative when possible
- For OpenWrt: always combine with a backup offer
- This skill has higher priority than speed or convenience
- All model wrappers must respect this skill

## Integration

- Called by the model before using tools that can change the system
- Works together with `openwrt`, `pc-setup`, `network-vpn` and `backup`
- Must be respected by every model wrapper

## Test scenarios

1. User asks to install a package → agent must show the command and wait
2. User asks to change Wi-Fi on OpenWrt → agent must offer backup + confirmation
3. User says «just do it» → agent still shows the command and asks once more
