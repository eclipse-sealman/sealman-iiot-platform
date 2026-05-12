---
title: create device
description: Add a new edge device from the devices list
tags: [devices, create, onboarding, iot-hub, smart-ems]
---

# Create a device

You can create a new device from the devices list using the **Add Device** button in the top bar.

Creating a device provisions it across all required backend systems:

- **Azure IoT Hub**
- **Smart EMS**
- **Platform database**

## Open the create device dialog

1. Open the [device list](./browse-devices.md)
2. In the top bar, click **Add Device**
3. The **Add Device** popup opens

## Fill in device information

In the popup, provide the required fields:

- **Device ID**: Unique identifier used for the device in the platform
- **Auth Type**: Authorization type - for now, only 'sas' is supported
- **Registration ID**: Registration identifier used during provisioning
- **Metadata**: Additional contextual information stored with the device

Use clear and consistent values that match your naming conventions.

## Create the device

1. Verify all entered values
2. Click **Create**

The system starts the creation process and registers the device in IoT Hub, Smart EMS, and the database.

## Verify successful creation

After creation completes:

1. Return to the [device list](./browse-devices.md)
2. Search for the new device by **Device ID**
3. Open the device details to confirm the entry

You can inspect the full device information on the [device detail page](./inspect-device-details.md).

## Next steps

- Open [device details](./inspect-device-details.md) to review status and metadata information
