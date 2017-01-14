configuration Main
{

Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
Import-DscResource -Name MSFT_xRemoteFile -ModuleName xPSDesiredStateConfiguration

node $AllNodes.NodeName
    {
        switch ($Node.Role)
        {
            'yumtop-app'
            {
                xRemoteFile DownloadFile
                {
                    DestinationPath = "C:/Windows/Temp/$($node.nodeuri.Split('/')[-1])"
                    Uri = $node.nodeuri
                }
                Package PackageExample
                {
                    Ensure      = "Present"
                    Path        = "C:/Windows/Temp/$($node.nodeuri.Split('/')[-1])"
                    Name        = "Node.js"
                    ProductId   = $node.ProductId
                }
            }
        }
    }
}
