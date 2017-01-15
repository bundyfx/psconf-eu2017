$ErrorActionPreference = 'Stop'

$Modules = Get-ChildItem .\developers-world\ -Filter '*.ps1' -Recurse -Exclude 'Install.ps1'
$Rules = Get-ScriptAnalyzerRule
Describe "Linting all .ps1 files" {
    foreach ($module in $modules) {
        Context "Testing Module | $($module.BaseName) for Standard Processing" {
            foreach ($rule in $rules) {
                It "Passes rule | $($Rule.rulename)" {
                    (Invoke-ScriptAnalyzer -Path $module.FullName -IncludeRule $rule.RuleName).Count | Should Be 0
                }
            }
        }
    }
}
