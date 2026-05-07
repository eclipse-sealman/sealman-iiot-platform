# Storage Account Prerequisites

The platform depends on two Azure Storage Accounts, that must be manually setup in advance:

- `PUBLIC_STORAGE_ACCOUNT_NAME`: public storage used for device module twin configuration sharing. This storage account must be reachable by the device over the network.
- `INTERNAL_STORAGE_ACCOUNT_NAME`: internal storage used only by the platform for management of application and platform settings. It is not device-facing.

Both variables can however point at the same storage account.

- Environment variable `PUBLIC_STORAGE_ACCOUNT_NAME` must be set with the name of the public Azure Storage Account used for device module twin configuration sharing (no suffix like `.blob.core.windows.net`).
- Environment variable `INTERNAL_STORAGE_ACCOUNT_NAME` must be set with the name of the Azure Storage Account (no suffix like `.blob.core.windows.net`)
- Environment variable `BLOB_SAS_TOKEN_PLATFORM_CONFIG` must be set with a SAS token that has read and write permissions to the container `platform-config` in the internal storage account.
- Environment variable `BLOB_SAS_TOKEN_MODULE_CONF` must be set with a SAS token that has read and write permissions to the container `iotedge-device-twin` in the public storage account.

## Manual Setup

### Internal Storage Account Setup
Container: `platform-config` \
Blobs required in that container:
  - `services.json` and `endpoint-types.json` with initial content:

```json
[]
```

- `templates.json` with initial content:

```json
{
  "selected": []
}
```

If these blobs are missing, platform configuration endpoints will fail when reading initial values.

> Note: in the future, this data is planned to be moved from Blob Storage to PostgreSQL.

### Public Storage Account Setup

Container `iotedge-device-twin` must be initially created. No files need to be uploaded to it.

### SAS Token Generation

Generate one SAS token per container and copy only the token value into the corresponding environment variable, not the full blob URL.

Use at least these permissions for both containers:

- `Read`
- `Write`
- `List`
- `Create`

Use a limited expiry time and HTTPS-only access.

### Option 1: Azure Portal

For each storage account, open the target container and generate a SAS token:

1. Open the Azure Portal.
2. Go to the storage account.
3. Open `Data storage` -> `Containers`.
4. Select the container:
   - `platform-config` in the storage account from `INTERNAL_STORAGE_ACCOUNT_NAME`
   - `iotedge-device-twin` in the storage account from `PUBLIC_STORAGE_ACCOUNT_NAME`
5. Open `Generate SAS`.
6. Enable these permissions: `Read`, `Write`, `List`, `Create`.
7. Set a suitable start and expiry time.
8. Require `HTTPS only`.
9. Generate the SAS token.
10. Copy only the SAS token value and set:

- `BLOB_SAS_TOKEN_PLATFORM_CONFIG` for `platform-config`
- `BLOB_SAS_TOKEN_MODULE_CONF` for `iotedge-device-twin`

### Option 2: Azure CLI

If you already know the storage account keys, generate the SAS tokens directly:

```shell
az storage container generate-sas \
  --account-name <storage-account-name> \
  --name <container-name> \
  --permissions rlwc \
  --expiry 2026-12-31T23:59:00Z \
  --https-only \
  --account-key <storage-account-key> \
  --output tsv
```

If you do not know the storage account keys yet, retrieve them first:

```shell
az storage account keys list \
  --resource-group <resource-group> \
  --account-name <storage-account-name> \
  --query "[0].value" \
  --output tsv
```

Set the generated values as follows:

- SAS token for `platform-config` -> `BLOB_SAS_TOKEN_PLATFORM_CONFIG`
- SAS token for `iotedge-device-twin` -> `BLOB_SAS_TOKEN_MODULE_CONF`