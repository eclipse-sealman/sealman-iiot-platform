# IoT Hub Prerequisites

## Platform Connectivity Bootstrap

Before starting the compose stack, an Azure IoT Hub instance must exist and provide a SAS token for service access.

### Prerequisites

- Environment variable `IOT_HUB_NAME` must be set with the IoT Hub host name (for example `my-hub.azure-devices.net`)
- Environment variable `SAS_TOKEN` must be set with a valid IoT Hub SAS token (format: `SharedAccessSignature sr=...&sig=...&se=...`)

### Manual Setup

1. Create an Azure IoT Hub (Standard tier)

You can create the IoT Hub in the Azure Portal:

- Search for `IoT Hub` and select **Create**
- Choose Subscription and Resource Group
- Set an IoT Hub name
- Select a supported region
- Select a Standard pricing tier (for example `S1`)
- Review and create

CLI alternative:

```shell
az extension add --name azure-iot --upgrade

az iot hub create \
	--name <your-iot-hub-name> \
	--resource-group <your-resource-group> \
	--sku S1
```

2. Get the IoT Hub host name for `IOT_HUB_NAME`

Open your IoT Hub and copy the host name from **Overview**.

CLI alternative:

```shell
az iot hub show \
	--name <your-iot-hub-name> \
	--query properties.hostName \
	--output tsv
```

Example value:

```text
my-hub.azure-devices.net
```

3. Create or use a shared access policy

In your IoT Hub:

- Open **Shared access policies**
- Use an existing policy with required permissions or create a new one
- For broad backend access, `iothubowner` is typically used

CLI alternative:

```shell
az iot hub policy create \
	--hub-name <your-iot-hub-name> \
	--name <your-policy-name> \
	--permissions RegistryRead RegistryWrite ServiceConnect DeviceConnect
```

4. Generate a SAS token

You can generate a SAS token with Azure CLI. Replace placeholders with your values.

```shell
az iot hub generate-sas-token \
	--hub-name <your-iot-hub-name> \
	--policy-name <your-policy-name> \
	--duration 3600
```

The command returns a token like:

```text
SharedAccessSignature sr=my-hub.azure-devices.net&sig=<signature>&se=<expiry>
```

Use this value for `SAS_TOKEN`.

## Note

- SAS tokens expire. If authentication starts failing, generate a new token and update the `.env` file.
- Use least-privilege policies where possible for non-development environments.
- On first execution of EC Backend, a deployment named `seal-base-deployment` will be created in IotHub and applied to all newly created devices.
