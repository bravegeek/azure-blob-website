$StorageAccountResourceGroup = "dev"
$StorageAccountName = "bgstaticwebsite"

$CustomDomainName = "gregread.me"

$StorageAccount = Set-AzStorageAccount -Name $StorageAccountName -ResourceGroupName $StorageAccountResourceGroup -CustomDomainName $CustomDomainName -UseSubDomain $true

"`r`n This is your static website: " + $StorageAccount.PrimaryEndpoints.Web
"`r`n This is your custom domain: " + $StorageAccount.CustomDomain.Name
"`r`n"