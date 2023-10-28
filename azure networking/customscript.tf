# # The storage account will be used to store the script for Custom Script extension

# resource "azurerm_storage_account" "vmstore748945" {
#   name                     = "vmstore748945"
#   resource_group_name      = "app-grp"
#   location                 = "North Europe"
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
#   account_kind             = "StorageV2"
#   depends_on = [
#     azurerm_resource_group.appgrp
#   ]
# }

# resource "azurerm_storage_container" "data" {
#   name                  = "data"
#   storage_account_name  = "vmstore748945"
#   container_access_type = "blob"
#   depends_on = [
#     azurerm_storage_account.vmstore748945
#   ]
# }

# resource "azurerm_storage_blob" "IISConfig" {
#   name                   = "IIS_Config.ps1"
#   storage_account_name   = "vmstore748945"
#   storage_container_name = "data"
#   type                   = "Block"
#   source                 = "IIS_Config.ps1"
#   depends_on = [azurerm_storage_container.data,
#   azurerm_storage_account.vmstore748945]
# }


# # resource "azurerm_virtual_machine_extension" "vmextension" {
# #   count                = var.number_of_machines
# #   name                 = "appvm-extension${count.index}"
# #   virtual_machine_id   = azurerm_windows_virtual_machine.appvm[count.index].id
# #   publisher            = "Microsoft.Compute"
# #   type                 = "CustomScriptExtension"
# #   type_handler_version = "1.10"
# #   depends_on = [
# #     azurerm_storage_blob.IISConfig
# #   ]
# #   settings = <<SETTINGS
# #     {
# #         "fileUris": ["https://${azurerm_storage_account.vmstore748945.name}.blob.core.windows.net/data/IIS_Config.ps1"],
# #           "commandToExecute": "powershell -ExecutionPolicy Unrestricted -file IIS_Config.ps1"     
# #     }
# # SETTINGS

# # }


# resource "azurerm_virtual_machine_scale_set_extension" "scalesetextension" {  
#   name                 = "scalesetextension"
#   virtual_machine_scale_set_id   = azurerm_windows_virtual_machine_scale_set.appset.id
#   publisher            = "Microsoft.Compute"
#   type                 = "CustomScriptExtension"
#   type_handler_version = "1.9"
#   depends_on = [
#     azurerm_storage_blob.IISConfig
#   ]
#   settings = <<SETTINGS
#     {
#         "fileUris": ["https://${azurerm_storage_account.vmstore748945.name}.blob.core.windows.net/data/IIS_Config.ps1"],
#           "commandToExecute": "powershell -ExecutionPolicy Unrestricted -file IIS_Config.ps1"     
#     }
# SETTINGS

# }



# resource "azurerm_storage_account" "vmstore748945" {
#   name                     = "vmstore748945"
#   resource_group_name      = "app-grp"
#   location                 = "North Europe"
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
#   account_kind = "StorageV2"  
#   depends_on = [
#     azurerm_resource_group.appgrp
#   ]
# }

# resource "azurerm_storage_container" "data" {
#   name                  = "data"
#   storage_account_name  = "vmstore748945"
#   container_access_type = "blob"
#   depends_on=[
#     azurerm_storage_account.vmstore748945
#     ]
# }

# resource "azurerm_storage_blob" "IISConfig" {
#   name                   = "IIS_Config.ps1"
#   storage_account_name   = "vmstore748945"
#   storage_container_name = "data"
#   type                   = "Block"
#   source                 = "IIS_Config.ps1"
#    depends_on=[azurerm_storage_container.data,
#     azurerm_storage_account.vmstore748945]
# }


# resource "azurerm_virtual_machine_extension" "productionvmextension" {  
#   name                 = "productionvm-extension"
#   virtual_machine_id   = azurerm_windows_virtual_machine.vm["test"].id
#   publisher            = "Microsoft.Compute"
#   type                 = "CustomScriptExtension"
#   type_handler_version = "1.10"
#   depends_on = [
#     azurerm_storage_blob.IISConfig,
#     azurerm_windows_virtual_machine.vm
#   ]
#   settings = <<SETTINGS
#     {
#         "fileUris": ["https://${azurerm_storage_account.vmstore748945.name}.blob.core.windows.net/data/IIS_Config.ps1"],
#           "commandToExecute": "powershell -ExecutionPolicy Unrestricted -file IIS_Config.ps1"     
#     }
# SETTINGS


# }


# The storage account will be used to store the script for Custom Script extension

# resource "azurerm_storage_account" "vmstore748945" {
#   name                     = "vmstore748945"
#   resource_group_name      = "app-grp"
#   location                 = "North Europe"
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
#   account_kind = "StorageV2"  
#   depends_on = [
#     azurerm_resource_group.appgrp
#   ]
# }

# resource "azurerm_storage_container" "data" {
#   name                  = "data"
#   storage_account_name  = "vmstore748945"
#   container_access_type = "blob"
#   depends_on=[
#     azurerm_storage_account.vmstore748945
#     ]
# }

# resource "azurerm_storage_blob" "IISConfig" {
#   for_each = toset(local.function)
#   name                   = "IIS_Config_${each.key}.ps1"
#   storage_account_name   = "vmstore748945"
#   storage_container_name = "data"
#   type                   = "Block"
#   source                 = "IIS_Config_${each.key}.ps1"
#    depends_on=[azurerm_storage_container.data,
#     azurerm_storage_account.vmstore748945]
# }


# resource "azurerm_virtual_machine_extension" "vmextension" {
#   for_each = toset(local.function)
#   name                 = "${each.key}-extension"
#   virtual_machine_id   = azurerm_windows_virtual_machine.vm[each.key].id
#   publisher            = "Microsoft.Compute"
#   type                 = "CustomScriptExtension"
#   type_handler_version = "1.10"
#   depends_on = [
#     azurerm_storage_blob.IISConfig
#   ]
#   settings = <<SETTINGS
#     {
#         "fileUris": ["https://${azurerm_storage_account.vmstore748945.name}.blob.core.windows.net/data/IIS_Config_${each.key}.ps1"],
#           "commandToExecute": "powershell -ExecutionPolicy Unrestricted -file IIS_Config_${each.key}.ps1"     
#     }
# SETTINGS

# }
