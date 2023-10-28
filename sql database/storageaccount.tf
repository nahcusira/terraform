resource "azurerm_storage_account" "webstorageresource" {
  name                     = join("", [lower("${var.web_store_name}"), substr(random_uuid.storageaccountidentifier.result, 0, 8)])
  resource_group_name      = local.resource_group_name
  location                 = local.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  depends_on = [
    azurerm_resource_group.abc,
    random_uuid.storageaccountidentifier
  ]
}


resource "azurerm_storage_container" "logs" {
  name                  = "logs"
  storage_account_name  = azurerm_storage_account.webstorageresource.name
  container_access_type = "blob"
  depends_on = [
    azurerm_storage_account.webstorageresource
  ]
}

data "azurerm_storage_account_blob_container_sas" "accountsas" {
  connection_string = azurerm_storage_account.webstorageresource.primary_connection_string
  container_name    = azurerm_storage_container.logs.name
  https_only        = true
  start             = "2023-09-01"
  expiry            = "2023-09-30"

  permissions {
    read   = true
    add    = true
    create = true
    write  = true
    delete = true
    list   = true
  }
  depends_on = [azurerm_storage_account.webstorageresource]
}



