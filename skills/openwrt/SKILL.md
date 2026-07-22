# openwrt

## Description
Work with OpenWrt routers: backup, update packages, configure Wi-Fi, internet, VPN and DNS.

## Mandatory rule
**Always** offer to create a backup before any change on the router.
Do not make changes without a backup and explicit user confirmation.

## Capabilities
- Connect via SSH
- Create and restore configuration backups
- Update package lists and packages
- Configure Wi-Fi (SSID, password, channels)
- Configure WAN / internet
- Set up VPN and DNS
- Help design a network strategy (including bypass considerations at high level)

## Safety
Use the `safety-confirm` skill for every change.
