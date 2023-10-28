resource "azurerm_mssql_server" "sqlserver" {
  name                         = "sqlserver-${substr(random_uuid.sqlserveridentifier.result, 0, 8)}"
  resource_group_name          = local.resource_group_name
  location                     = local.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = "Azure@3456"
  depends_on = [
    azurerm_resource_group.abc, random_uuid.sqlserveridentifier
  ]
}

resource "azurerm_mssql_database" "abcdb" {
  name         = "abcdb"
  server_id    = azurerm_mssql_server.sqlserver.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = "Basic"

  lifecycle {
    ignore_changes = [
      license_type
    ]
  }

  depends_on = [
    azurerm_mssql_server.sqlserver
  ]

}

resource "azurerm_mssql_firewall_rule" "allowmyclient" {
  name             = "AllowClientIP"
  server_id        = azurerm_mssql_server.sqlserver.id
  start_ip_address = "58.186.165.103"
  end_ip_address   = "58.186.165.103"
  depends_on = [
    azurerm_mssql_server.sqlserver
  ]
}

resource "azurerm_mssql_firewall_rule" "allowservices" {
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.sqlserver.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
  depends_on = [
    azurerm_mssql_server.sqlserver
  ]
}


# resource "azurerm_mssql_database" "newdb" {
#   name         = "newdb"
#   server_id    = azurerm_mssql_server.sqlserver.id
#   collation    = "SQL_Latin1_General_CP1_CI_AS"
#   license_type = "LicenseIncluded"
#   max_size_gb  = 2
#   sku_name     = "Basic"
#   depends_on = [
#     azurerm_mssql_server.sqlserver
#   ]
# }
