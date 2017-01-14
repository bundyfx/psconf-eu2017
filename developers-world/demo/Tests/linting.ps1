$Modules = Get-ChildItem $pwd.Path -Filter '*.ps1' -Recurse
$Rules = Get-ScriptAnalyzerRule
Describe "Linting all .ps1 files" {
    foreach ($module in $modules) {
        Context "Testing Module | $($module.BaseName) for Standard Processing" {
            foreach ($rule in $rules.Where{$Psitem.Rulename -ne 'PSAvoidUsingPositionalParameters'}) {
                It "Passes rule | $($Rule.rulename)" {
                    (Invoke-ScriptAnalyzer -Path $module.FullName -IncludeRule $rule.RuleName).Count | Should Be 0
                }
            }
        }
    }
}
