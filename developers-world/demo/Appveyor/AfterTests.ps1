$ErrorActionPreference = 'Stop'

 Import-Module '..\Generation\Mof\ConfigurationScript.ps1'
 Main -ConfigurationData '..\ConfigurationData\ConfigurationData.ps1' -OutputPath $PscScriptRoot
