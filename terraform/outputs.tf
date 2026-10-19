# Values below map 1:1 onto the Azure variables in .env.example.
# scripts/gen-env.py reads them via `terraform output -json`.

# Note: the platform expects the *host name*, not the bare IoT Hub name.
output "iot_hub_name" {
  description = "IoT Hub host name -> IOT_HUB_NAME (e.g. my-hub.azure-devices.net)"
  value       = azurerm_iothub.this.hostname
}

output "public_storage_account_name" {
  description = "Device-facing storage account -> PUBLIC_STORAGE_ACCOUNT_NAME"
  value       = azurerm_storage_account.public.name
}

output "internal_storage_account_name" {
  description = "Platform-internal storage account -> INTERNAL_STORAGE_ACCOUNT_NAME"
  value       = local.internal_account_name
}

# The provider prefixes the SAS with '?'; the platform wants the bare token,
# matching `az storage container generate-sas -o tsv`.
output "blob_sas_token_platform_config" {
  description = "SAS for the platform-config container -> BLOB_SAS_TOKEN_PLATFORM_CONFIG"
  value       = trimprefix(data.azurerm_storage_account_blob_container_sas.platform_config.sas, "?")
  sensitive   = true
}

output "blob_sas_token_module_conf" {
  description = "SAS for the iotedge-device-twin container -> BLOB_SAS_TOKEN_MODULE_CONF"
  value       = trimprefix(data.azurerm_storage_account_blob_container_sas.module_conf.sas, "?")
  sensitive   = true
}

# Consumed by scripts/gen-env.py to compute SAS_TOKEN.
output "iot_policy_name" {
  description = "Shared access policy name used to sign the IoT Hub SAS token"
  value       = azurerm_iothub_shared_access_policy.platform.name
}

output "iot_policy_primary_key" {
  description = "Shared access policy primary key used to sign the IoT Hub SAS token"
  value       = azurerm_iothub_shared_access_policy.platform.primary_key
  sensitive   = true
}

output "sas_expiry" {
  description = "Expiry of the generated blob SAS tokens"
  value       = time_rotating.sas.rotation_rfc3339
}
