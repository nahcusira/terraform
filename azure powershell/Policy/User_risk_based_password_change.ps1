# $conditions = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
# $conditions.Applications = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessApplicationCondition
# $conditions.Applications.IncludeApplications = "all"
# $conditions.Users = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessUserCondition
# $conditions.Users.IncludeUsers = "all"
# $emergency = Get-AzureADUser -ObjectId "emergency@capstoneproject1192001gmail.onmicrosoft.com"
# $conditions.Users.ExcludeUsers = $emergency.ObjectId
# $controls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
# $controls._Operator = "AND"
# $controls.BuiltInControls = "mfa"
# New-AzureADMSConditionalAccessPolicy -DisplayName "7. MFA for User risk-based password change" -State "enabledForReportingButNotEnforced" -Conditions $conditions -GrantControls $controls

$conditions = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
$conditions.Applications = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessApplicationCondition
$conditions.Applications.IncludeApplications = "all"
$conditions.Applications = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessApplicationCondition
$conditions.Applications.IncludeUserActions = "urn:user:registersecurityinfo"
$conditions.Users = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessUserCondition
$conditions.Users.IncludeUsers = "all"
$emergency = Get-AzureADUser -ObjectId "emergency@capstoneproject1192001gmail.onmicrosoft.com"
$conditions.Users.ExcludeUsers = $emergency.ObjectId
$controls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
$controls._Operator = "AND"
$controls.BuiltInControls = @("mfa", "passwordChange")
New-AzureADMSConditionalAccessPolicy -DisplayName "7. User risk-based password change" -State "enabledForReportingButNotEnforced" -Conditions $conditions -GrantControls $controls