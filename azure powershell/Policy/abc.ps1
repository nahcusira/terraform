$conditions = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
$conditions.Applications = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessApplicationCondition
$conditions.Applications.IncludeApplications = "00000002-0000-0ff1-ce00-000000000000"
$conditions.Users = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessUserCondition
$conditions.Users.IncludeUsers = "All"
$conditions.Users.ExcludeRoles = @("62e90394-69f5-4237-9190-012177145e10")
$conditions.Platforms = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessPlatformCondition
$conditions.Platforms.IncludePlatforms = @('Windows')
$gcontrols = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
$gcontrols._Operator = "OR"
$gcontrols.BuiltInControls = "MFA"
$session = New-Object -TypeName Microsoft.Open.MSGraph.Model.conditionalAccessSessionControls
$sessioncontrols = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessSignInFrequency
$sessioncontrols.Type = "hours"
$sessioncontrols.Value = 4
$sessioncontrols.IsEnabled = $true

$session.SignInFrequency = $sessioncontrols

New-AzureADMSConditionalAccessPolicy -DisplayName "OWA MFA policy" -State "Disabled" -Conditions $conditions -GrantControls $gcontrols -SessionControls $session