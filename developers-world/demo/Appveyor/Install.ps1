Install-PackageProvider Nuget -ForceBootstrap -Force
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Module Pester, PsScriptAnalyzer, xPSDesiredStateConfiguration -Force 
