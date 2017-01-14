$ErrorActionPreference = 'Stop'

 Import-Module '.\developers-world\demo\Generation\Mof\ConfigurationScript.ps1'
 Main -ConfigurationData '..\ConfigurationData\ConfigurationData.ps1' -OutputPath $PscScriptRoot
