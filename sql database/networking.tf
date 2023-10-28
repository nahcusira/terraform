# resource "azurerm_virtual_network" "newgrpnetwork" {
#   name                = local.virtual_network.name
#   resource_group_name = "new-grp"
#   location            = local.location
#   address_space       = [local.virtual_network.address_space]
#   depends_on          = [azurerm_resource_group.abc]
# }

# resource "azurerm_subnet" "subnets" {
#   count = var.number_of_subnets
#   name                 = local.subnet[count.index].name
#   resource_group_name  = local.resource_group_name
#   virtual_network_name = local.virtual_network.name
#   address_prefixes     = [local.subnet[count.index].address_prefix]
#   depends_on           = [azurerm_virtual_network.newgrpnetwork]
# }

# resource "azurerm_subnet" "subnets" {
#   count                = var.number_of_subnets
#   name                 = "Subnet${count.index}"
#   resource_group_name  = "new-grp"
#   virtual_network_name = local.virtual_network.name
#   address_prefixes     = ["10.0.${count.index}.0/24"]
#   service_endpoints    = ["Microsoft.Storage"]
#   depends_on           = [azurerm_virtual_network.newgrpnetwork]
# }

# resource "azurerm_subnet" "subnets" {
#   count                = var.number_of_subnets
#   name                 = "Subnet${count.index}"
#   resource_group_name  = "new-grp"
#   virtual_network_name = local.virtual_network.name
#   address_prefixes     = ["10.0.${count.index}.0/24"]
#   service_endpoints    = ["Microsoft.Sql"]
#   depends_on           = [azurerm_virtual_network.newgrpnetwork]
# }


# resource "azurerm_network_security_group" "newgrpnsg" {
#   name                = "abc-nsg"
#   location            = local.location
#   resource_group_name = "new-grp"

#   dynamic "security_rule" {
#     for_each = local.network_security_group_rules_windows
#     content {
#       name                       = "Allow-${security_rule.value.destination_port_range}"
#       priority                   = security_rule.value.priority
#       direction                  = "Inbound"
#       access                     = "Allow"
#       protocol                   = "Tcp"
#       source_port_range          = "*"
#       destination_port_range     = security_rule.value.destination_port_range
#       source_address_prefix      = "*"
#       destination_address_prefix = "*"
#     }

#   }
#   depends_on = [azurerm_resource_group.abc]
# }

# resource "azurerm_network_interface" "abcinterface" {
#   count               = var.number_of_machine
#   name                = "abcinterface${count.index}"
#   location            = local.location
#   resource_group_name = "new-grp"

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.subnets[count.index].id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.abcip[count.index].id
#   }
#   depends_on = [azurerm_subnet.subnets, azurerm_public_ip.abcip]
# }

# resource "azurerm_public_ip" "abcip" {
#   count               = var.number_of_machine
#   name                = "abc-ip${count.index}"
#   resource_group_name = local.resource_group_name
#   location            = local.location
#   allocation_method   = "Static"
#   depends_on          = [azurerm_resource_group.abc]
# }

# resource "azurerm_network_interface_security_group_association" "newgrpnsglink" {
#   count                     = var.number_of_subnets
#   network_interface_id      = azurerm_network_interface.abcinterface[count.index].id
#   network_security_group_id = azurerm_network_security_group.newgrpnsg.id

#   depends_on = [
#     azurerm_virtual_network.newgrpnetwork,
#     azurerm_network_security_group.newgrpnsg,
#     azurerm_network_interface.abcinterface
#   ]
# }
