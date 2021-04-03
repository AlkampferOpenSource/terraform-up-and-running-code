data "azurerm_public_ip" "myterraformpublicip" {
  name                = azurerm_public_ip.myterraformpublicip.name
  resource_group_name = azurerm_linux_virtual_machine.myterraformvm.resource_group_name
}

output "ip_address" { 
    value = data.azurerm_public_ip.myterraformpublicip
}