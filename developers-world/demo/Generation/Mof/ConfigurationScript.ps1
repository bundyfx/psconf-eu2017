configuration Main
{

Param (
    $BeertimeAPIKey,
    $DatadogAPIKey
)

Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
Import-DscResource -ModuleName cChoco
Import-DscResource -Name MSFT_xRemoteFile, xEnvironment -ModuleName xPSDesiredStateConfiguration

node $AllNodes.NodeName
    {
        switch ($Node.Role)
        {
            'beertime'
            {
                Foreach ($Package in $node.Packages)
                {
                    cChocoPackageInstaller "$Package"
                    {
                      Name      = $Package
                      Ensure    = 'Present'
                    }
                }
                xRemoteFile datadog
                {
                    DestinationPath = 'C:\Windows\Temp\Datadog\ddagent-cli.msi'
                    Uri = $node.DatadogURI
                }
                Package datadogInstall
                {
                    Ensure      = "Present"
                    Path        = 'C:\Windows\Temp\Datadog\ddagent-cli.msi'
                    Name        = "Datadog"
                    Arguments   = "/qn /i APIKEY='$($DatadogAPIKey)' TAGS='$($Node.DatadogTags -join ',')'"
                    DependsOn   = "[xRemoteFile]datadog"
                    ProductId   = "341AEBAA-5553-4EE1-9ED5-C2D0436EE43D"
                }
                xEnvironment brewAPIkey
                {
                    Ensure = "Present"
                    Name = "apikey"
                    Value = $BeertimeAPIKey
                }
            }
            'gopher-world'
            {
                Foreach ($Package in $node.Packages)
                {
                    cChocoPackageInstaller "$Package"
                    {
                      Name   = $Package
                      Ensure = 'Present'
                    }
                }
                xRemoteFile datadog
                {
                    DestinationPath = 'C:\Windows\Temp\Datadog\ddagent-cli.msi'
                    Uri = $node.DatadogURI
                }
                Package datadogInstall
                {
                    Ensure      = "Present"
                    Path        = 'C:\Windows\Temp\Datadog\ddagent-cli.msi'
                    Name        = "Datadog"
                    Arguments   = "/qn /i APIKEY='$($DatadogAPIKey)' TAGS='$($Node.DatadogTags -join ',')'"
                    DependsOn   = "[xRemoteFile]datadog"
                    ProductId   = "341AEBAA-5553-4EE1-9ED5-C2D0436EE43D"
                }
            }
        }
    }
}
