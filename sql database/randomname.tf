resource "random_uuid" "storageaccountidentifier" {

}

resource "random_uuid" "abcworkspaceidentifier" {



}

resource "random_uuid" "abcinsightsidentifier" {

}

resource "random_uuid" "sqlserveridentifier" {

}

resource "random_uuid" "dbworkspaceidentifier" {

}

output "sas" {
  value = nonsensitive("https://${azurerm_storage_account.webstorageresource.name}.blob.core.windows.net/${azurerm_storage_container.logs.name}${data.azurerm_storage_account_blob_container_sas.accountsas.sas}")
}

output "randomid" {
  value = /*substr(*/ random_uuid.storageaccountidentifier.result /*, 0, 8)*/
  #   bc9e6af6-28aa-a928-ceee-64fddd3a9cb2  
  #   value = substr(random_uuid.storageaccountidentifier.result, 24, 33)
  #   -${substr(random_uuid.abcworkspaceidentifier.result, 0, 8)}

}
