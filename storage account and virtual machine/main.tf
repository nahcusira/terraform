/*
terraform init
terraform plan -out main.tfplan
terraform apply
terraform destroy
terraform plan -out main.tfplan -var="number_of_subnets=3" -var="number_of_machine=3"
terraform apply main.tfplan
$env:TF_LOG="DEBUG"
$env:TF_LOG_PATH="C:\terraform\terraform.log"
terraform console
*/


# terraform {
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = "3.73.0"
#     }
#   }
# }

# provider "azurerm" {
#   # Configuration options
#   skip_provider_registration = "true"
#   subscription_id            = "1ed2ad0b-f27c-450a-b603-d1a5da681ba2"
#   tenant_id                  = "e51dbd98-1ac6-489a-a978-8715042011fe"
#   client_id                  = "70b47b18-eded-41ec-8d0a-de4490a4f8b6"
#   client_secret              = "tXI8Q~wvotWpEg_L1m3JRqKy5HYpkrkpz-TfDc5V"
#   features {

#   }
# }


# resource "azurerm_resource_group" "abc" {
#   name     = "abc"
#   location = "Japan East"
# }



# resource "azurerm_storage_account" "abcstore12305" {
#   name                     = "abcstore12305"
#   resource_group_name      = "abc"
#   location                 = "Japan East"
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
#   account_kind             = "StorageV2"
#   depends_on               = [azurerm_resource_group.abc]
# }



# resource "azurerm_storage_container" "data" {
#   name                  = "data"
#   storage_account_name  = "abcstore12305"
#   container_access_type = "blob"
#   depends_on            = [azurerm_storage_account.abcstore12305]
# }


# resource "azurerm_storage_blob" "maintf" {
#   name                   = "main2.tf"
#   storage_account_name   = "abcstore12305"
#   storage_container_name = "data"
#   type                   = "Block"
#   source                 = "main.tf"
#   depends_on             = [azurerm_storage_container.data]
# }


# locals {
#   resource_group_name = "abc"
#   location            = "Japan East"
#   virtual_network = {
#     name          = "abc-network"
#     address_space = "10.0.0.0/16"
#   }
#   subnet = [
#     {
#       name           = "subnetA"
#       address_prefix = "10.0.0.0/24"
#     },
#     {
#       name           = "subnetB"
#       address_prefix = "10.0.1.0/24"
#     }
#   ]
# }


# resource "azurerm_resource_group" "abc" {
#   name     = local.resource_group_name
#   location = local.location
# }

# resource "azurerm_virtual_network" "abcnetwork" {
#   name                = local.virtual_network.name
#   resource_group_name = local.resource_group_name
#   location            = local.location
#   address_space       = [local.virtual_network.address_space]

#   # subnet {
#   #   name           = local.subnet[0].name
#   #   address_prefix = local.subnet[0].address_prefix
#   # }

#   # subnet {
#   #   name           = local.subnet[1].name
#   #   address_prefix = local.subnet[1].address_prefix
#   # }
#   depends_on = [azurerm_resource_group.abc]
# }


# resource "azurerm_subnet" "subnetA" {
#   name                 = local.subnet[0].name
#   resource_group_name  = local.resource_group_name
#   virtual_network_name = local.virtual_network.name
#   address_prefixes     = [local.subnet[0].address_prefix]
#   depends_on           = [azurerm_virtual_network.abcnetwork]
# }


# resource "azurerm_subnet" "subnetB" {
#   name                 = local.subnet[1].name
#   resource_group_name  = local.resource_group_name
#   virtual_network_name = local.virtual_network.name
#   address_prefixes     = [local.subnet[1].address_prefix]
#   depends_on           = [azurerm_virtual_network.abcnetwork]
# }



# resource "azurerm_network_interface" "abcinterface" {
#   name                = "abcinterface"
#   location            = local.location
#   resource_group_name = local.resource_group_name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.subnetA.id
#     private_ip_address_allocation = "Dynamic"
#   }
#   depends_on = [azurerm_subnet.subnetA]
# }

# output "subnetA-id" {
#   value = azurerm_subnet.subnetA.id
# }


# resource "azurerm_network_interface" "abcinterface" {
#   name                = "abcinterface"
#   location            = local.location
#   resource_group_name = local.resource_group_name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = tolist(azurerm_virtual_network.abcnetwork.subnet)[0].id
#     private_ip_address_allocation = "Dynamic"
#   }
#   depends_on = [azurerm_virtual_network.abcnetwork]
# }

# output "subnets" {
#   value = azurerm_virtual_network.abcnetwork.subnet
# }



# resource "azurerm_network_interface" "abcinterface" {
#   name                = "abcinterface"
#   location            = local.location
#   resource_group_name = local.resource_group_name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.subnetA.id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.abcip.id
#   }
#   depends_on = [azurerm_subnet.subnetA]
# }


# resource "azurerm_public_ip" "abcip" {
#   name                = "abc-ip"
#   resource_group_name = local.resource_group_name
#   location            = local.location
#   allocation_method   = "Static"
#   depends_on          = [azurerm_resource_group.abc]
# }




# resource "azurerm_network_security_group" "abcnsg" {
#   name                = "abc-nsg"
#   location            = local.location
#   resource_group_name = local.resource_group_name

#   security_rule {
#     name                       = "AllowRDP"
#     priority                   = 300
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "3389"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }
#   depends_on = [azurerm_resource_group.abc]
# }


