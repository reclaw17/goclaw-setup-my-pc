# safety-confirm

**Status:** Production-ready  
**Inspiration:** Cursor approval model + clawguard patterns  
**Last update:** 2026-07-23

## Purpose

Mandatory safety layer before any action that can change the system or the router.

## When to use (mandatory)

Before:

- Installing, removing or upgrading software
- Changing system settings
- Modifying network, VPN, DNS or firewall
- Any change on OpenWrt
- Writing outside clearly safe directories
- Running elevated commands (sudo / Administrator)
- Factory reset or sysupgrade

## Strict Workflow

1. Prepare the exact command(s)
2. **If the action needs elevated rights — run `admin-check` first**
3. Tell the user clearly whether admin/sudo is available
4. Show the exact command(s) in a code block
5. Briefly explain the effect
6. If admin rights are required, say so explicitly
7. Ask for confirmation:
   - «Выполнить эти команды?»
   - «Can I run this?»
8. Wait for a clear positive answer
9. Only then execute

## Rules

- Never skip confirmation for dangerous actions
- Never silently escalate privileges
- If admin rights are missing, do not pretend the action will work
- If user says «нет», «no», «подожди», «не уверен» — stop
- For OpenWrt: always combine with backup offer
- This skill has higher priority than speed

## Integration

- Works with `admin-check`, `openwrt`, `pc-setup`, `network-vpn`, `backup`
- Must be respected by every model wrapper

## Test scenarios

1. Install package without admin → agent reports missing rights + asks confirmation for sudo/admin path
2. Install package with admin → agent still shows command and asks once
3. OpenWrt change → backup offer + confirmation
