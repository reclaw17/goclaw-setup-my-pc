# safety-confirm

## Description
Cursor-style safety layer. Requires explicit user confirmation before any dangerous action.

## When to use
Before executing any command or action that:
- Changes system settings
- Installs or removes software
- Modifies network / VPN / DNS
- Changes OpenWrt configuration
- Writes files outside safe directories
- Runs commands with elevated privileges

## How it works
1. Show the exact command or action you want to perform.
2. Explain briefly what it will do.
3. Ask for confirmation.
4. Only execute after the user clearly agrees.

## Rules
- Never skip confirmation for dangerous actions.
- If the user says "no" or is unsure — stop and offer safer alternatives.
