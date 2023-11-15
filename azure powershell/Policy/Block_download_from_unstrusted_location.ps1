$conditions = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
$conditions.Applications = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessApplicationCondition
$conditions.Applications.IncludeApplications = @("Office365", "00000003-0000-0ff1-ce00-000000000000", "00000002-0000-0ff1-ce00-000000000000")
$conditions.Users = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessUserCondition
$conditions.Users.IncludeUsers = "all"
$emergency = Get-AzureADUser -ObjectId "emergency@capstoneproject1192001gmail.onmicrosoft.com"
$conditions.Users.ExcludeUsers = $emergency.ObjectId
$conditions.Locations = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessLocationCondition
$conditions.Locations.IncludeLocations = "all"
$conditions.Locations.ExcludeLocations = "AllTrusted"
$session = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessSessionControls
$sessioncontrols = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessCloudAppSecurity
$sessioncontrols.CloudAppSecurityType = "BlockDownloads"
$sessioncontrols.IsEnabled = $true
$session.CloudAppSecurity = $sessioncontrols
New-AzureADMSConditionalAccessPolicy -DisplayName "Block download from unstrusted location" -State "enabledForReportingButNotEnforced" -Conditions $conditions -SessionControls $session