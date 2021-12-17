resource "azurerm_network_interface" "nic1" {
  name                = "${var.hostname}-nic1"
  location            = var.region
  resource_group_name = data.azurerm_resource_group.mcds_test.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.mcds_subnet.id
    private_ip_address_allocation = "dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "MCDS_VM" {
  name                = var.hostname
  resource_group_name = data.azurerm_resource_group.mcds_test.name
  location            = var.region
  size                = var.size
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.nic1.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = "latest"
  }
}
