---
title: Configure Smart EMS LAN settings
description: Set up LAN interface network configuration for Smart EMS devices
tags: [smart-ems, networking, lan, configuration]
---

# Configure LAN settings

Devices registered in Smart EMS include multiple LAN interfaces that can be configured with static IP addresses or DHCP. This guide shows how to configure LAN2 and LAN3 interface settings through the EdgeConfig App.

## How configuration sync works

The device has a local network configuration that is the applied source of truth. Smart EMS stores a separate configuration for the device. When the device polls Smart EMS (which happens automatically), it pulls the stored configuration and overwrites the local configuration.

Do not configure the device via Smart EMS directly. Use the EdgeConfig App to update the configuration.

## Prerequisites

- The device is a Smart EMS type device
- You have the *Device.EDIT_SMARTEMS_CONFIG_LAN* permission
- The device is enabled in the Smart EMS platform
- The device uses a compatible Smart EMS template version

## Open LAN configuration

1. Navigate to the device detail page
2. Click the **Device Config** tab
3. Locate the **Interface Configuration** section

The LAN configuration form displays current settings for available interfaces (LAN2 and LAN3). To see the current network configuration of the interface, click on the info logo next to the Interface's name and a dialog with the information will open.

> [!WARNING]
>
> Do not change the settings for LAN1!

### Configure DHCP

If no static Internet configuration is requested, DHCP is activated for LAN2. <br>
To use DHCP (automatic IP assignment):

1. Toggle **Use DHCP** to enabled
2. Leave IP address, subnet, gateway, and DNS fields empty
3. Click **Save**

The device requests an IP address from the DHCP server on the local network when it boots or when the network interface restarts.

### Configure static IP

To use a static IP address, select the interface you want to configure (for example, **LAN2 Internet** or **LAN3**) and then:

1. Disable **DHCP**.
2. Enter the **IP** address (for example, `192.168.2.10`).
3. Enter the **Subnet Mask** in CIDR notation (for example, `24`).
4. Enter the **Gateway** IP address if required by the target network.
5. Enter the **DNS Server** IP address if required by the target network.
6. Click **Save**.

*Both IP address and subnet mask are required for static IP configuration. Gateway and DNS are optional but recommended for connectivity.*

> [!NOTE]
>
> The input value for the **Subnet Mask** has to be in *CIDR* notation (Classless Inter-Domain Routing) without a slash.
> For example, *24*, *16*, or *8* are valid inputs.

#### Configure static IP for LAN2 Internet

Use these additional checks when configuring **LAN2**:

- Select **LAN2 Internet** in **Interface Configuration** before you edit values.
- Disable **DHCP** only when static values are required by the target network.
- Provide **Gateway** and **DNS Server** values when required for Internet connectivity.

If the static IP is meant for a future target network, do this as the last step before shipment or handover, since it will break northbound connectivity.

## Apply the configuration

When your settings are complete:

1. Review all IP addresses and subnet masks for accuracy
2. Verify gateway and DNS server addresses if provided
3. Click **Save** 
4. After saving, click on **ACTIVATE CONFIG** and monitor changes through the *Command History* Section; the new command's status will change from *pending* to *success*

The platform sends the configuration to the Smart EMS platform API, which updates the device variables and triggers a configuration sync to the edge device.

*The device network interface may restart to apply the new settings. Network connectivity will be briefly interrupted during the change.*

> [!IMPORTANT]
>
> **ACTIVATE CONFIG** requires module *seal-app-cmd-proxy* to be deployed. If modules are not deployed, skip activation and let the device apply settings during the next successful sync.

> [!WARNING]
>
> Applying a static **LAN2** configuration can immediately disconnect the device from the current network. Apply this only when you are ready for the connection interruption.

## Verify the configuration

To confirm the settings were applied:

1. Wait 1-2 minutes for the device to apply the changes
2. Refresh the Device Config page
3. Check that the displayed settings match what you configured
4. Test network connectivity from the device

If the device becomes unreachable after changing network settings, you may need physical access to the device to correct the configuration.

## Troubleshooting

**Device unreachable after configuration change**
The network settings may be incorrect. If you have physical access to the device:
- Connect directly via ethernet on LAN1 interface or connect a monitor and keyboard
- Correct the network settings manually
- Restart the network service or reboot the device

If you don't have physical access, contact an administrator.

**DHCP not working**
Verify:
- A DHCP server is running on the network
- The network cable is connected
- The interface is enabled in the device OS
- The DHCP server has available addresses in its pool

**Static IP not reachable**
Check:
- The IP address is in the correct subnet
- No IP address conflict exists with another device
- The gateway address is correct
- Network cables and switches are functioning
- No overlaps with docker networks

## Next steps

- [Configure cellular settings](./configure-cellular.md) for mobile connectivity
- [Configure NAT settings](./configure-nat.md) for port forwarding