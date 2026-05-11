---
title: inspect device details
description: Access comprehensive information about a specific edge device
tags: [devices, details, status, information]
---

# Inspect device details

The device detail page provides comprehensive information about an individual edge device, including connection status, location, configuration, and operational data.

## Open device details

From the devices list:

1. Locate the device you want to view
2. Click the device name
3. The device detail page opens on the **Info** tab

## Review connection status

The **Connection Status** section at the top of the page shows real-time connection state for:

- **IoT Edge Runtime**: Edge runtime health and version
- **IoT Hub**: Connection to Azure IoT Hub
- **SEMS**: Smart EMS connection (if applicable)

Green badges indicate active connections. Red badges indicate disconnected or unavailable services.

*Connection status updates approximately every 60 seconds from the platform cache.*

## View/Edit metadata information

The **Device Metadata** section displays by default the platform metadata keys and all values set for the current device.
The platform automatically creates the following platform metadata keys:

- **Customer**: Customer name for this device
- **CountryCode**: Abbreviation of the physical location country
- **City**: Physical location city
- **Geo Location**: Latitude and longitude coordinates
- **Description**: Custom description text

By clicking on "Edit", you can add/update/remove metadata information. Platform metadata keys are always visible for every device.

## Check Smart EMS information

If the device integrates with the Smart EMS platform, the **Smart EMS Information** section shows:

- **Smart-EMS Status**: Device status set in SEMS 
- **Last Seen At**: Last contact from device to SEMS
- **Hardware Version**: Device model
- **FW Update Scheduled**: Firmware update scheduled in SEMS
- **Firmware Version**: Current Smart EMS firmware
- **Template**: Configuration template in use
- **Cellular**: Has the device cellular connectivity capabilities 

This section only appears for devices configured with Smart EMS integration.

## Use security section

The **Security** section provides access to device password information and password lifecycle actions.

The section includes:

- **Device Password**: Action to display the current password value
- **Device Password Last Updated**: Timestamp of the most recent password update

### Show password value

To view the password value:

1. In the **Security** section, click to show the password value
2. A popup opens and displays the password

Showing the password also triggers the password to be updated within 24 hours.

### Renew password

To rotate the device password immediately:

1. In the **Security** section, request password renewal
2. Wait for the renewal operation to complete
3. Verify the update in **Device Password Last Updated**

Use renewal when credentials must be rotated on demand.

## Navigate to other tabs

The device detail page includes four tabs:

- **Info**: Overview and status (current tab)
- **[Device Config](./device-config.md)**: Smart EMS LAN, cellular, and NAT configuration
- **[Module Config](./manage-module-config.md)**: IoT Edge modules, configuration, logs, and direct methods
- **[Network](./network-scan.md)**: Manual network scan and discovered endpoint classification

Click any tab name to switch views. Each tab loads data specific to its function.

## Understanding data freshness

Different sections of the device detail page have different update frequencies:

- **Connection status**: Updates every 60 seconds from cache
- **Basic information**: Updates when device twin tags change
- **Smart EMS info**: Updates on-demand when the tab loads
- **Module status**: Updates in real-time when viewing the Module Config tab

To see the most current data, refresh the page or switch between tabs to trigger a reload.

## Troubleshooting

**Device shows as disconnected**
The device may be offline, experiencing network issues, or the IoT Hub connection may be interrupted. Check physical connectivity and IoT Hub status.

**Tabs are missing or disabled**
Your role may not have permission to access certain features. Contact your administrator if you need access to additional functionality.

## Next steps

- View the [**Device Config**](./device-config.md) tab to configure Smart EMS LAN, cellular, and NAT settings
- View the [**Module Config**](./manage-module-config.md) tab to see installed modules and manage module configuration
- View the [**Network**](./network-scan.md) tab to run network scans and classify discovered endpoints
