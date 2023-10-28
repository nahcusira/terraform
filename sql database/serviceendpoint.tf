# resource "azurerm_mssql_virtual_network_rule" "virtualnetworkrule" {
#   count      = var.number_of_subnets
#   name       = "sql-vnet-rule"
#   server_id  = azurerm_mssql_server.sqlserver.id
#   subnet_id  = azurerm_subnet.subnets[count.index].id
#   depends_on = [azurerm_mssql_server.sqlserver, azurerm_subnet.subnets]
# }
