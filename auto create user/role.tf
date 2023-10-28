data "azuread_user" "user" {
  count               = length(local.csv_data)
  user_principal_name = "${local.csv_data[count.index]["Name"]}${var.domain}"
  depends_on          = [azuread_user.user]
}

resource "azuread_directory_role" "role" {
  count        = length(local.csv_data)
  display_name = local.csv_data[count.index]["Role"]
  depends_on   = [data.azuread_user.user]
}

resource "azuread_directory_role_assignment" "role" {
  count               = length(local.csv_data)
  role_id             = azuread_directory_role.role[count.index].template_id
  principal_object_id = data.azuread_user.user[count.index].id
  depends_on          = [azuread_directory_role.role]
}