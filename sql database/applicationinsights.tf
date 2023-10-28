resource "azurerm_log_analytics_workspace" "abcworkspace" {
  name                = "appworkspace-${substr(random_uuid.abcworkspaceidentifier.result, 0, 8)}"
  location            = local.location
  resource_group_name = local.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  depends_on          = [random_uuid.abcworkspaceidentifier, azurerm_resource_group.abc]
}

resource "azurerm_application_insights" "abcinsights" {
  name                = "appinsights-${substr(random_uuid.abcinsightsidentifier.result, 0, 8)}"
  location            = local.location
  resource_group_name = local.resource_group_name
  application_type    = "web"
  workspace_id        = azurerm_log_analytics_workspace.abcworkspace.id
  depends_on = [
    azurerm_log_analytics_workspace.abcworkspace, random_uuid.abcinsightsidentifier, azurerm_resource_group.abc
  ]
}
