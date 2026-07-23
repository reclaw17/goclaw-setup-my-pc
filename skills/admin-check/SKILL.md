# admin-check

**Status:** Production-ready  
**Purpose:** Detect whether elevated privileges (admin / sudo) are available before system-changing actions.

## When to use (mandatory)

Before any action that needs elevated rights:

- install / remove / upgrade packages
- change system services
- modify firewall / VPN / DNS at OS level
- write to protected system paths
- driver installation

**Not needed for:**
- starting the agent from USB
- reading docs
- downloading model/binaries into the project folder
- OpenWrt remote actions via SSH (that uses router root, not local admin)

## How to check

### Linux
```bash
# current user is root?
id -u

# can use sudo non-interactively?
sudo -n true
```

Interpretation:
- `id -u` → `0` means already root
- `sudo -n true` success → sudo available without password prompt right now
- otherwise → elevated rights may be missing or will ask password

### Windows
```bat
net session >nul 2>&1
```

- exit code 0 → already running as Administrator
- otherwise → not elevated

Helper scripts:
- `scripts/check-admin.sh`
- `scripts/check-admin.bat`

## Workflow

1. Detect OS
2. Run the check above (or helper script)
3. Tell the user the result in plain language:
   - «Права админа есть»
   - «Прав админа сейчас нет»
4. If rights are missing and action needs them:
   - explain that admin/sudo will be required
   - show the exact command
   - go through `safety-confirm`
   - do **not** pretend the action can succeed without rights
5. Never attempt to bypass UAC/sudo silently

## User-facing examples

**RU**
- «Для установки пакетов нужны права администратора. Сейчас их нет. Запустить команду с sudo после вашего подтверждения?»
- «Права админа уже есть. Показать команду и выполнить после подтверждения?»

**EN**
- «This action needs administrator rights. They are not available now. After your confirmation I can run it with sudo/admin.»

## Integration

- Used by `pc-setup`, `network-vpn`, and any future system-level skill
- Always combined with `safety-confirm`
- Does not replace confirmation — only adds privilege awareness
