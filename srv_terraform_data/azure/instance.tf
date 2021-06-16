#---------------------------------------------------------------
# Run Ansible Server
#---------------------------------------------------------------
resource "azurerm_linux_virtual_machine" "ansible" {
  name                = "ansible"
  resource_group_name = "${azurerm_resource_group.main.name}"
  location            = "${azurerm_resource_group.main.location}"
  size                = "Standard_DS1_v2"
  admin_username      = "${var.instance_username}"
  network_interface_ids = [azurerm_network_interface.ansible.id]
 

  admin_ssh_key {
    username   = "${var.instance_username}"
    public_key = "${file("${var.public_key}")}"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  
  
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "20.04.202007080"
  }
}

#Send files to Server
resource  "null_resource"  "ansible_data" {
  connection {
    type        = "ssh"
    host        = "${data.azurerm_public_ip.ansible.ip_address}"
    user        = "${var.instance_username}"
    private_key = "${file("${var.private_key}")}"  
  }
  
# Send to Server folder with ansible scripts  for install
  provisioner "file" {
    source      = "../srv_ansible_data"
    destination = "/tmp/srv_ansible_data"
  }

# Send to Keys to connect to Docker and Jenkins
  provisioner "file" {
    source      = "${var.private_key_ans_ins}"
    destination = "/home/${var.instance_username}/.ssh/${var.private_key_ans_ins}"
  }
  
# Run commands for install ansible  
  provisioner "remote-exec" {
    inline      = [ "chmod 400 /home/${var.instance_username}/.ssh/${var.private_key_ans_ins}",
                    "chmod +x /tmp/srv_ansible_data/install_ansible.sh",
                    "sudo /tmp/srv_ansible_data/install_ansible.sh"                                  
                  ]
  }
}
#---------------------------------------------------------------
# Run Jenkins Server
#---------------------------------------------------------------
resource "azurerm_linux_virtual_machine" "jenkins" {
  name                = "jenkins"
  resource_group_name = "${azurerm_resource_group.main.name}"
  location            = "${azurerm_resource_group.main.location}"
  size                = "Standard_DS1_v2"
  admin_username      = "${var.instance_username}"
  network_interface_ids = [azurerm_network_interface.jenkins.id]
 

  admin_ssh_key {
    username   = "${var.instance_username}"
    public_key = "${file("${var.public_key_ans_ins}")}"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  
  
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "20.04.202007080"
  }
}

#---------------------------------------------------------------
# Run Docker Server
#---------------------------------------------------------------
resource "azurerm_linux_virtual_machine" "docker" {
  name                = "docker"
  resource_group_name = "${azurerm_resource_group.main.name}"
  location            = "${azurerm_resource_group.main.location}"
  size                = "Standard_DS1_v2"
  admin_username      = "${var.instance_username}"
  network_interface_ids = [azurerm_network_interface.docker.id]

  admin_ssh_key {
    username   = "${var.instance_username}"
    public_key = "${file("${var.public_key_ans_ins}")}"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  
  
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "20.04.202007080"
  }
}

resource  "null_resource"  "docker_data" {
    connection {
    type        = "ssh"
    host        = "${data.azurerm_public_ip.docker.ip_address}"
    user        = "${var.instance_username}"
    private_key = "${file("${var.private_key_ans_ins}")}"  
  }
  
# Send to Server docker script  
  provisioner "file" {
    source      = "../srv_docker_data"
    destination = "/tmp/srv_docker_data"
  }
}