configuration Main
{

Param (
    $BeertimeAPIKey = $Env:beertimeAPIkey
    $DatadogAPIKey = $Env:datadogAPIkey
)

Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
Import-DscResource -ModuleName cChoco
Import-DscResource -Name MSFT_xRemoteFile -ModuleName xPSDesiredStateConfiguration


node $AllNodes.NodeName
    {
        switch ($Node.Role)
        {
            'yumtop'
            {
                Foreach ($Package in $node.Packages)
                {
                    cChocoPackageInstaller ChocoPackages
                    {
                      Name        = $Package
                      AutoUpgrade = $True
                    }
                }
                xRemoteFile datadog
                {
                    DestinationPath = 'C:\Windows\Temp\Datadog\ddagent-cli.msi'
                    Uri = $node.DatadogURI
                }
                Package PackageExample
                {
                    Ensure      = "Present"
                    Path        = 'C:\Windows\Temp\Datadog\ddagent-cli.msi'
                    Name        = "Datadog"
                    ProductId   = "/qn /i APIKEY="$DatadogAPIKey" TAGS="$Node.DatadogTags""
                    DependsOn   = "[xRemoteFile]datadog"
                }
                xEnvironment brewAPIkey
                {
                    Ensure = "Present"
                    Name = "apikey"
                    Value = $YumtopAPIKey
                }
            }
            'gopher-world'
            {
                Foreach ($Package in $node.Packages)
                {
                    cChocoPackageInstaller ChocoPackages
                    {
                      Name        = $Package
                      AutoUpgrade = $True
                    }
                }
                xRemoteFile datadog
                {
                    DestinationPath = 'C:\Windows\Temp\Datadog\ddagent-cli.msi'
                    Uri = $node.DatadogURI
                }
                Package PackageExample
                {
                    Ensure      = "Present"
                    Path        = 'C:\Windows\Temp\Datadog\ddagent-cli.msi'
                    Name        = "Datadog"
                    ProductId   = "/qn /i APIKEY="$DatadogAPIKey" TAGS="$Node.DatadogTags""
                    DependsOn   = "[xRemoteFile]datadog"
                }
            }
        }
    }
}
