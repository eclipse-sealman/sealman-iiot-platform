---
title: browse devices
description: Access and filter the list of edge devices in your organization
tags: [devices, list, filtering, search]
---

# Browse device list

The devices list displays all edge devices you have permission to view. You can search, filter, and sort devices to find specific devices.

## Open the devices list

Click **Devices** in the top navigation bar menu. The devices list opens showing all existing devices.

The list displays these columns:
- **Status**: Online or offline in the Azure IoT Hub
- **Device Id**: Unique identifier for the device
- **Customer**: Customer name associated with the device
- **City**: Device location city
- **Country**: Device location country with flag icon
- **Description**: Device description
- **Delete**: Action button to delete a device

## Search for devices

To find devices by any attribute:

1. Locate the search box at the top right of the table
2. Type part of the device name or any other attribute
3. The list filters automatically as you type

The search matches attributes that contain your search term. The search is case-insensitive.

## Filter by column

To filter devices by specific attributes:

1. Click the text field in any column header
2. Enter the filter value
3. Press **Enter** or click outside the filter box

You can apply filters to multiple columns simultaneously. The table shows only devices that match all active filters.

To clear a filter:

1. Click the **CLEAR FILTER** button in the top bar

## Open device details

To view detailed information about a device or to interact with the device:

1. Click the device name in the list
2. The device detail page opens

The [device detail page](./inspect-device-details.md) provides comprehensive information about the device.

## Create a new device

To add a new device from the list view:

1. Click **Add Device** in the top bar
2. Fill in the required fields in the popup
3. Click **Create**

For full instructions, see [create device](./create-device.md).