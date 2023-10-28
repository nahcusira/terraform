locals {
  resource_group_name = "abc"
  location            = "Japan East"
  virtual_network = {
    name          = "abc-network"
    address_space = "10.0.0.0/16"
  }
  #   subnet = [
  #     {
  #       name           = "subnetA"
  #       address_prefix = "10.0.0.0/24"
  #     },
  #     {
  #       name           = "subnetB"
  #       address_prefix = "10.0.1.0/24"
  #     }
  #   ]

  common_tags = {
    "environment" = "staging"
    "tier"        = 3
    "department"  = "IT"
  }


  # network_security_group_rules_windows = [
  #   {
  #     priority               = 200
  #     destination_port_range = "3389"
  #   },
  #   {
  #     priority               = 300
  #     destination_port_range = "80"
  #   }
  # ]



  network_security_group_rules_linux = [
    {
      priority               = 300
      destination_port_range = "22"
    },
    {
      priority               = 400
      destination_port_range = "80"
    }
  ]

}
