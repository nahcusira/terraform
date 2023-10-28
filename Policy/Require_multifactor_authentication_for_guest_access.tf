resource "azuread_invitation" "invite_user" {
  user_email_address = var.user_email_address
  redirect_url       = var.redirect_url
}

resource "azuread_conditional_access_policy" "MFA_guest_user" {
  display_name = "2. Require multifactor authentication for guest access"
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
      included_users = ["GuestsOrExternalUsers"]
    }
  }
  grant_controls {
    operator          = "AND"
    built_in_controls = ["mfa"]
  }
  depends_on = [data.azuread_user.emergency]
}
