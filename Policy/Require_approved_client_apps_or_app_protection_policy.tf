resource "azuread_conditional_access_policy" "app_protection_policy" {
  display_name = "8. Require approved client apps or app protection policy"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    platforms {
      included_platforms = ["android", "iOS"]
      excluded_platforms = []
    }

    applications {
      included_applications = ["all"]
    }

    users {
      included_users = ["all"]
      excluded_users = [data.azuread_user.emergency.object_id]
    }
  }

  grant_controls {
    operator          = "OR"
    built_in_controls = ["approvedApplication", "compliantApplication"]
  }
  depends_on = [data.azuread_user.emergency]
}

resource "azuread_conditional_access_policy" "block_exchange_activeSync" {
  display_name = "8. Block Exchange ActiveSync"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["exchangeActiveSync"]

    applications {
      included_applications = ["00000002-0000-0ff1-ce00-000000000000"] #Office 365 Exchange Online
    }

    platforms {
      included_platforms = ["android", "iOS"]
      excluded_platforms = []
    }

    users {
      included_users = ["all"]
      excluded_users = [data.azuread_user.emergency.object_id]
    }
  }

  grant_controls {
    operator          = "AND"
    built_in_controls = ["compliantApplication"]
  }
  depends_on = [data.azuread_user.emergency]
}
