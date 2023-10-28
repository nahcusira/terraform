

module "app_storage_module"{
    source="./modules/storage"
    resource_group_name=local.resource_group_name
    location=local.location    
    storage_account_name=local.storage_data.app_storage_module.storage_account_name
    container_name=local.storage_data.app_storage_module.container_name
    container_access=local.storage_data.app_storage_module.container_access
    storage_account_exists=local.storage_data.app_storage_module.storage_account_exists
    blobs_binary_enabled=local.storage_data.app_storage_module.blobs_binary_enabled
    blobs_binary=local.storage_data.app_storage_module.blobs_binary
     /* blobs_binary={
        "Laptop.jpg"="./images/"
        "Mobile.jpg"="./images/"
        "Tab.jpg"="./images/"
    }*/

    depends_on = [
      module.general_module,
      module.storage_module
    ]
}