#---------------------------------------------------------------
# Generates SSH2 key Pair for Linux VM's (Dev Environment only)
#---------------------------------------------------------------
variable "prefix" {
  default = "tfvmex"
}
resource "azurerm_resource_group" "main" {
  name     = "resources_1"
  location = "West Europe"
}


resource "azurerm_network_interface" "ansible" {
  name                = "ansible"
  location            = "West Europe"
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "ansible"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Static"
    public_ip_address_id          = azurerm_public_ip.main.id
    private_ip_address = "10.0.1.7"
  }
}
resource "azurerm_network_interface" "jenkins" {
  name                = "jenkins"
  location            = "West Europe"
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "jenkins"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Static"
    public_ip_address_id          = azurerm_public_ip.main.id
    private_ip_address = "10.0.1.5"
  }
}
resource "azurerm_network_interface" "docker" {
  name                = "docker"
  location            = "West Europe"
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "docker"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Static"
    public_ip_address_id          = azurerm_public_ip.main.id
    private_ip_address = "10.0.1.6"
  }
}


resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "main" {
    name                         = "myPublicIP"
    location                     = "West Europe"
    resource_group_name          = azurerm_resource_group.main.name
    allocation_method            = "Dynamic"

    tags = {
        environment = "Terraform Demo"
    }
}

data  "azurerm_public_ip"  "ansible" {
  name                 =  "${azurerm_public_ip.main.name}" 
  resource_group_name  =  "${azurerm_linux_virtual_machine.ansible.resource_group_name}"
}


data  "azurerm_public_ip"  "docker" {
  name                 =  "${azurerm_public_ip.main.name}" 
  resource_group_name  =  "${azurerm_linux_virtual_machine.docker.resource_group_name}"
}





  
    
