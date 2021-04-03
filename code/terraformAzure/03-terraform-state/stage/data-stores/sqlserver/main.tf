terraform {
  required_version = ">= 0.14"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
  backend "azurerm" {
    resource_group_name = "terraform_state"
    storage_account_name = "terrademoalk"
    container_name = "state"
    key = "sqlserver.tstate"
    # To guarantee access to state you can omit any form of authentication (your account should have access to the storage)
    # or you can specify acess_key in this property. BUT II IS A PRACTICE THAT IS NOT GOOD BECAUSE YOU RISK
    # TO INCLUDE IT IN SOME COMMIT AND GIVE TO EVERYONE ACCESS TO THE RESOURCE WITH TERRAFORM STATE.
    access_key = "OK6GAx4fM5bJmW3yjAXlUcaMNh1xCeQJmhzPUHq1092vR29AMBxkP2N+i0neJPjc86oW8384z2QFdGUSiDmrhQ=="

    # Or you can use ARM_ACCESS_KEY variable
    # export ARM_ACCESS_KEY=$(az keyvault secret show --name terraform-backend-key --vault-name myKeyVault --query value -o tsv)
    # instruction here https://docs.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage
  }
}

provider "azurerm" {
  features {}
}

# Create a resource group if it doesn't exist
resource "azurerm_resource_group" "myterraformgroup" {
    name     = var.resource_group_name # Variables from the user
    location = var.resource_location

    tags = {
        environment = "Terraform Demo"
    }
}

resource "random_string" "random_storage_name" {
  length           = 16
  special          = false
  min_lower        = 16 
}

resource "azurerm_storage_account" "demosql" {
  name                     = random_string.random_storage_name.result 
  resource_group_name      = azurerm_resource_group.myterraformgroup.name
  location                 = var.resource_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "random_string" "random_db_suffix" {
  length           = 6
  special          = false
  min_lower        = 6 
}

resource "azurerm_sql_server" "example" {
  # Name should be unique, so we need to simply add a suffix string to avoid name clashing.
  name                         = "demosql${random_string.random_db_suffix.result}"
  resource_group_name          = azurerm_resource_group.myterraformgroup.name
  location                     = var.resource_location
  version                      = "12.0"
  administrator_login          = "mradministrator"
  administrator_login_password = "thisIsDog11"

  extended_auditing_policy {
    storage_endpoint                        = azurerm_storage_account.demosql.primary_blob_endpoint
    storage_account_access_key              = azurerm_storage_account.demosql.primary_access_key
    storage_account_access_key_is_secondary = true
    retention_in_days                       = 6
  }

  tags = {
    environment = "demo terraform"
  }
}

