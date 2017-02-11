#ensure empty bucket
Import-Module AWSPowerShell.NetCore

#See our newly put mofs.zip file
Get-S3Object -BucketName powershell-dsc-mofs

#Create new cloudformation stack
New-CFNStack -StackName Demo -TemplateURL "https://s3-eu-west-1.amazonaws.com/cf-templates-qaogskw029mf-eu-west-1/demo.yaml" -Region 'eu-west-1'

Get-CFNStack -StackName Demo

Remove-CFNstack -StackName Demo -Region 'eu-west-1' -force
