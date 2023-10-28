resource "azuread_conditional_access_policy" "risky_sign_in" {
  display_name = "9. Sign-in risk-based multifactor authentication"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types    = ["all"]
    sign_in_risk_levels = ["medium", "high"]

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
    built_in_controls = ["mfa"]
  }

  session_controls {
    application_enforced_restrictions_enabled = true
    disable_resilience_defaults               = false
    sign_in_frequency                         = 365
    sign_in_frequency_period                  = "days"
  }
  depends_on = [data.azuread_user.emergency]
}
