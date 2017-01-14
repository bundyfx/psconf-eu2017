configuration Main
{

Import-DscResource -Name MSFT_xRemoteFile -ModuleName xPSDesiredStateConfiguration

    node $AllNodes.Where{$Psitem.Role -eq "yumtop-app"}.NodeName
    {
        xRemoteFile DownloadFile
        {
            DestinationPath = "C:/Windows/Temp/$($nodeuri.Split('/')[-1])"
            Uri = $nodeuri
        }
        Package PackageExample
        {
            Ensure      = "Present"
            Path        = "C:/Windows/Temp/$($nodeuri.Split('/')[-1])"
            Name        = "Node.js"
            ProductId   = $ProductId
        }
    }
}
