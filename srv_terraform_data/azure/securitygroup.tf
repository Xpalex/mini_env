resource "azurerm_network_security_group" "main" {
    name                = "NSG_In"
    location            = "West Europe"
    resource_group_name = azurerm_resource_group.main.name

    security_rule {
        name                       = "SSH_In"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = "Terraform Demo"
    }
}

resource "azurerm_firewall" "main" {
  name                = "azr_firewall"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                 = azurerm_subnet.internal.name
    subnet_id            = azurerm_subnet.internal.id
    public_ip_address_id = azurerm_public_ip.main.id
  }
}

resource "azurerm_firewall_nat_rule_collection" "main" {
  name                = "collection"
  azure_firewall_name = azurerm_firewall.main.name
  resource_group_name = azurerm_resource_group.main.name
  priority            = 100
  action              = "Dnat"

  rule {
    name = "rule"

    source_addresses = [
      "10.0.1.0/16",
    ]

    destination_ports = [
      "22",
    ]

    destination_addresses = [
      azurerm_public_ip.main.ip_address
    ]

    translated_port = 22

    translated_address = "8.8.8.8"

    protocols = [
      "TCP",
      "UDP",
    ]
  }
}