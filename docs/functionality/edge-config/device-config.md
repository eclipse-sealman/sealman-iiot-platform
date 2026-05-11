---
title: device config tab
description: Configure Smart EMS network settings for a device from the Device Config tab
tags: [device-config, smart-ems, network, configuration]
---

# Device Config tab

The **Device Config** tab provides access to Smart EMS network configuration for a device.

The tab covers three areas of configuration:

- **LAN**: Configure LAN interface addresses and DHCP settings
- **Cellular**: Configure mobile data APN and authentication settings
- **NAT**: Configure port forwarding rules between network interfaces

## Open Device Config tab

1. Open a device from the [device list](./browse-devices.md)
2. Click the **Device Config** tab
3. The configuration sections are displayed

## Configuration areas

### LAN settings

Configure static IP addresses or DHCP for the device LAN interfaces.

See [configure LAN settings](./device-configuration/configure-lan.md) for full instructions.

### Cellular settings

Configure APN credentials and connection parameters for mobile data interfaces.

See [configure cellular settings](./device-configuration/configure-cellular.md) for full instructions.

### NAT rules

Configure port forwarding rules to route traffic between network interfaces.

See [configure NAT rules](./device-configuration/configure-nat.md) for full instructions.

## Next steps

- Return to [device details](./inspect-device-details.md) to review device status and metadata
- Continue with [Module Config](./manage-module-config.md) to manage IoT Edge modules
- Continue with [Network](./network-scan.md) to perform a network scan and classify machines and services
