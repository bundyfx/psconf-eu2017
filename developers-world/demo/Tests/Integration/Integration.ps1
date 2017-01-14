Set-Location (Join-Path . -ChildPath 'developers-world\demo\ConfigurationData' -Resolve)

$ConfigurationData = Import-LocalizedData -Filename 'ConfigurationData.psd1'

#Ensure Configuration Data is Valid

Describe "Valid Configuration Data" {
    It "Should be a valid Hashtable" {
        { $ConfigurationData } | Should not throw
    }
    It "All entries should contain a Role value" {
        $ConfigurationData.Values | % {$Psitem.Keys.Where{$Psitem -eq 'Role'} | Should be $ConfigurationData.Values.Length}
    }
}
