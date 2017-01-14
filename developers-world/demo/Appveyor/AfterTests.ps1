 ## After the tests have Run
 Import-Module '..\Generation\Mof\ConfigurationScript.ps1'
 Main -ConfigurationData '..\ConfigurationData\ConfigurationData.ps1' -OutputPath $PscScriptRoot
 ## Ziping
