# resource "azurerm_network_interface" "abcinterface" {
#   count               = var.number_of_machine
#   name                = "abcinterface${count.index}"
#   location            = local.location
#   resource_group_name = local.resource_group_name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.subnets[count.index].id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.abcip[count.index].id
#   }
#   depends_on = [azurerm_subnet.subnets, azurerm_public_ip.abcip]
# }

# resource "azurerm_public_ip" "abcip" {
#   count               = var.number_of_machine
#   name                = "abc-ip${count.index}"
#   resource_group_name = local.resource_group_name
#   location            = local.location
#   allocation_method   = "Static"
#   depends_on          = [azurerm_resource_group.abc]
# }




/*


WINDOWS


*/




# resource "azurerm_windows_virtual_machine" "abcvm" {
#   count               = var.number_of_machine
#   name                = "abc-windows-vm${count.index}"
#   resource_group_name = "new-grp"
#   location            = local.location
#   size                = "Standard_Ds1_v2"
#   admin_username      = "adminiap"
#   admin_password      = "Adminiap@123"
# #   availability_set_id = azurerm_availability_set.abcset.id
#   network_interface_ids = [
#     azurerm_network_interface.abcinterface[count.index].id,
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
#   depends_on = [azurerm_network_interface.abcinterface, azurerm_resource_group.abc]
# }

# resource "azurerm_public_ip" "abcip" {
#   count               = var.number_of_machine
#   name                = "abc-ip${count.index}"
#   resource_group_name = local.resource_group_name
#   location            = local.location
#   allocation_method   = "Static"
#   #   zones              = ["${count.index + 1}"]
#   depends_on = [azurerm_resource_group.abc]
# }

# resource "azurerm_windows_virtual_machine" "abcvm" {
#   count               = var.number_of_machine
#   name                = "abc-windows-vm${count.index}"
#   resource_group_name = local.resource_group_name
#   location            = local.location
#   size                = "Standard_Ds1_v2"
#   admin_username      = "adminiap"
#   admin_password      = azurerm_key_vault_secret.vmpassword.value
# #   zone                = (count.index + 1)
#   network_interface_ids = [
#     azurerm_network_interface.abcinterface[count.index].id,
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
#   depends_on = [azurerm_network_interface.abcinterface, azurerm_resource_group.abc]
# }



# data "azurerm_key_vault" "abckeyvault152141212" {
#   name                = "abckeyvault152141212"
#   resource_group_name = "new-grp"
# }

# data "azurerm_key_vault_secret" "vmpassword" {
#   name         = "vmpassword"
#   key_vault_id = data.azurerm_key_vault.abckeyvault152141212.id
# }


# data "azurerm_key_vault" "abckeyvault" {
#   name                 = join("",[lower("${var.key_vault_name}"),substr(random_uuid.storageaccountidentifier.result,25,8)])
#   resource_group_name = "new-grp"
#   depends_on = [
#     random_uuid.storageaccountidentifier
#   ]
# }

# data "azurerm_key_vault_secret" "vmpassword" {
#   name         = "vmpassword"
#   key_vault_id = data.azurerm_key_vault.abckeyvault.id
#   depends_on = [ data.azurerm_key_vault.abckeyvault ]
# }


# resource "azurerm_windows_virtual_machine" "abcvm" {
#   count               = var.number_of_machine
#   name                = "abc-windows-vm${count.index}"
#   resource_group_name = local.resource_group_name
#   location            = local.location
#   size                = "Standard_D2s_v3"
#   admin_username      = "adminuser123"
#   admin_password      = data.azurerm_key_vault_secret.vmpassword.value
#   #   zone                = (count.index + 1)
#   network_interface_ids = [
#     azurerm_network_interface.abcinterface[count.index].id,
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
#   depends_on = [azurerm_network_interface.abcinterface, azurerm_resource_group.abc]
# }






/*


LINUX




*/


# resource "tls_private_key" "linuxkey" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }


# resource "local_file" "linuxpemkey" {
#   filename   = "linuxkey.pem"
#   content    = tls_private_key.linuxkey.private_key_pem
#   depends_on = [tls_private_key.linuxkey]
# }


# data "template_file" "cloudinitdata" {
#   template = file("script.sh")
# }

# resource "azurerm_linux_virtual_machine" "abclinuxvm" {
#   count               = var.number_of_machine
#   name                = "abc-linux-vm${count.index}"
#   resource_group_name = local.resource_group_name
#   location            = local.location
#   size                = "Standard_Ds1_v2"
#   admin_username      = "adminiaplinux"
#   custom_data         = base64encode(data.template_file.cloudinitdata.rendered)
#   network_interface_ids = [
#     azurerm_network_interface.abcinterface[count.index].id,
#   ]

#   admin_ssh_key {
#     username   = "adminiaplinux"
#     public_key = tls_private_key.linuxkey.public_key_openssh
#   }

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-focal"
#     sku       = "20_04-lts"
#     version   = "latest"
#   }
#   depends_on = [azurerm_network_interface.abcinterface, azurerm_resource_group.abc, tls_private_key.linuxkey]
# }

