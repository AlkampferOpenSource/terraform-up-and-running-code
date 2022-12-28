# https://learn.microsoft.com/en-gb/azure/developer/terraform/

terraform {
  required_version = ">= 1.3.6"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {

  features {}
}

variable "rg_name" {
  type = string
}

variable "keycloak_client_secret" {
  type = string
}

# Create a resource group if it doesn't exist
resource "azurerm_resource_group" "myterraformgroup" {
    name     = var.rg_name
    location = "westeurope"

    tags = {
        environment = "Terraform Demo"
    }
}

resource "azurerm_service_plan" "root" {
  name                = "root"
  resource_group_name = azurerm_resource_group.myterraformgroup.name
  location            = azurerm_resource_group.myterraformgroup.location
  os_type             = "Linux"
  sku_name            = "B2"
}

resource "azurerm_mssql_server" "db" {
  name                         = "picturestore"
  resource_group_name          = azurerm_resource_group.myterraformgroup.name
  location                     = azurerm_resource_group.myterraformgroup.location
  version                      = "12.0"
  administrator_login          = "alkampferadm"
  administrator_login_password = "This1s$myPwd_##"
  minimum_tls_version          = "1.2"

#   azuread_administrator {
#     login_username = "AzureAD Admin"
#     object_id      = "00000000-0000-0000-0000-000000000000"
#   }

  tags = {
    environment = "production"
  }
}

resource "azurerm_mssql_database" "picturestore" {
  name           = "picturestore"
  server_id      = azurerm_mssql_server.db.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  read_scale     = false
  sku_name       = "Basic"
  zone_redundant = false

}

resource "azurerm_linux_web_app" "picturestore" {
  name                = "picturestore"
  resource_group_name = azurerm_resource_group.myterraformgroup.name
  location            = azurerm_service_plan.root.location
  service_plan_id     = azurerm_service_plan.root.id
  connection_string   {
    name              = "PictureStore"
    type              = "SQLAzure"
    value             = "Server=tcp:${azurerm_mssql_server.db.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.picturestore.name};Persist Security Info=False;User ID=${azurerm_mssql_server.db.administrator_login};Password=${azurerm_mssql_server.db.administrator_login_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  }
  app_settings = {
    "KeyCloak__ClientId" = "picturestore",
    "KeyCloak__Authority" = "https://keycloakw.codewrecks.com/auth/realms/demo",
    "KeyCloak__ClientSecret" = var.keycloak_client_secret,
  }
  site_config {}
}
