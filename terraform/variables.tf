variable "subscription_id" {
  description = "Azure subscription to deploy into. Falls back to ARM_SUBSCRIPTION_ID / the az CLI context when null."
  type        = string
  default     = null
}

variable "resource_group_name" {
  description = "Name of the resource group holding the SEALMAN prerequisites."
  type        = string
  default     = "rg-sealman"
}

variable "location" {
  description = "Azure region for all resources."
  type        = string
  default     = "westeurope"
}

variable "name_prefix" {
  description = "Prefix for generated resource names. Non-alphanumerics are stripped for storage account names."
  type        = string
  default     = "sealman"

  validation {
    condition     = can(regex("^[a-zA-Z0-9-]{2,16}$", var.name_prefix))
    error_message = "name_prefix must be 2-16 characters of letters, digits or hyphens."
  }
}

variable "iothub_sku" {
  description = "IoT Hub SKU. The platform requires a Standard tier (S1/S2/S3); F1 is free but limited to one per subscription."
  type        = string
  default     = "S1"

  validation {
    condition     = contains(["F1", "S1", "S2", "S3"], var.iothub_sku)
    error_message = "iothub_sku must be one of F1, S1, S2, S3."
  }
}

variable "iothub_capacity" {
  description = "Number of IoT Hub units."
  type        = number
  default     = 1
}

variable "use_single_storage_account" {
  description = "Put both containers in one storage account instead of separate public/internal accounts. Cheaper for local development; loses the device-facing/platform-internal separation."
  type        = bool
  default     = false
}

variable "sas_validity_days" {
  description = "Lifetime of the generated blob container SAS tokens. Terraform regenerates them on the next apply after this period elapses."
  type        = number
  default     = 90

  validation {
    condition     = var.sas_validity_days > 0 && var.sas_validity_days <= 365
    error_message = "sas_validity_days must be between 1 and 365."
  }
}

variable "tags" {
  description = "Tags applied to every resource."
  type        = map(string)
  default = {
    project   = "sealman"
    managedBy = "terraform"
  }
}
