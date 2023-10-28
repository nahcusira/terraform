resource "azuread_conditional_access_policy" "mfa_for_admins" {
  display_name = "4. Require multifactor authentication for admins accessing Microsoft admin portals"
  state        = "enabledForReportingButNotEnforced"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["all"]
    }

    users {
      included_roles = [
        "9b895d92-2cd3-44c7-9d02-a6ac2d5ea5c3", # Global Administrator
        "729827e3-9c14-49f7-bb1b-9608f156bbb8", # Authentication Administrator
        "17315797-102d-40b4-93e0-432062caca18", # Cloud Application Administrator
        "b1be1c3e-b65d-4f19-8427-f6fa0d97feb9", # Security Administrator
        "74ef975b-6605-40af-a5d2-b9539d836353", # External Identity Provider Administrator
        "b0f54661-2d74-4c50-afa3-1ec803f12efe", # Application Administrator
        "c4e39bd9-1100-46d3-8c65-fb160da0071f", # Cloud Device Administrator
        "b1be1c3e-b65d-4f19-8427-f6fa0d97feb9", # Conditional Access Administrator
        "3edaf663-341e-4475-9f94-5c398ef6c070", # Exchange Administrator  
        "4d6ac14f-3453-41d0-bef9-a3e0c569773a", # Helpdesk Administrator
        "7be44c8a-adaf-4e2a-84d6-ab2649e08a13", # Password Administrator  
        "9b895d92-2cd3-44c7-9d02-a6ac2d5ea5c3", # Privileged Authentication Administrator
        "e8611ab8-c189-46e8-94e1-60213ab1f814", # Privileged Role Administrator
        "194ae4cb-b126-40b2-bd5b-6091b380977d", # Security Reader  
        "f023fd81-a637-4b56-95fd-791ac0226033", # SharePoint Administrator
        "f2ef992c-3afb-46b9-b7cf-a126ee74c451"  # User Administrator
      ]
      excluded_users = [data.azuread_user.emergency.object_id]
    }
  }

  grant_controls {
    operator          = "OR"
    built_in_controls = ["mfa"]
  }
  depends_on = [data.azuread_user.emergency]
}
