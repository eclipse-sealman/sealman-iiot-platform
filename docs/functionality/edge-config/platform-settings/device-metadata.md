---
title: device metadata
description: Define platform-wide metadata keys displayed on device creation and device details
tags: [platform-settings, metadata, device-keys]
---

# Device metadata

The device metadata page lets you define metadata keys that are visible for all devices in the platform.

These keys are used in two places:

- **Device creation**: Keys appear as metadata fields when creating a device
- **Device details**: Keys are displayed in the device information view

## Open device metadata

1. Open **Settings** from the main navigation
2. Click **Device Metadata** in the settings menu
3. The **Device Metadata** page opens

## Add a metadata key

To create a new metadata key:

1. In the **Metadata Keys** section, enter a value in **New metadata key**
2. Click **Add**

The new key is added to the platform-wide metadata key list and becomes available for all devices.

## Remove a metadata key

To remove an existing metadata key:

1. Locate the key in the **Metadata Keys** list
2. Click the delete action in the same row

Be aware that it is possible to delete keys that have values set in devices. A warning will be displayed in that case.
For devices that have a value set for that key, it will become device specific metadata.

## Scope and behavior

Device metadata keys are global and apply to the whole platform.

Changes to the key list affect all device creation and device detail workflows.

## Next steps

- See [create device](../create-device.md) to use metadata keys during device creation
- See [inspect device details](../inspect-device-details.md) to review metadata on existing devices
