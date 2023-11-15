# $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
# $PasswordProfile.Password = "Azure@123"
# $user = New-AzureADUser -DisplayName "emergency account" -PasswordProfile $PasswordProfile -UserPrincipalName "emergency@capstoneproject1192001gmail.onmicrosoft.com" -AccountEnabled $true -Country "Vietnam" -UsageLocation "VN" -MailNickName "EmergencyAccount"
# $role = Get-AzureADDirectoryRole | Where-Object {$_.displayName -eq 'Global Administrator'}
# Add-AzureADDirectoryRoleMember -ObjectId $role.ObjectId -RefObjectId $user.ObjectId
# Get-AzureADUser -ObjectId $user.ObjectId
# $WorkspaceName="vmworkspace342423"
# $ResourceGroupName="powershell-grp"
# $Location="Southeast Asia"
# $LogAnalyticsWorkspace=New-AzOperationalInsightsWorkspace -Location $Location -Name $WorkspaceName -ResourceGroupName $ResourceGroupName
# $ActionGroupName = "ActionGroup"
# $emailReceiver = New-AzActionGroupReceiver -Name 'EmailAction' -EmailReceiver -EmailAddress 'mjxxlr7a@duck.com'
# $ActionGroup=Set-AzActionGroup -Name $ActionGroupName -ResourceGroupName $ResourceGroupName -ShortName $ActionGroupName -Receiver $emailReceiver
# # $condition=New-AzScheduledQueryRuleConditionObject -Query "SigninLogs | project UserPrincipalName | where UserPrincipalName == 'test2@capstoneproject1192001gmail.onmicrosoft.com'" -Operator "GreaterThan" -Severity 0 -Threshold "0" -EvaluationFrequency 5 -FailingPeriodNumberOfEvaluationPeriod 1 -FailingPeriodMinFailingPeriodsToAlert 1
# # New-AzScheduledQueryRule -Name test-rule -ResourceGroupName $ResourceGroupName -Location $Location -DisplayName `
# # test-rule -Scope "/subscriptions/80e2f14d-d233-44b4-91f5-8ff143317bdb/resourceGroups/powershell-grp/providers/Microsoft.OperationalInsights/workspaces/vmworkspace342423" -Severity 4 `
# # -WindowSize ([System.TimeSpan]::New(0,10,0)) -EvaluationFrequency ([System.TimeSpan]::New(0,5,0)) -Operator "GreaterThan" -Severity 0 -Threshold 0 -Query "SigninLogs | project UserPrincipalName | where UserPrincipalName == 'test2@capstoneproject1192001gmail.onmicrosoft.com'"
# New-AzOperationalInsightsWorkspace -ResourceGroupName $ResourceGroupName -Name $WorkspaceName -Location $Location
# $query = "SigninLogs | project UserPrincipalName | where UserPrincipalName == 'test2@capstoneproject1192001gmail.onmicrosoft.com'"
# $alertName = "myCustomLogAlert"
# $alert = New-AzScheduledQueryRule -Workspace $WorkspaceName -ScheduleInterval 5 -Query $query -ActionGroupResourceId $ActionGroup.Id -Name $alertName



# # Create Log Analytics workspace
# $workspaceName = "emergency-workspace"
# $resourceGroupName = "powershell-grp"
# $location = "Southeast Asia"

# New-AzOperationalInsightsWorkspace -ResourceGroupName $resourceGroupName -Name $workspaceName -Location $location -Sku "PerGB2018" -RetentionInDays 30

# # Create Action Group
# $actionGroupName = "emergency-group"
# $emailReceiverName = "sendtoadmin"
# $emailAddress = "mjxxlr7a@duck.com"

# $emailReceiver = New-AzActionGroupReceiver -Name $emailReceiverName -EmailReceiver -EmailAddress $emailAddress
# $actionGroup = Set-AzActionGroup -ResourceGroupName $resourceGroupName -Name $actionGroupName -ShortName "p0action" -Receiver $emailReceiver

