<#
Command Reference
1. ConvertTo-SecureString
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/convertto-securestring?view=powershell-7.2

#>

# Here we are defining the application object properties
# Remember to change the AppId, AppSecret and TenantID values accordingly.

$AppId="977e8485-c970-43d6-bfc1-aceb97c6a5e4"
$AppSecret="OfR8Q~yqgRDq~xDWJQDBJhp~uEzuXVDx5jzYbc31"

# We need to convert the password to a secute string

$SecureSecret = $AppSecret | ConvertTo-SecureString -AsPlainText -Force

# We then create a new object to encapsulate the Application ID and secret

$Credential = New-Object -TypeName System.Management.Automation.PSCredential `
-ArgumentList $AppId,$SecureSecret

$TenantID="94cd7835-928e-41fd-b564-24c10c8ea009"

# We can then connnect to our Azure account via the use of the Service Principal

Connect-AzAccount -ServicePrincipal -Credential $Credential -Tenant $TenantID 

# Now go ahead and create the resource group

$ResourceGroupName ="powershell-grp"
$Location = "North Europe"
New-AzResourceGroup -Name $ResourceGroupName -Location $Location