# resource "azurerm_network_security_group" "abcnsg" {
#   name                = "abc-nsg"
#   location            = local.location
#   resource_group_name = local.resource_group_name

#   security_rule {
#     name                       = "AllowSSh"
#     priority                   = 300
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "22"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }
#   depends_on = [azurerm_resource_group.abc]
# }



# resource "azurerm_subnet_network_security_group_association" "abcnsglink" {
#   subnet_id                 = azurerm_subnet.subnetA.id
#   network_security_group_id = azurerm_network_security_group.abcnsg.id
# }




# resource "azurerm_windows_virtual_machine" "abcvm" {
#   name                = "abc-vm"
#   resource_group_name = local.resource_group_name
#   location            = local.location
#   size                = "Standard_Ds1_v2"
#   admin_username      = "adminiap"
#   admin_password      = "Adminiap@123"
#   network_interface_ids = [
#     azurerm_network_interface.abcinterface.id,
#     azurerm_network_interface.secondaryinterface.id
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
#   depends_on = [azurerm_network_interface.abcinterface, azurerm_resource_group.abc, azurerm_network_interface.secondaryinterface]
# }





# resource "azurerm_network_interface" "secondaryinterface" {
#   name                = "secondaryinterface"
#   location            = local.location
#   resource_group_name = local.resource_group_name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.subnetA.id
#     private_ip_address_allocation = "Dynamic"
#   }
#   depends_on = [
#     azurerm_subnet.subnetA, azurerm_resource_group.abc
#   ]
# }




# resource "azurerm_managed_disk" "abcdisk" {
#   name                 = "abcdisk"
#   location             = local.location
#   resource_group_name  = local.resource_group_name
#   storage_account_type = "Standard_LRS"
#   create_option        = "Empty"
#   disk_size_gb         = "16"
#   depends_on           = [azurerm_resource_group.abc]
# }

# resource "azurerm_virtual_machine_data_disk_attachment" "abcdisk_attachment" {
#   managed_disk_id    = azurerm_managed_disk.abcdisk.id
#   virtual_machine_id = azurerm_windows_virtual_machine.abcvm.id
#   lun                = "0"
#   caching            = "ReadWrite"
#   depends_on         = [azurerm_windows_virtual_machine.abcvm, azurerm_managed_disk.abcdisk, azurerm_resource_group.abc]
# }



# resource "tls_private_key" "linuxkey" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }


# resource "local_file" "linuxpemkey" {
#   filename   = "linuxkey.pem"
#   content    = tls_private_key.linuxkey.private_key_pem
#   depends_on = [tls_private_key.linuxkey]
# }


# resource "azurerm_linux_virtual_machine" "abclinuxvm" {
#   name                = "abc-linux-vm"
#   resource_group_name = local.resource_group_name
#   location            = local.location
#   size                = "Standard_Ds1_v2"
#   admin_username      = "adminiap"
#   network_interface_ids = [
#     azurerm_network_interface.abcinterface.id,
#   ]

#   admin_ssh_key {
#     username   = "adminiap"
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



# resource "azurerm_linux_virtual_machine" "abclinuxvm" {
#   name                = "abc-linux-vm"
#   resource_group_name = local.resource_group_name
#   location            = local.location
#   size                = "Standard_F2"
#   admin_username      = "adminiap"
#   network_interface_ids = [
#     azurerm_network_interface.example.id,
#   ]

#   admin_ssh_key {
#     username   = "adminuser"
#     public_key = file("~/.ssh/id_rsa.pub")
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
# }



resource "azurerm_resource_group" "abc" {
  name     = local.resource_group_name
  location = local.location
}

# resource "azurerm_storage_account" "abcstore566565637" {
#   count                    = 3
#   name                     = "${count.index}abcstore566565637"
#   resource_group_name      = local.resource_group_name
#   location                 = local.location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
#   account_kind             = "StorageV2"
#   depends_on = [
#     azurerm_resource_group.abcgrp
#   ]
# }

# resource "azurerm_storage_account" "abcstore566565637" {
#   name                     = "abcstore566565637"
#   resource_group_name      = local.resource_group_name
#   location                 = local.location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
#   account_kind             = "StorageV2"
#   depends_on = [
#     azurerm_resource_group.abcgrp
#   ]
# }

# resource "azurerm_storage_container" "data" {
#   count                 = 3
#   name                  = "data${count.index}"
#   storage_account_name  = "abcstore566565637"
#   container_access_type = "blob"
#   depends_on = [
#     azurerm_storage_account.abcstore566565637
#   ]
# }

# resource "azurerm_storage_container" "data" {
#   for_each              = toset(["data", "files", "documents"])
#   name                  = each.key
#   storage_account_name  = "abcstore566565637"
#   container_access_type = "blob"
#   depends_on = [
#     azurerm_storage_account.abcstore566565637
#   ]
# }

# resource "azurerm_storage_blob" "files" {
#   for_each = {
#     sample2="sample1.txt"
#     sample3="sample2.txt"
#     sample4="sample3.txt"
#   }
#   name                   = "${each.key}.txt"
#   storage_account_name   = "abcstore566565637"
#   storage_container_name = "data"
#   type                   = "Block"
#   source                 = each.value
#   depends_on = [
#     azurerm_storage_account.abcstore566565637
#   ]
# }




resource "random_uuid" "storageaccountidentifier" {

}

# output "randomid" {
#   value = substr(random_uuid.storageaccountidentifier.result, 0, 8)
# }


