# variable "client_secret" {
#   type = string
#   sensitive = true
# }


variable "number_of_subnets" {
  type        = number
  description = "this is defines the number of subnets"
  default     = 2
  validation {
    condition     = var.number_of_subnets < 5
    error_message = "the number of subnets must be less than 5"
  }
}

variable "number_of_machine" {
  type        = number
  description = "this is defines the number of machine"
  default     = 2
}


variable "storage_account_name" {
  type        = string
  description = "This is the prefix of the storage account name"
  default     = "vmstore"
}



# variable "key_vault_name" {
#   type        = string
#   description = "This is the prefix of the keyvault name"
#   default     = "abckeyvault"
# }



variable "data_lake_store_name" {
  type        = string
  description = "This is the prefix of the datalakestore name"
  default     = "datalakestore"
}