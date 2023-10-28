# resource "azurerm_network_interface" "appinterface" {
#   count               = var.number_of_machines
#   name                = "appinterface${count.index}"
#   location            = local.location
#   resource_group_name = local.resource_group_name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.subnetA.id
#     private_ip_address_allocation = "Dynamic"
#   }

#   depends_on = [
#     azurerm_virtual_network.appnetwork
#   ]
# }


# resource "azurerm_windows_virtual_machine" "appvm" {
#   count               = var.number_of_machines
#   name                = "appvm${count.index}"
#   resource_group_name = local.resource_group_name
#   location            = local.location
#   size                = "Standard_D2s_v3"
#   admin_username      = "adminuser"
#   admin_password      = "Azure@123"
#   availability_set_id = azurerm_availability_set.appset.id
#   network_interface_ids = [
#     azurerm_network_interface.appinterface[count.index].id,
#   ]

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "MicrosoftWindowsServer"
#     offer     = "WindowsServer"
#     sku       = "2019-Datacenter"
#     version   = "latest"
#   }
#   depends_on = [
#     azurerm_virtual_network.appnetwork,
#     azurerm_network_interface.appinterface,
#     azurerm_availability_set.appset
#   ]
# }



# resource "azurerm_network_interface" "interface" {
#   for_each            = local.environment
#   name                = "${each.key}-interface"
#   location            = local.location
#   resource_group_name = local.resource_group_name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_virtual_network.network[each.key].subnet.*.id[0]
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.ip[each.key].id
#   }

#   depends_on = [
#     azurerm_virtual_network.network
#   ]
# }

# resource "azurerm_public_ip" "ip" {
#   for_each            = local.environment
#   name                = "${each.key}-ip"
#   resource_group_name = local.resource_group_name
#   location            = local.location
#   allocation_method   = "Dynamic"
#   depends_on = [
#     azurerm_resource_group.appgrp
#   ]
# }


# resource "azurerm_windows_virtual_machine" "vm" {
#   for_each            = local.environment
#   name                = "${each.key}vm"
#   resource_group_name = local.resource_group_name
#   location            = local.location
#   size                = "Standard_D2s_v3"
#   admin_username      = "adminuser"
#   admin_password      = "Azure@123"
#   network_interface_ids = [
#     azurerm_network_interface.interface[each.key].id,
#   ]

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "MicrosoftWindowsServer"
#     offer     = "WindowsServer"
#     sku       = "2019-Datacenter"
#     version   = "latest"
#   }
#   depends_on = [
#     azurerm_virtual_network.network,
#     azurerm_network_interface.interface
#   ]
# }




# resource "azurerm_network_interface" "interface" {
#   for_each            = toset(local.function)
#   name                = "${each.key}-interface"
#   location            = local.location
#   resource_group_name = local.resource_group_name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.subnetA.id
#     private_ip_address_allocation = "Dynamic"
#   }

#   depends_on = [
#     azurerm_virtual_network.appnetwork
#   ]
# }


# resource "azurerm_windows_virtual_machine" "vm" {
#   for_each            = toset(local.function)
#   name                = "${each.key}vm"
#   resource_group_name = local.resource_group_name
#   location            = local.location
#   size                = "Standard_D2s_v3"
#   admin_username      = "adminuser"
#   admin_password      = "Azure@123"
#   network_interface_ids = [
#     azurerm_network_interface.interface[each.key].id,
#   ]

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "MicrosoftWindowsServer"
#     offer     = "WindowsServer"
#     sku       = "2019-Datacenter"
#     version   = "latest"
#   }
#   depends_on = [
#     azurerm_virtual_network.appnetwork,
#     azurerm_network_interface.interface
#   ]
# }




resource "azurerm_network_interface" "appinterface" {
  name                = "app-interface"
  location            = local.location
  resource_group_name = local.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnetA.id
    private_ip_address_allocation = "Dynamic"
  }

  depends_on = [
    azurerm_virtual_network.appnetwork
  ]
}


resource "azurerm_windows_virtual_machine" "appvm" {
  name                = "appvm"
  resource_group_name = local.resource_group_name
  location            = local.location
  size                = "Standard_D2s_v3"
  admin_username      = "adminuser"
  admin_password      = "Azure@123"
  network_interface_ids = [
    azurerm_resource_group.appgrp,
    azurerm_network_interface.appinterface.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
  depends_on = [
    azurerm_virtual_network.appnetwork,
    azurerm_network_interface.appinterface
  ]
}
