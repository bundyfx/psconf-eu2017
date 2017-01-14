$ErrorActionPreference = 'Stop'

#Create a new folder for Outputing the Mofs
$OutputPath = New-Item -Path (Join-Path $PSScriptRoot -ChildPath Output) -ItemType Directory

#Import the Configuration Script
Import-Module '.\developers-world\demo\Generation\Mof\ConfigurationScript.ps1'

#Call The Configuration Script passing in our Configuration Data
Main -OutputPath $OutputPath.Fullname -ConfigurationData '.\developers-world\demo\ConfigurationData\ConfigurationData.psd1'

#Create a Zip from the Mof output
Compress-Archive '.\developers-world\demo\Appveyor\Output' -DestinationPath '.\developers-world\demo\Generation\Mof\Output\Mofs.zip' -Verbose
