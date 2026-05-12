---
title: manage module configuration
description: See all IoT Edge modules running on a device with status and configuration information
tags: [modules, iot-edge, status, management]
---
# Manage module configuration

The module config tab displays all IoT Edge modules running on a device, including system modules and application modules. You can view module status, configuration state, and perform management actions like renaming or deleting modules.

## Open the module list

1. Navigate to the device detail page
2. Click the **Module Config** tab
3. The module list displays automatically

The list refreshes automatically every 5 seconds to show current module status.

## Understanding module types

The module list shows two types of modules:

**System modules** (always present):
- `$edgeAgent`: Manages deployment and reporting
- `$edgeHub`: Routes messages and manages connections

**Application modules** (optional, based on device function):
- `seal-app-opcua-client`: OPC-UA connectivity
- `seal-app-net-discover`: Network device discovery
- `seal-app-mqtt`: MQTT configuration based on Eclipse Mosquitto
- `seal-app-cmd-proxy`: Proxy module to execute direct module methods
- Other custom modules specific to your deployment

## Reading module status

Each module displays several status indicators:

**Runtime status badge**:
- **running**: Module is running normally
- **backoff**: Module restarted due to an error and is in backoff state
- **failed**: Module failed and stopped
- **deploy_scheduled**: Module will be deployed on next sync
- **delete_scheduled**: Module will be removed on next sync
- **runtime_online**: Module is online (for legacy modules)
- **runtime_offline**: Module is offline (for legacy modules)

**Configuration status**:
Shows whether the module's configuration is synchronized:
- Configuration ID values indicate the version of the configuration
- Mismatched desired and reported IDs indicate pending configuration updates

## Module version

The **Version** column shows the Docker image tag for each module. This indicates which version of the module software is running.

Example: `1.2.3` or `latest`

## Open module details

To view detailed information or configure a module:

1. Click the module row in the table
2. The module detail modal opens

The modal has three tabs:

- **Module Twin**: View and edit configuration
- **Logs**: View recent log output
- **Direct Methods**: Execute commands on the module

Notice, that for several modules the **SET TWIN CONFIG** button has to be clicked to persist the changes.

## View module logs

To see recent log output:

1. Open the module detail modal
2. Click the **Logs** tab
3. Recent log lines display in reverse chronological order

Logs help troubleshoot module issues. Look for error messages, warnings, or unexpected behavior. You can download logs or filter by log level depending on your platform configuration.

## Execute direct methods

To run commands on a module:

1. Open the module detail modal
2. Click the **Direct Methods** tab
3. Select a method from the list or enter a method name
4. Provide any required parameters as JSON
5. Click **Invoke**

Direct methods allow you to trigger actions or retrieve information from the module without changing its configuration. Available methods depend on the module implementation.

## Troubleshooting

**Module stuck in backoff status**
The module is restarting repeatedly due to an error. Check the module logs for error messages. Common causes include invalid configuration, missing dependencies, or resource limits.

**Configuration not updating**
The module may be offline or unable to process configuration updates. Verify:
- The module status is **running**
- The device is connected to IoT Hub
- The configuration is valid JSON matching the module's schema

**Module not appearing in list**
The module may not be deployed to the device. Check that:
- The deployment includes the module
- The device matches the deployment target conditions
- There are no deployment errors in the edge agent logs

## Next steps

- Use the **Direct Methods** tab to run commands on modules
- Check module logs regularly to monitor health and troubleshoot issues
