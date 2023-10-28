terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.75.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = "true"
  subscription_id            = "32392eda-5081-4853-aee2-5bcecf76acc1"
  tenant_id                  = "34425079-7696-4bf0-b4c8-c45e68e8eaa9"
  client_id                  = "136d8a66-f5f0-49e1-83ca-8f3d1f7e9622"
  client_secret              = "2TB8Q~QhU5CPRudtBUA~5tattowKljQYsO0tdbvO"
  features {}
}