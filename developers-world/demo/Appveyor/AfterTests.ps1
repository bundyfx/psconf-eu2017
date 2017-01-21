#Import the Configuration Script
Import-Module '.\developers-world\demo\Generation\Mof\ConfigurationScript.ps1'

#Call The Configuration Script passing in our Configuration Data
Main -OutputPath $ProjectRoot -ConfigurationData '.\developers-world\demo\ConfigurationData\ConfigurationData.psd1' -BeertimeAPIKey $Env:BeertimeAPIKey -DatadogAPIKey $env:DatadogAPIKey

#Create a Zip from the Mof output (Include Modules)
Get-Item -Path "$ProjectRoot\yumtop.mof","$ProjectRoot\gopher-world.mof","$ProjectRoot\cChoco","$ProjectRoot\xPSDesiredStateConfiguration" | Compress-Archive -DestinationPath $ProjectRoot\Mofs.zip

#Publish zip as artifact
Push-AppveyorArtifact $ProjectRoot\Mofs.zip -Verbose
