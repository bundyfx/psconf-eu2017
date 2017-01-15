#Store out current location
Push-Location

#Change direcotry to the directory with our COnfiguration Data
Set-Location .\developers-world\demo\ConfigurationData\

#Import that Hashtable data in with LocalizedData
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

#Return back to the pushed location
Pop-Location
