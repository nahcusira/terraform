resource "azuread_conditional_access_policy" "MFA" {
  display_name = "5. MFA for Block access for unknown or unsupported device platform"
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
      included_users = ["all"]
      excluded_users = [data.azuread_user.emergency.object_id]
    }
  }
  grant_controls {
    operator          = "AND"
    built_in_controls = ["mfa"]
  }
  depends_on = [data.azuread_user.emergency]
}

resource "azuread_conditional_access_policy" "passwordchangeUnknowDevice" {
  display_name = "5. Block access for unknown or unsupported device platform"
  state        = "enabledForReportingButNotEnforced"
  conditions {
    client_app_types = ["all"]
    user_risk_levels = ["high"]
    applications {
      included_applications = ["all"]
    }
    users {
      included_users = ["all"]
      excluded_users = [data.azuread_user.emergency.object_id]
    }
  }
  grant_controls {
    operator          = "AND"
    built_in_controls = ["mfa", "passwordChange"]
  }
  depends_on = [data.azuread_user.emergency]
}
