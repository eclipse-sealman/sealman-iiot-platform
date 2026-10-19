provider "azurerm" {
  features {}

  # azurerm v4 requires an explicit subscription. Leave the variable unset to
  # fall back to the ARM_SUBSCRIPTION_ID environment variable or the account
  # currently selected with `az account set`.
  subscription_id = var.subscription_id
}
