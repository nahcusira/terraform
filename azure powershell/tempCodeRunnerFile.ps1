Using Namespace Microsoft.Open.MSGraph.Model
$conditions = [ConditionalAccessConditionSet]@{
    Applications  = [ConditionalAccessApplicationCondition]@{
        IncludeApplications = 'All'
    }
    Users = [ConditionalAccessUserCondition]@{
        IncludeUsers = 'All'
    }
    ClientAppTypes = @('ExchangeActiveSync', 'Other')
}

$grantcontrols = [ConditionalAccessGrantControls]@{
    _Operator = 'OR'
    BuiltInControls = 'block'
}

$Params = @{
    DisplayName = "SEC001-Block-Legacy-Authentication-All-Apps";
    State = "EnabledForReportingButNotEnforced";
    Conditions = $conditions;
    GrantControls =$grantcontrols;  
}
New-AzureADMSConditionalAccessPolicy @Params