$Modules = Get-ChildItem $pwd.Path -Filter '*.ps1' -Recurse
Describe "Linting all .ps1 files" {
    foreach ($module in $modules) {
        It "Testing Module | $($module.BaseName)" {
                  (Invoke-ScriptAnalyzer -Path $module.FullName).Count | Should Be 0
            }
        }
    }
