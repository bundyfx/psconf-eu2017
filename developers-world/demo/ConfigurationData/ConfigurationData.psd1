@{
    AllNodes = @(
        @{
            NodeName = "beertime"
            Role = "beertime"
            Packages = 'git','nodejs'
         },
        @{
            NodeName = "gopher-world"
            Role = "gopher-world"
            Packages = 'git','golang'
         }
    )
}
