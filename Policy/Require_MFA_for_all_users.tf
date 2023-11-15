resource "azuread_conditional_access_policy" "MFA_all_user" {
  display_name = "1. Require MFA for all users"
  state        = "enabledForReportingButNotEnforced"
  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["all"]
    }
    platforms {
      included_platforms = ["all"]
      excluded_platforms = []
    }
    users {
      excluded_users = [data.azuread_user.emergency.object_id]
    }
  }
  grant_controls {
    operator          = "AND"
    built_in_controls = ["mfa"]
  }
  depends_on = [data.azuread_user.emergency]
}
