# Sealman-IIoT-Platform

This repository enables easily running all the Sealman projects, especially useful for local development.

## Cloud Prerequisites 

- Azure IoTHub (Standard Tier) (further details in [docs/iot_hub.md](./docs/iot_hub.md))
- Azure Blob Storage with certain containers/files initially uploaded (further details in [docs/storage_account.md](./docs/storage_account.md))

## Folder Structure

```bash
sealman-compose/
├── docker-compose.yml              # Main compose file for running application
├── docker-compose-letsencrypt.yml  # Letsencrypt configuration for deployment
├── .env.example                    # Service env. variables
├── keycloak/
│   ├── docker-compose.yaml         # Compose file to run only Keycloak
│   ├── realm-export.json           # Keycloak realm configuration
│   └── export_realm.ps1            # Script to export realm from an instance running in a container
```

## Setup Steps

Make an ``.env`` file as copy of the ``.env.example`` file: 
```shell
cp .env.example .env
```

Provide the following ENV vars from your previous deployed Azure IoTHub and Azure Blob Storage in the new generated .env file:

```ini
# your IoT Hub name, example: iothub.azure-devices.net
IOT_HUB_NAME=''
# your IoTHub SAS token, example: SharedAccessSignature sr=iothub.azure-devices.net&sig=...
SAS_TOKEN='' 
# your public blob storage account name (without suffix ".blob.core.windows.net")
PUBLIC_STORAGE_ACCOUNT_NAME='' 
# your internal blob storage account name (without suffix ".blob.core.windows.net")
INTERNAL_STORAGE_ACCOUNT_NAME=''
# your SAS token with permissions to write to blob storage for platform settings configuration
BLOB_SAS_TOKEN_PLATFORM_CONFIG=''
# your SAS token with permissions to write to blob storage for module configuration
BLOB_SAS_TOKEN_MODULE_CONF='' 
```

### Pull Images

```shell
docker compose pull
```

### Start Services

```shell
docker compose up --pull always
```

> **Note** Pull always argument is important for the images that use :latest version tag.

This will pull the latest images and start:

- [Keycloak](https://keycloak.localhost): Identity and access management
- [EC Backend](https://api.localhost/docs): Edge configuration API
- [EC Frontend](https://app.localhost): Edge configuration UI
- [sealman-ems](https://sems.localhost): sealman-ems

It takes some time for services to start. Keycloak will start first and other services wait until the realm has been imported to start.

> **Note**: Services are served over HTTPS using Traefik's self-signed certificate. When opening each link for the first time, your browser will show a security warning. You must open each URL individually and accept/confirm the security exception before the services become accessible. You can use links above and open each in the browser. \
You must access Keycloak and EC Backend and accept the security exception for the first time before you can see the Devices in EC Frontend.

### 4. Access Services

To login in the services you can use the following user accounts created in the realm export in Keycloak:

| Username      | Password    | Role          |
| --------------| ----------- | -----------   |
| `test`        | `test`      | `user.admin`  |
| `test2`       | `test2`     | `user.editor` |
| `test3`       | `test3`     | `user.viewer` |

### 5. Stop Services

```shell
docker compose down
```

### Data Persistence

Service data for postgres and SmartEMS database is stored in named Docker volumes, so removing containers does not remove the data.

- docker compose down
    - Removes containers and network, keeps volumes and database/application data.

- docker compose down -v
    - Removes containers, network, and volumes, which resets postgres and application-database data.

If you only want to remove the Postgres data volume:

- docker volume rm sealman-volume-postgres


### Check Running Image Version

If images are built with OCI labels, you can inspect the running container and read the stamped version metadata.

Example (full labels JSON):

```shell
docker inspect sealman-api --format '{{json .Config.Labels}}' | jq
```

Common labels to look for:

- `org.opencontainers.image.version`: application semantic version (for example `1.4.2`)
- `org.opencontainers.image.revision`: git commit SHA used in the build
