Set-Location .\developers-world\demo\ConfigurationData\
Import-LocalizedData -BaseDirectory . -FileName ConfigurationData.psd1 -ov ConfigurationData | Out-Null

#Ensure Configuration Data is Valid
Describe "Valid Configuration Data" {
    It "Should be a valid Hashtable" {
        $ConfigurationData  | Should BeOfType Hashtable
    }
    It "All entries should contain a Role value" {
        $ConfigurationData.Values.Keys.Where{$Psitem -eq 'Role'}.Count | Should be $ConfigurationData.Values.Length
    }
}
