$ErrorActionPreference = 'Stop'

Import-Module '.\developers-world\demo\Generation\Mof\ConfigurationScript.ps1'
Main -OutputPath $PSScriptRoot -ConfigurationData '.\developers-world\demo\ConfigurationData\ConfigurationData.psd1'