# # Create Alert Rule
# $alertName = "emergency-alertrule"
# $description = "Alert when the break glass account logs in to Azure AD"
# $severity = "0"   # Critical
# $throttling = "10" # Minutes

# $source = Get-AzScheduledQueryRuleSource -ResourceGroupName $resourceGroupName -WorkspaceName $workspaceName

# $triggerCondition = New-AzScheduledQueryRuleTriggerCondition -ThresholdOperator "GreaterThan" -Threshold 0
# $aznsAction = New-AzScheduledQueryRuleAznsAction -ActionGroup $actionGroup.Id -EmailSubject "Alert from break glass account login"
# $trigger = New-AzScheduledQueryRuleTrigger -Threshold $triggerCondition -Operator "GreaterThan" -Frequency (New-TimeSpan -Minutes 5) -WindowSize (New-TimeSpan -Minutes 5)

# $query = "SigninLogs | project UserPrincipalName | where UserPrincipalName == 'test2@capstoneproject1192001gmail.onmicrosoft.com'"

# Add-AzScheduledQueryRule -ResourceGroupName $resourceGroupName -Name $alertName -Location $location -Action $aznsAction -Description $description -Enabled $true -Source $source -Schedule $trigger -Severity $severity -Throttling $throttling -Query $query

# Variables
# Set the resource group and workspace details 
# $subscriptionId = (Get-AzContext).Subscription.Id
# $log = @()
# $log += New-AzDiagnosticSettingSubscriptionLogSettingsObject -Category Recommendation -Enabled $true
# New-AzSubscriptionDiagnosticSetting -Name test-setting -WorkspaceId /subscriptions/$subscriptionId/resourcegroups/powershell-grp/providers/microsoft.operationalinsights/workspaces/vmworkspace342423 -Log $log
# Specify the details for the diagnostic settings
# Variables
# $resourceGroupName = "powershell-grp"
# $workspaceName = "vmworkspace342423"
# $subscriptionId = (Get-AzContext).Subscription.Id
# # Get the resource ID of the Log Analytics workspace
# $workspaceResourceId = (Get-AzOperationalInsightsWorkspace -ResourceGroupName $resourceGroupName -Name $workspaceName).ResourceId
# $logAccountName = "test2@capstoneproject1192001gmail.onmicrosoft.com"

# # Create diagnostic setting
# $diagnosticSettings = @{
#     WorkspaceId = $workspaceResourceId
#     StorageAccountId = $storageAccountId
#     StorageAccountName = $storageAccountName
#     StorageAccountResourceGroupName = $resourceGroupName
#     StorageAccountSubscriptionId = "YourSubscriptionId"
#     Log = @(
#         @{
#             Category = "AuditEvent"
#             Enabled = $true
#         },
#         @{
#             Category = "SecurityAlert"
#             Enabled = $true
#         }
#     )
# }

# New-AzDiagnosticSetting -ResourceId "/subscriptions/$subscriptionId/resourceGroups/$resourceGroupName/providers/Microsoft.Insights/diagnosticSettingsCategories" -WorkspaceId $workspaceResourceId -Log $diagnosticSettings.Log


# Assuming you have already connected to Azure AD using Connect-AzAccount

# Define the display name and other parameters
# $displayName = "7. User risk-based password change"
# $state = "enabledForReportingButNotEnforced"
# $clientAppTypes = @("all")
# $userRiskLevels = @("high")
# $includedApplications = @("all")
# $includedUsers = @("all")
# $excludedUsers = @((Get-AzADUser -UserPrincipalName 'test2@capstoneproject1192001gmail.onmicrosoft.com').Id)  # Replace with the actual UPN of the emergency user

# # Grant controls
# $operator = "AND"
# $builtInControls = @("mfa", "passwordChange")

# # Create the Conditional Access policy
# New-AzAdMSConditionalAccessPolicy -DisplayName $displayName -State $state -ClientAppTypes $clientAppTypes -UserRiskLevels $userRiskLevels -Applications $includedApplications -Users $includedUsers -ExcludedUsers $excludedUsers -Operator $operator -BuiltInControls $builtInControls

