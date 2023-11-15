$conditions = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
$conditions.Applications = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessApplicationCondition
$conditions.Applications.IncludeApplications = @("Office365", "00000003-0000-0ff1-ce00-000000000000", "00000002-0000-0ff1-ce00-000000000000")
$conditions.Platforms = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessPlatformCondition
$conditions.Platforms.IncludePlatforms = @("android", "iOS")
$conditions.Users = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessUserCondition
$conditions.Users.IncludeUsers = "all"
$emergency = Get-AzureADUser -ObjectId "emergency@capstoneproject1192001gmail.onmicrosoft.com"
$conditions.Users.ExcludeUsers = $emergency.ObjectId
$controls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
$controls._Operator = "AND"
$controls.BuiltInControls = "compliantApplication"
New-AzureADMSConditionalAccessPolicy -DisplayName "Require approved mobile app to access" -State "enabledForReportingButNotEnforced" -Conditions $conditions -GrantControls $controls