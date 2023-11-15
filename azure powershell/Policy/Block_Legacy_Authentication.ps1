$conditions = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
$conditions.ClientAppTypes = New-Object -TypeName System.Collections.Generic.List[Microsoft.Open.MSGraph.Model.ConditionalAccessClientApp]
$conditions.ClientAppTypes = "other"
$conditions.Applications = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessApplicationCondition
$conditions.Applications.IncludeApplications = @("Office365", "00000003-0000-0ff1-ce00-000000000000", "00000002-0000-0ff1-ce00-000000000000")
$conditions.Users = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessUserCondition
$conditions.Users.IncludeUsers = "all"
$emergency = Get-AzureADUser -ObjectId "emergency@capstoneproject1192001gmail.onmicrosoft.com"
$conditions.Users.ExcludeUsers = $emergency.ObjectId
$controls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
$controls._Operator = "AND"
$controls.BuiltInControls = "block"
New-AzureADMSConditionalAccessPolicy -DisplayName "Block Legacy Authentication" -State "enabledForReportingButNotEnforced" -Conditions $conditions -GrantControls $controls