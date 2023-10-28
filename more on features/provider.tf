terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.73.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  skip_provider_registration = "true"
  subscription_id            = "1ed2ad0b-f27c-450a-b603-d1a5da681ba2"
  tenant_id                  = "e51dbd98-1ac6-489a-a978-8715042011fe"
  client_id                  = "70b47b18-eded-41ec-8d0a-de4490a4f8b6"
  #   client_secret = var.client_secret
  client_secret = "tXI8Q~wvotWpEg_L1m3JRqKy5HYpkrkpz-TfDc5V"

  features {

  }
}
