# Sealman-IIoT-Platform

This repository enables easily running all the Sealman projects, specially useful for local development.

## Cloud Prerequisites 

- Azure IoTHub (Standard Tier) (further details in [docs/prerequisites/iot-hub.md](./docs/prerequisites/iot-hub.md))
- Azure Blob Storage with certain containers/files initially uploaded (further details in [docs/prerequisites/storage-account.md](./docs/prerequisites/storage-account.md))

Both can be provisioned automatically with Terraform, which also generates the required SAS tokens: see [terraform/README.md](./terraform/README.md).

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
├── terraform/                      # Provisions the Azure prerequisites (IoT Hub, Blob Storage)
│   └── scripts/gen-env.py          # Renders the Azure env. variables from Terraform outputs
├── docs/                           # Platform Documentation
```

## Getting Started

If you have the [Cloud Prerequisites](#cloud-prerequisites) in place, you're ready to run the platform. For that, follow the instructions on [docs/getting-started.md](./docs/getting-started.md).