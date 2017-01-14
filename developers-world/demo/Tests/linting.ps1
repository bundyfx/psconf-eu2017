$Modules = Get-ChildItem $pwd.Path -Filter '*.ps*1' -Recurse
$Rules = Get-ScriptAnalyzerRule
Describe 'Testing all Modules in this Repo to be be correctly formatted' {
    foreach ($module in $modules) {
        Context "Testing Module  – $($module.BaseName) for Standard Processing" {
            foreach ($rule in $rules) {
                It "passes the PSScriptAnalyzer Rule $rule" {
                    (Invoke-ScriptAnalyzer -Path $module.FullName -IncludeRule $rule.RuleName ).Count | Should Be 0
                }
            }
        }
    }
}
