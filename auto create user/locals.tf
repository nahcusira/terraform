locals {
  resource_group_name = "staging-grp"
  location            = "Southeast Asia"

  csv_data = csvdecode(file(var.file))
  name     = distinct(local.csv_data[*]["Name"])
  user_data = { for i in range(length(azuread_user.user)) :
    azuread_user.user[i].user_principal_name => random_password.password[i].result
  }

  csv_data_null = csvdecode(file(var.file_null))
  name_null     = distinct(local.csv_data_null[*]["Name"])
  user_data_null = { for i in range(length(azuread_user.user_null)) :
    azuread_user.user_null[i].user_principal_name => random_password.password_null[i].result
  }

  csv_data_custom = csvdecode(file(var.file_custom))
  name_custom     = distinct(local.csv_data_custom[*]["Name"])
  user_data_custom = { for i in range(length(azuread_user.user_custom)) :
    azuread_user.user_custom[i].user_principal_name => random_password.password_custom[i].result
  }
}