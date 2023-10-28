resource "random_password" "password" {
  count            = length(local.name)
  length           = 16
  special          = true
  override_special = "_%@!#"
}

resource "azuread_user" "user" {
  count               = length(local.name)
  user_principal_name = "${local.name[count.index]}${var.domain}"
  display_name        = local.name[count.index]
  password            = random_password.password[count.index].result
  department          = local.csv_data[count.index]["Department"]
  job_title           = local.csv_data[count.index]["JobTitle"]
}

resource "random_password" "password_null" {
  count            = length(local.name_null)
  length           = 16
  special          = true
  override_special = "_%@!#"
}

resource "azuread_user" "user_null" {
  count               = length(local.name_null)
  user_principal_name = "${local.name_null[count.index]}${var.domain}"
  display_name        = local.name_null[count.index]
  password            = random_password.password_null[count.index].result
  department          = local.csv_data_null[count.index]["Department"]
  job_title           = local.csv_data_null[count.index]["JobTitle"]
}

resource "random_password" "password_custom" {
  count            = length(local.name_custom)
  length           = 16
  special          = true
  override_special = "_%@!#"
}

resource "azuread_user" "user_custom" {
  count               = length(local.name_custom)
  user_principal_name = "${local.name_custom[count.index]}${var.domain}"
  display_name        = local.name_custom[count.index]
  password            = random_password.password_custom[count.index].result
  department          = local.csv_data_custom[count.index]["Department"]
  job_title           = local.csv_data_custom[count.index]["JobTitle"]
}
