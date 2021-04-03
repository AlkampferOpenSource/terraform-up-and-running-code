terraform {
  required_version = ">= 0.14"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
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

resource "azurerm_storage_account" "terraformstorage" {
  name                     = var.storage_name
  resource_group_name      = azurerm_resource_group.myterraformgroup.name
  location                 = var.resource_location
  account_tier             = "standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "example" {
  name                  = "state"
  storage_account_name  = azurerm_storage_account.terraformstorage.name
  container_access_type = "private"
}