# Set the subscription ID 
# $subId = "(Get-AzContext).Subscription.Id"

# Set the resource group and workspace  
# $rgName = "powershell-grp"
# $workspace = "vmworkspace342423" 

# # Set the rule details
# $ruleName = "AccountLoginAlert"
# $displayName = "Alert on account login"
# $severity = 1
# $threshold = 1
# $windowSize = [System.TimeSpan]::FromMinutes(5)
# $evaluationFrequency = [System.TimeSpan]::FromMinutes(5)

# # Set the query  
# $query = @"
# AuditLogs
# | where OperationName == "Sign-in activity" 
# | where TargetResources contains "test2@capstoneproject1192001gmail.onmicrosoft.com"
# | summarize count() by bin(TimeGenerated, 5m)
# "@

# # Create the condition
# $condition = New-AzScheduledQueryRuleLogMetricTrigger -Threshold $threshold -MetricTriggerType "Consecutive" -MetricColumn "count_"

# $actionGrp = New-AzActionGroup -ResourceGroupName $rgName -Name $ruleName

# # Create the rule
# $params = @{
#   ResourceGroupName = $rgName 
#   RuleName = $ruleName
#   Location = "Southeast Asia" 
#   ActionGroup = $actionGrp
#   DisplayName = $displayName
#   Enabled = $true
#   Description = "Alert when account is logged into"
#   Severity = $severity
#   WindowSize = $windowSize 
#   EvaluationFrequency = $evaluationFrequency
#   Trigger = $condition
# }

# New-AzScheduledQueryRule @params


# $subscriptionId = (Get-AzContext).Subscription.Id
# $metric = @()
# $log = @()
# $metric += New-AzDiagnosticSettingMetricSettingsObject -Enabled $true -Category AllMetrics -RetentionPolicyDay 7 -RetentionPolicyEnabled $true
# $log += New-AzDiagnosticSettingLogSettingsObject -Enabled $true -Category Audit -RetentionPolicyDay 7 -RetentionPolicyEnabled $true
# New-AzDiagnosticSetting -Name test-setting -ResourceId "/subscriptions/80e2f14d-d233-44b4-91f5-8ff143317bdb/resourceGroups/powershell-grp/providers/Microsoft.OperationalInsights/workspaces/vmworkspace342423" -WorkspaceId "/subscriptions/80e2f14d-d233-44b4-91f5-8ff143317bdb/resourceGroups/powershell-grp/providers/Microsoft.OperationalInsights/workspaces/vmworkspace342423" -Log $log -Metric $metric



$subscriptionId = (Get-AzContext).Subscription.Id
$metric = @()
$log = @()
$categories = Get-AzDiagnosticSettingCategory -ResourceId "/subscriptions/80e2f14d-d233-44b4-91f5-8ff143317bdb/resourceGroups/powershell-grp/providers/Microsoft.OperationalInsights/workspaces/vmworkspace342423"
$categories | ForEach-Object {if($_.CategoryType -eq "Metrics"){$metric+=New-AzDiagnosticSettingMetricSettingsObject -Enabled $true -Category $_.Name -RetentionPolicyDay 7 -RetentionPolicyEnabled $true} else{$log+=New-AzDiagnosticSettingLogSettingsObject -Enabled $true -Category $_.Name -RetentionPolicyDay 7 -RetentionPolicyEnabled $true}}
New-AzDiagnosticSetting -Name test-setting -ResourceId "/subscriptions/80e2f14d-d233-44b4-91f5-8ff143317bdb/resourceGroups/powershell-grp/providers/Microsoft.OperationalInsights/workspaces/vmworkspace342423" -WorkspaceId "/subscriptions/80e2f14d-d233-44b4-91f5-8ff143317bdb/resourceGroups/powershell-grp/providers/Microsoft.OperationalInsights/workspaces/vmworkspace342423" -Log $log -Metric $metric