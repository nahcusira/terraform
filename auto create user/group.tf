resource "azuread_group" "group_sales" {
  display_name     = "Group Sales"
  mail_enabled     = false
  security_enabled = true
  types            = ["DynamicMembership"]
  dynamic_membership {
    enabled = true
    rule    = "user.Department -eq \"Sales\""
  }
  depends_on = [azuread_user.user, azuread_user.user_custom, azuread_user.user_null]
}

resource "azuread_group" "group_it" {
  display_name     = "Group IT"
  mail_enabled     = false
  security_enabled = true
  types            = ["DynamicMembership"]
  dynamic_membership {
    enabled = true
    rule    = "user.Department -eq \"IT\""
  }
  depends_on = [azuread_user.user, azuread_user.user_custom, azuread_user.user_null]
}

resource "azuread_group" "group_executives" {
  display_name     = "Group Executives"
  mail_enabled     = false
  security_enabled = true
  types            = ["DynamicMembership"]
  dynamic_membership {
    enabled = true
    rule    = "user.Department -eq \"Executives\""
  }
  depends_on = [azuread_user.user, azuread_user.user_custom, azuread_user.user_null]
}

resource "azuread_group" "group_security" {
  display_name     = "Group Security"
  mail_enabled     = false
  security_enabled = true
  types            = ["DynamicMembership"]
  dynamic_membership {
    enabled = true
    rule    = "user.Department -eq \"Security\""
  }
  depends_on = [azuread_user.user, azuread_user.user_custom, azuread_user.user_null]
}

resource "azuread_group" "group_heathcare" {
  display_name     = "Group Heathcare"
  mail_enabled     = false
  security_enabled = true
  types            = ["DynamicMembership"]
  dynamic_membership {
    enabled = true
    rule    = "user.Department -eq \"Heathcare\""
  }
  depends_on = [azuread_user.user, azuread_user.user_custom, azuread_user.user_null]
}

resource "azuread_group" "group_hr" {
  display_name     = "Group HR"
  mail_enabled     = false
  security_enabled = true
  types            = ["DynamicMembership"]
  dynamic_membership {
    enabled = true
    rule    = "user.Department -eq \"HR\""
  }
  depends_on = [azuread_user.user, azuread_user.user_custom, azuread_user.user_null]
}

resource "azuread_group" "group_digital" {
  display_name     = "Group Digital"
  mail_enabled     = false
  security_enabled = true
  types            = ["DynamicMembership"]
  dynamic_membership {
    enabled = true
    rule    = "user.Department -eq \"Digital\""
  }
  depends_on = [azuread_user.user, azuread_user.user_custom, azuread_user.user_null]
}

resource "azuread_group" "group_design" {
  display_name     = "Group Design"
  mail_enabled     = false
  security_enabled = true
  types            = ["DynamicMembership"]
  dynamic_membership {
    enabled = true
    rule    = "user.Department -eq \"Design\""
  }
  depends_on = [azuread_user.user, azuread_user.user_custom, azuread_user.user_null]
}
