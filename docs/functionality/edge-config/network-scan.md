---
title: use network tab
description: Perform manual network scans and classify detected endpoints from the device Network tab
tags: [network, scan, endpoints, services, discovery]
---

# Use Network tab

The **Network** tab lets you run manual network scans from a device and classify discovered endpoints and services.

## Prerequisite

Network scan requires the `seal-app-net-discover` module to be installed on the device.

If this module is not installed, the **Network** tab shows a warning and scanning is not available.

To verify module installation, check the [Module Config](./manage-module-config.md) tab.

## Open Network tab

1. Open a device from the [device list](./browse-devices.md)
2. Open the **Network** tab
3. The topology viewer and network scan controls are displayed

## Configure manual scan

In the network scan configuration panel, define the scan scope:

- **Network Prefix**: Network range to scan (for example `192.162.0.0`)
- **Subnet**: Subnet mask size (for example `24`)
- **Ports to scan**: List of ports checked during scan

Port values are prefilled, and you can add or remove ports when needed.

You can also use **Read network configuration** to load network values from the device when available.

## Run manual scan

1. Verify **Network Prefix**, **Subnet**, and **Ports to scan**
2. Click **Perform manual scan**
3. Wait for the scan to finish and review **Manual scan results**

When endpoints are found, they appear in the endpoint list on the left side.

## Review discovered endpoints

To inspect a discovered endpoint:

1. Click an endpoint in the left-side list
2. Review connectivity status and endpoint details in the endpoint panel

The panel shows endpoint information such as IP address and last status change.

## Classify endpoint and services

For each selected endpoint, you can update classification fields:

- **Endpoint type**: Select a predefined endpoint type from platform settings
- **Description**: Set or update endpoint description
- **Services**: Review detected ports and assign service names

Service names are prefilled from platform-defined service port settings.

After making changes, click **Save** to persist endpoint or service updates.

## Platform settings integration

Network tab dropdown values are driven by platform settings:

- Endpoint type options come from [network settings](./platform-settings/network-settings.md) **Endpoint Types**
- Service name options come from [network settings](./platform-settings/network-settings.md) **Service Ports**

Update platform settings first if expected endpoint types or service names are missing.

## Troubleshooting

**Network tab shows warning**
The `seal-app-net-discover` module is missing or not running. Install or recover the module in [Module Config](./manage-module-config.md).

**No endpoints found**
Verify the device is online, check network prefix and subnet values, and confirm relevant ports are included in **Ports to scan**.

**Endpoint or service dropdown values are missing**
Confirm the required values are defined in [network settings](./platform-settings/network-settings.md).

## Next steps

- Configure platform endpoint and service defaults in [network settings](./platform-settings/network-settings.md)
- Manage required discovery module in [Module Config](./manage-module-config.md)
