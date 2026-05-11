---
title: network settings
description: Configure platform-wide endpoint types and service ports for network scan classification
tags: [platform-settings, network, endpoint-types, service-ports]
---

# Network settings

The network settings page lets you manage shared network definitions used across the whole platform.

It has two sections:

- **Endpoint Types**: Predefined endpoint type or machine names mapped to default IP addresses
- **Service Ports**: Predefined service names mapped to default port numbers

These definitions are used as suggestions in network scan dropdown fields and help standardize naming across projects and devices.

## Open network settings

1. Open **Settings** from the main navigation
2. Click **Network** in the settings menu
3. The **Network Settings** page opens

## Manage endpoint types

The **Endpoint Types** section defines standard endpoint labels for known IP patterns.

Each endpoint type includes:

- **Name**: Endpoint type or machine name shown in the network scan dropdowns
- **Description**: Optional explanation of the endpoint purpose
- **Default IP**: Default IP value associated with the endpoint type

### Add an endpoint type

1. In **Endpoint Types**, enter a value in **Name**
2. Optionally enter a value in **Description**
3. Enter the **Default IP** value
4. Click **Add**

The new endpoint type becomes available in network scan selections.

### Delete an endpoint type

1. Locate the endpoint type in the list
2. Click **Delete** in the same row

The endpoint type is removed from the shared platform settings.

## Manage service ports

The **Service Ports** section defines standard service labels for known port numbers.

Each service port entry includes:

- **Name**: Service name shown in the network scan dropdowns
- **Description**: Optional explanation of the service
- **Default Port**: Port number associated with the service

### Add a service port

1. In **Service Ports**, enter a value in **Name**
2. Optionally enter a value in **Description**
3. Enter the **Default Port** value
4. Click **Add**

The new service port entry becomes available in network scan selections.

### Delete a service port

1. Locate the service port in the list
2. Click **Delete** in the same row

The service port is removed from the shared platform settings.

## Scope and behavior

Network settings are global and apply to the whole platform, not to a single device.

Changes affect how endpoint and service labels are presented in network scan workflows for all users.

## Next steps

- Continue with [device templates](./device-templates.md) to define reusable device structures
- Continue with [device metadata](./device-metadata.md) to define shared metadata fields
