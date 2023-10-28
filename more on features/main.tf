module "networking_module" {
  source                        = "C:\\terraform\\more on features\\networking"
  resource_group_name           = "app-grp"
  location                      = "North Europe"
  virtual_network_name          = "app-network"
  virtual_network_address_space = "10.0.0.0/16"
}

# module "staging_networking_module" {
#   source                        = "C:\\terraform\\more on features\\networking"
#   resource_group_name           = "new-grp"
#   location                      = "North Europe"
#   virtual_network_name          = "staging-network"
#   virtual_network_address_space = "10.1.0.0/16"
# }
