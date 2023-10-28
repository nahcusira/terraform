resource "azuread_conditional_access_policy" "MFA_risk_user" {
  display_name = "7. MFA for User risk-based password change"
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

resource "azuread_conditional_access_policy" "passwordchangeUserRiskBased" {
  display_name = "7. User risk-based password change"
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
