$conditions = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
$conditions.Applications = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessApplicationCondition
$conditions.Applications.IncludeApplications = "all"
$conditions.Users = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessUserCondition
$conditions.Users.IncludeGroups = "326631f9-b2fe-4a75-9db1-93aaf542f6a6" #Administrator Group
$emergency = Get-AzureADUser -ObjectId "emergency@capstoneproject1192001gmail.onmicrosoft.com"
$conditions.Users.ExcludeUsers = $emergency.ObjectId
$controls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
$controls._Operator = "OR"
$controls.BuiltInControls = "mfa"
New-AzureADMSConditionalAccessPolicy -DisplayName "Require MFA for Administrator Group" -State "enabledForReportingButNotEnforced" -Conditions $conditions -GrantControls $controls