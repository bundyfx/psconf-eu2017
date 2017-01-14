#Install the Nuget Package Provider to work with the PSGallery.
Install-PackageProvider Nuget -ForceBootstrap -Force

#Ensure the Repository is trusted.
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

#Install Any modules we need for our DSC Configuration and/or testing.
Install-Module Pester, PsScriptAnalyzer, xPSDesiredStateConfiguration -Force
