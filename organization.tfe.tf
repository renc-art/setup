resource "tfe_organization" "organization" {
  name  = "ORGANIZATION_NAME"
  email = "USER_EMAIL"
}

data "tfe_team" "owners" {
  name         = "owners"
  organization = tfe_organization.organization.name
}

resource "tfe_team_token" "team_token" {
  team_id = data.tfe_team.owners.id
}

resource "tfe_workspace" "organization_workspace" {
  name         = "organization"
  organization = tfe_organization.organization.name
}

resource "tfe_variable" "var_organization_name" {
  key          = "organization_name"
  value        = tfe_organization.organization.name
  category     = "terraform"
  workspace_id = tfe_workspace.organization_workspace.id
  description  = "organization name on github and terraform cloud"
}

#resource "tfe_variable" "var_github_token" {
#  key          = "github_token"
#  value        = var.github_token
#  category     = "terraform"
#  workspace_id = tfe_workspace.organization_workspace.id
#  description  = "organization name on github and terraform cloud"
#}

