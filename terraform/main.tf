locals {
  # Storage account names are globally unique, 3-24 chars, lowercase alphanumeric only.
  # "st" + <=12 prefix chars + 3 role chars + 4 random = 21 max.
  sa_prefix = substr(replace(lower(var.name_prefix), "/[^a-z0-9]/", ""), 0, 12)

  public_storage_account_name   = "st${local.sa_prefix}pub${random_string.suffix.result}"
  internal_storage_account_name = "st${local.sa_prefix}int${random_string.suffix.result}"

  # When collapsed to a single account, the internal container lives in the
  # public account and both env vars point at the same name.
  # one() over a splat rather than [0]: yields null instead of erroring when the
  # internal account is absent, even if the toggle is unknown at plan time.
  internal_account_id   = var.use_single_storage_account ? azurerm_storage_account.public.id : one(azurerm_storage_account.internal[*].id)
  internal_account_name = var.use_single_storage_account ? azurerm_storage_account.public.name : one(azurerm_storage_account.internal[*].name)
  internal_account_conn = var.use_single_storage_account ? azurerm_storage_account.public.primary_connection_string : one(azurerm_storage_account.internal[*].primary_connection_string)

  # Initial contents required by the platform-config endpoints.
  # See docs/prerequisites/storage-account.md.
  platform_config_seed_blobs = {
    "services.json"       = "[]"
    "endpoint-types.json" = "[]"
    "templates.json"      = jsonencode({ selected = [] })
  }
}

resource "random_string" "suffix" {
  length  = 4
  lower   = true
  upper   = false
  numeric = true
  special = false
}

resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# --- IoT Hub -----------------------------------------------------------------

resource "azurerm_iothub" "this" {
  name                = "iot-${var.name_prefix}-${random_string.suffix.result}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  tags                = var.tags

  sku {
    name     = var.iothub_sku
    capacity = var.iothub_capacity
  }
}

# Permission set mirrors the manual instructions in docs/prerequisites/iot-hub.md.
# The primary key is what the IoT Hub SAS token is derived from; see
# scripts/gen-env.py, which Terraform cannot do itself (no HMAC-SHA256 function).
resource "azurerm_iothub_shared_access_policy" "platform" {
  name                = "${var.name_prefix}-platform"
  resource_group_name = azurerm_resource_group.this.name
  iothub_name         = azurerm_iothub.this.name

  registry_read   = true
  registry_write  = true
  service_connect = true
  device_connect  = true
}

# --- Storage -----------------------------------------------------------------

# Device-facing: holds module twin configuration shared with edge devices.
resource "azurerm_storage_account" "public" {
  name                = local.public_storage_account_name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  tags                = var.tags

  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  https_traffic_only_enabled = true
  # Access is granted via container SAS tokens, so anonymous access stays off.
  allow_nested_items_to_be_public = false
  # Required: the SAS tokens below are derived from the account key.
  shared_access_key_enabled = true
}

# Platform-internal: application and platform settings, not device-facing.
resource "azurerm_storage_account" "internal" {
  count = var.use_single_storage_account ? 0 : 1

  name                = local.internal_storage_account_name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  tags                = var.tags

  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  https_traffic_only_enabled      = true
  allow_nested_items_to_be_public = false
  shared_access_key_enabled       = true
}

# Container names are fixed by the application and must not be renamed.
resource "azurerm_storage_container" "module_conf" {
  name                  = "iotedge-device-twin"
  storage_account_id    = azurerm_storage_account.public.id
  container_access_type = "private"
}

resource "azurerm_storage_container" "platform_config" {
  name                  = "platform-config"
  storage_account_id    = local.internal_account_id
  container_access_type = "private"
}

# Without these blobs the platform configuration endpoints fail on first read.
# The platform rewrites them at runtime, so drift in their content is ignored.
resource "azurerm_storage_blob" "platform_config_seed" {
  for_each = local.platform_config_seed_blobs

  name                 = each.key
  storage_container_id = azurerm_storage_container.platform_config.id
  type                 = "Block"
  content_type         = "application/json"
  source_content       = each.value

  lifecycle {
    ignore_changes = [source_content]
  }
}
