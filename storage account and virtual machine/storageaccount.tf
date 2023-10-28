# resource "azurerm_storage_account" "storageaccountresource" {
#   name                     = join("", [lower("${var.storage_account_name}"), substr(random_uuid.storageaccountidentifier.result, 0, 8)])
#   count                    = var.number_of_machine
#   resource_group_name      = local.resource_group_name
#   location                 = local.location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
#   account_kind             = "StorageV2"

#   network_rules {
#     default_action             = "Deny"
#     ip_rules                   = ["42.112.110.233"]
#     virtual_network_subnet_ids = [azurerm_subnet.subnets[count.index].id]
#   }

#   tags = {
#     for name, value in local.common_tags : name => "${value}"
#   }

#   depends_on = [
#     azurerm_resource_group.abc,
#     random_uuid.storageaccountidentifier
#   ]
# }



# resource "azurerm_storage_account" "datalakestore4577788" {
#   name                     = "datalakestore4577788"
#   resource_group_name      = local.resource_group_name
#   location                 = local.location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
#   account_kind             = "StorageV2"
#   is_hns_enabled           = true
#   depends_on = [
#     azurerm_resource_group.abc
#   ]
# }


# resource "azurerm_storage_account" "datalakestore" {
#   name                     = join("", [lower("${var.data_lake_store_name}"), substr(random_uuid.storageaccountidentifier.result, 26, 8)])
#   resource_group_name      = local.resource_group_name
#   location                 = local.location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
#   account_kind             = "StorageV2"
#   is_hns_enabled           = true
#   depends_on = [
#     azurerm_resource_group.abc,
#     random_uuid.storageaccountidentifier
#   ]
# }



# resource "azurerm_storage_container" "data" {
#   count                 = var.number_of_machine
#   name                  = "data"
#   storage_account_name  = azurerm_storage_account.storageaccountresource[count.index].name
#   container_access_type = "blob"
#   depends_on = [
#     azurerm_storage_account.storageaccountresource
#   ]
# }

# resource "azurerm_storage_blob" "IISConfig" {
#   count                  = var.number_of_machine
#   name                   = "IIS_Config.ps1"
#   storage_account_name   = azurerm_storage_account.storageaccountresource[count.index].name
#   storage_container_name = "data"
#   type                   = "Block"
#   source                 = "IIS_Config.ps1"
#   depends_on             = [azurerm_storage_container.data]
# }
