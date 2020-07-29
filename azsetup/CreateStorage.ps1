$StorageAccountResourceGroup = "dev"
$StorageAccountName = "bgstaticwebsite"

$WebsiteLocalLocation = ".\content"
$IndexDocument = "index.html"
$404Document = "404.html"

#Storage Account Creation
$ResourceGroup = Get-AzResourceGroup -Name $StorageAccountResourceGroup
$StorageAccount = New-AzStorageAccount -Name $StorageAccountName -ResourceGroupName $StorageAccountResourceGroup -SkuName Standard_LRS -Location $ResourceGroup.Location

#Enable Azure StorageAccount Static Site
Enable-AzStorageStaticWebsite -Context $StorageAccount.Context -IndexDocument $IndexDocument -ErrorDocument404Path $404Document

#Upload WebContents
$WebsiteContents = Get-ChildItem -path $WebsiteLocalLocation -file -Recurse

foreach ($contents in $WebsiteContents) {

    if ($contents.extension -eq ".html") {
        $contentType = @{"ContentType"="text/html"}
    }

    if ($contents.extension -eq ".jpg") {
        $contentType = @{"ContentType"="image/jpeg"}
    }
 
    Set-AzStorageBlobContent -File "$WebsiteLocalLocation\$contents" -Container `$web -Blob $contents -Context $StorageAccount.Context -Force -Properties $contentType

}

#Website URL
"`r`n This is your static website: " + $StorageAccount.PrimaryEndpoints.Web
