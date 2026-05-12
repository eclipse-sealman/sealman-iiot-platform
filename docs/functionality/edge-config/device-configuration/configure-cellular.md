---
title: Configure Smart EMS cellular settings
description: Set up 4G/5G cellular connectivity for Smart EMS devices with APN and authentication
tags: [smart-ems, cellular, mobile, connectivity]
---

# Configure cellular settings

Devices registered in Smart EMS support interfaces for mobile data connectivity. This guide shows how to configure APN settings, authentication, and connection parameters for each interface.

## Prerequisites

- The device is a Smart EMS type device
- You have the *Device.EDIT_SMARTEMS_CONFIG_CELLULAR* permission
- The device has cellular hardware installed
- You have APN details from your mobile network provider

## Open cellular configuration

1. Navigate to the device detail page
2. Click the **Device Config** tab
3. Locate the **Cellular Configuration** section

The cellular configuration form displays settings for the available interface.

## Configure cellular interface 

### Enter the APN

The Access Point Name (APN) is provided by your mobile network operator.

1. In the **APN** field, enter the APN string
2. Example: `internet.provider.com` or `m2m.apn`

The APN determines which data network the cellular modem connects to.

### Enter the SIM PIN

If your SIM card requires a PIN:

1. Enter the **PIN** code
2. Example: `1234` or `0000`

Leave this field empty if your SIM does not have a PIN or if the PIN is disabled.

### Configure authentication

Some cellular networks require authentication credentials.

1. Enter the **Username** if required by your provider
2. Enter the **Password** if required by your provider
3. Select the **Authentication Protocol**:
   - **None**: No authentication
   - **PAP**: Password Authentication Protocol (less secure)
   - **CHAP**: Challenge-Handshake Authentication Protocol (more secure)

If your provider does not require authentication, leave username and password empty and select **None**.

## Apply the configuration

When your settings are complete:

1. Review all APN and credential values
2. Verify authentication protocol selection
3. Click **Save**
4. After saving, click on **ACTIVATE CONFIG** and monitor changes through the *Command History* Section; the new command's status will change from *pending* to *success*

The platform sends the configuration to the Smart EMS platform API. The API updates device variables and triggers a configuration sync to the edge device.

*The cellular interface may restart to apply the new settings. Mobile data connectivity will be briefly interrupted during the change.*

## Verify the connection

To confirm the cellular connection is working:

1. Wait 1-2 minutes for the device to apply the settings and connect
2. Refresh the Device Config page or check device status
3. Look for cellular connection indicators in the device status

If the connection fails, check the device logs or Smart EMS platform status for error messages.

## Troubleshooting

**Connection fails after configuration**
Verify:
- The APN is correct for your mobile network provider
- The SIM card is inserted and activated
- The SIM PIN is correct if required
- Cellular signal strength is adequate at the device location
- The SIM plan includes data and is not expired

**Authentication error**
Check:
- Username and password are correct
- Authentication protocol matches provider requirements
- Account is active with the cellular provider

**No signal or poor connection**
Consider:
- Physical location and signal strength
- Antenna connection and placement
- Network coverage at the site
- Interference from building materials or equipment

**SIM locked error**
The SIM may be locked due to:
- Too many incorrect PIN attempts
- SIM card requiring PUK code
- SIM card not activated by the provider

Contact your provider to unlock the SIM or obtain the PUK code.

**Configuration not applied**
Check:
- The device is online and connected to the platform
- Smart EMS configuration sync is functioning
- Device template version supports cellular configuration
- No conflicting network settings

## Security considerations

- Store cellular credentials securely
- Use CHAP authentication when available for better security
- Monitor data usage to detect unauthorized use
- Consider using M2M-specific SIM cards with security features
- Disable unused cellular interfaces to reduce attack surface

## Next steps

- [Configure LAN settings](./configure-lan.md) for wired network connectivity
- [Configure NAT settings](./configure-nat.md) for port forwarding
