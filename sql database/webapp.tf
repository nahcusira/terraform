resource "azurerm_service_plan" "companyplan" {
  name                = "companyplan"
  resource_group_name = local.resource_group_name
  location            = local.location
  os_type             = "Windows"
  sku_name            = "S1"
  depends_on = [
    azurerm_resource_group.abc
  ]
}

resource "azurerm_windows_web_app" "companyabc1000" {
  name                = "companyabc1000"
  resource_group_name = local.resource_group_name
  location            = local.location
  service_plan_id     = azurerm_service_plan.companyplan.id

  site_config {
    application_stack {
      current_stack  = "dotnet"
      dotnet_version = "v6.0"
    }
  }
  connection_string {
    name  = "SQLConnection"
    type  = "SQLAzure"
    value = "Data Source=tcp:${azurerm_mssql_server.sqlserver.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.abcdb.name};User Id=${azurerm_mssql_server.sqlserver.administrator_login};Password='${azurerm_mssql_server.sqlserver.administrator_login_password}';"
  }

  #   ip_restriction {
  #     action     = "Deny"
  #     ip_address = "0.0.0.0/0"
  #     name       = "Deny_AllTraffic"
  #     priority   = 200
  #   }
  # }

  # logs {
  #   detailed_error_messages = true
  #   http_logs {
  #     azure_blob_storage {
  #       retention_in_days = 7
  #       sas_url           = "https://${azurerm_storage_account.webstorageresource.name}.blob.core.windows.net/${azurerm_storage_container.logs.name}${data.azurerm_storage_account_blob_container_sas.accountsas.sas}"
  #     }
  #   }
  # }

  # app_settings = {
  #   "APPINSIGHTS_INSTRUMENTATIONKEY"        = azurerm_application_insights.abcinsights.instrumentation_key
  #   "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.abcinsights.connection_string
  # }

  depends_on = [
    azurerm_service_plan.companyplan, azurerm_resource_group.abc
  ]
}


# resource "azurerm_app_service_source_control" "appservice_sourcecontrol" {
#   app_id                 = azurerm_windows_web_app.companyabc1000.id
#   repo_url               = "https://github.com/arisu-sakayanagi/webapp"
#   branch                 = "master"
#   use_manual_integration = true
# }

resource "azurerm_app_service_source_control" "appservice_sourcecontrol" {
  app_id                 = azurerm_windows_web_app.companyabc1000.id
  repo_url               = "https://github.com/arisu-sakayanagi/sqlapp"
  branch                 = "master"
  use_manual_integration = true
}







