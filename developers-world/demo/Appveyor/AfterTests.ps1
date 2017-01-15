#Import the Configuration Script
Import-Module '.\developers-world\demo\Generation\Mof\ConfigurationScript.ps1'

#Call The Configuration Script passing in our Configuration Data
Main -OutputPath $ProjectRoot -ConfigurationData '.\developers-world\demo\ConfigurationData\ConfigurationData.psd1'

#Create a Zip from the Mof output (Include Modules)
Get-Childitem -Path "$ProjectRoot\*.mof","$ProjectRoot\cChoco","$ProjectRoot\xPSDesiredStateConfiguration" -Recurse | Compress-Archive -DestinationPath $ProjectRoot -Verbose
