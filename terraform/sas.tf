# SAS validity is anchored to a rotating timestamp rather than timestamp(), which
# would change on every plan and leave the SAS data sources permanently dirty.
# Terraform issues fresh tokens on the first apply after the rotation elapses.
resource "time_rotating" "sas" {
  rotation_days = var.sas_validity_days
}

# Permissions match docs/prerequisites/storage-account.md: Read, Write, List, Create.
data "azurerm_storage_account_blob_container_sas" "platform_config" {
  connection_string = local.internal_account_conn
  container_name    = azurerm_storage_container.platform_config.name
  https_only        = true

  start  = time_rotating.sas.rfc3339
  expiry = time_rotating.sas.rotation_rfc3339

  permissions {
    read   = true
    write  = true
    list   = true
    create = true
    add    = false
    delete = false
  }
}

data "azurerm_storage_account_blob_container_sas" "module_conf" {
  connection_string = azurerm_storage_account.public.primary_connection_string
  container_name    = azurerm_storage_container.module_conf.name
  https_only        = true

  start  = time_rotating.sas.rfc3339
  expiry = time_rotating.sas.rotation_rfc3339

  permissions {
    read   = true
    write  = true
    list   = true
    create = true
    add    = false
    delete = false
  }
}
