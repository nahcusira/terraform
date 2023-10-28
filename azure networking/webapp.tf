# resource "azurerm_service_plan" "primaryplan" {
#   name                = "primaryplan"
#   resource_group_name = "app-grp"
#   location            = "North Europe"
#   os_type             = "Windows"
#   sku_name            = "D1"

#   depends_on = [
#     azurerm_resource_group.appgrp
#   ]
# }

# resource "azurerm_windows_web_app" "primaryapp" {
#   name                = "firstapp4561235"
#   resource_group_name = azurerm_service_plan.primaryplan.resource_group_name
#   location            = azurerm_service_plan.primaryplan.location
#   service_plan_id     = azurerm_service_plan.primaryplan.id

#   site_config {
#     application_stack {
#       current_stack  = "dotnet"
#       dotnet_version = "v7.0"
#     }
#     always_on = false
#   }

#   depends_on = [
#     azurerm_service_plan.primaryplan
#   ]
# }

# # Creation of the secondary web app

# resource "azurerm_service_plan" "secondaryplan" {
#   name                = "secondaryplan"
#   resource_group_name = "app-grp"
#   location            = "East US"
#   os_type             = "Windows"
#   sku_name            = "D1"

#   depends_on = [
#     azurerm_resource_group.appgrp
#   ]
# }

# resource "azurerm_windows_web_app" "secondaryapp" {
#   name                = "secondapp45647565"
#   resource_group_name = azurerm_service_plan.secondaryplan.resource_group_name
#   location            = azurerm_service_plan.secondaryplan.location
#   service_plan_id     = azurerm_service_plan.secondaryplan.id

#   site_config {
#     application_stack {
#       current_stack  = "dotnet"
#       dotnet_version = "v7.0"
#     }
#     always_on = false
#   }

#   depends_on = [
#     azurerm_service_plan.secondaryplan
#   ]
# }

# resource "azurerm_app_service_custom_hostname_binding" "primaryapp" {
#   hostname            = "${azurerm_traffic_manager_profile.app-profile.fqdn}"
#   app_service_name    = azurerm_windows_web_app.primaryapp.name
#   resource_group_name = local.resource_group_name

#   depends_on = [
#     azurerm_traffic_manager_azure_endpoint.primaryendpoint
#   ]
# }
