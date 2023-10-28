data "azuread_user" "user_custom" {
  count               = length(local.csv_data_custom)
  user_principal_name = "${local.csv_data_custom[count.index]["Name"]}${var.domain}"
  depends_on          = [azuread_user.user_custom]
}

resource "azuread_custom_directory_role" "role_custom_marketing" {
  display_name = "Marketing"
  description  = "Allows reading applications and updating groups"
  enabled      = true
  version      = "1.0"

  permissions {
    allowed_resource_actions = [
      "microsoft.directory/applications/create"
    ]
  }
}

resource "azuread_custom_directory_role" "role_custom_content" {
  display_name = "Content Management"
  description  = "Allows reading applications and updating groups"
  enabled      = true
  version      = "1.0"

  permissions {
    allowed_resource_actions = [
      "microsoft.directory/applications/create",
      "microsoft.directory/groups/create"
    ]
  }
}

resource "azuread_custom_directory_role" "role_custom_design" {
  display_name = "Design"
  description  = "Allows reading applications and updating groups"
  enabled      = true
  version      = "1.0"

  permissions {
    allowed_resource_actions = [
      "microsoft.directory/applications/standard/read",
      "microsoft.directory/groups/standard/read"
    ]
  }
}

resource "azuread_custom_directory_role" "role_custom_artist" {
  display_name = "Artist"
  description  = "Allows reading applications and updating groups"
  enabled      = true
  version      = "1.0"

  permissions {
    allowed_resource_actions = [
      "microsoft.directory/connectors/create",
      "microsoft.directory/groups/reprocessLicenseAssignment"
    ]
  }
}

resource "azuread_directory_role_assignment" "user_marketing" {
  role_id             = azuread_custom_directory_role.role_custom_marketing.template_id
  principal_object_id = data.azuread_user.user_custom[0].object_id
}

resource "azuread_directory_role_assignment" "user_content" {
  role_id             = azuread_custom_directory_role.role_custom_content.template_id
  principal_object_id = data.azuread_user.user_custom[1].object_id
}

resource "azuread_directory_role_assignment" "user_design" {
  role_id             = azuread_custom_directory_role.role_custom_design.template_id
  principal_object_id = data.azuread_user.user_custom[2].object_id
}

resource "azuread_directory_role_assignment" "user_artist" {
  role_id             = azuread_custom_directory_role.role_custom_artist.template_id
  principal_object_id = data.azuread_user.user_custom[3].object_id
}