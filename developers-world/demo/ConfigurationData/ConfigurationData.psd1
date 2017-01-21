@{
    AllNodes = @(
        @{
            NodeName = "beertime"
            Role = "beertime"
            Packages = 'git','nodejs'
            DatadogURI = 'https://s3.amazonaws.com/ddagent-windows-stable/ddagent-cli.msi'
            DatadogTags = 'application:beertime','environment:production'
         },
        @{
            NodeName = "gopher-world"
            Role = "gopher-world"
            Packages = 'git','golang'
            DatadogURI = 'https://s3.amazonaws.com/ddagent-windows-stable/ddagent-cli.msi'
            DatadogTags = 'application:gopher-world','environment:production'
         }
    )
}
