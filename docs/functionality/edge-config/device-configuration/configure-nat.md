---
title: Configure ECA NAT rules
description: Set up port forwarding and network address translation for Smart EMS devices in EdgeConfig App
tags: [smart-ems, edgeconfig-app, nat, port-forwarding, networking]
---

# Configure NAT rules

Devices registered in Smart EMS support Network Address Translation (NAT) rules for port forwarding between network interfaces. This guide shows how to configure NAT rules to route traffic from one network to another.

## Prerequisites

- The device is registered in Smart EMS and 
- You have the *Device.EDIT_SMARTEMS_CONFIG_NAT* permission
- You understand your network topology and routing requirements
- You know the external (source) and internal (destination) IP addresses

## Understanding NAT rules

NAT rules forward traffic from one network interface to another, enabling:

- **Forwarding**: Route external requests to internal services; all ports are forwarded
- **Network bridging**: Connect isolated networks through the device
- **Access control**: Control which services are accessible from which networks

Each NAT rule specifies:
- **External IP**: Where traffic originates via the LAN2 interface
- **Internal IP**: Where to forward the traffic on LAN3 interface

## Open NAT configuration

1. Navigate to the device detail page
2. Click the **Device Config** tab
3. Locate the **1:1 NAT Configuration** section

The NAT configuration interface displays existing rules and allows you to add new ones.

*Smart EMS devices support a maximum of 3 NAT rules per device.*

## Add a NAT rule

To create a new port forwarding rule:

1. Assure that the checkbox **Enable nat configuration** is set
2. Click **ADD A RULE** 
3. Input fields for name, external IP and internal IP are shown

## Configure rule parameters

Note, the name is not allowed to contain spaces or special characters.

### External IP address - LAN2

Enter the IP address where traffic originates from LAN2:

- Example: `192.168.1.100` (specific device)

This is the address on the external network interface.

### Internal IP address

Enter the IP address where traffic should be forwarded to in LAN3:

- Example: `10.0.0.50` (internal device)

This is the address on the internal network interface.

## NAT rule example

To forward external OPC-UA traffic to an internal server:

- **Name**: opc-ua
- **External IP**: `192.168.1.100` (external interface)
- **Internal IP**: `10.0.0.20` (internal OPC-UA server)


This rule forwards OPC-UA requests arriving at the device's external interface to an internal server.

## Save the rule

When the rule is complete:

1. Review all IP addresses and ports
2. Verify the protocol selection
3. Click **Save**

The EdgeConfig App automatically carries out a plausibility check. Afterwards, the rule appears in the NAT rules list.

## Add additional rules

To add more NAT rules:

1. Repeat the process for each rule
2. Configure unique source and destination combinations
3. Remember the 3-rule maximum limit

If you need to add a fourth rule, you must first delete an existing rule.

## Edit a NAT rule

To modify an existing rule:

1. Locate the rule in the list
2. Click an edit button or icon
3. Update the rule parameters
4. Save the changes

## Delete a NAT rule

To remove a rule:

1. Locate the rule in the list
2. Click the delete button or icon
3. Confirm the deletion if prompted

Deleted rules stop forwarding traffic immediately after the configuration is applied.

## Apply the configuration

After adding, editing, or deleting rules:

1. Review all NAT rules in the list
2. Verify each rule's parameters
3. Click **Save Changes**
4. After saving, click on **ACTIVATE CONFIG** and monitor changes through the *Command History* Section; the new command's status will change from *pending* to *success*

The platform sends the configuration to the Smart EMS API, which updates the device's configuration and triggers a sync.

*Network routing may restart briefly when applying NAT changes.*

## Verify NAT rules

To test that NAT rules are working:

1. Wait 1-2 minutes for the device to apply the configuration
2. Attempt to connect to the service through the NAT rule
3. Use network tools like `ping` to test connectivity
4. Check device logs for NAT-related messages if connections fail

## Troubleshooting

**Rule exceeds maximum limit**
Smart EMS devices support a maximum of 3 NAT rules. To add a new rule:
- Delete an existing rule first
- Combine multiple rules if possible
- Use network-level routing for additional forwarding needs

**Traffic not forwarding**
Verify:
- Internal and external IP addresses are correct
- Network interfaces are configured and connected
- Firewall rules allow the traffic
- The destination service is running and reachable

**Connection timeout**
Check:
- The internal IP address is reachable from the device
- No firewall blocks the forwarded traffic
- The external port (LAN2) is open and listening
- Network routing allows traffic between interfaces

## Security considerations

NAT rules expose services to different networks. Consider:

- Only forward IP addresses for services that need to be accessible
- Use specific external IP addresses rather than allowing all traffic
- Regularly review and remove unused rules
- Combine NAT with firewall rules for security in depth
- Monitor forwarded traffic for suspicious activity

## Next steps

- [Configure LAN settings](./configure-lan.md) for interface IP configuration
- [Configure cellular settings](./configure-cellular.md) for mobile connectivity
