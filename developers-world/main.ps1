powershell
break

Import-Module AWSPowerShell.NetCore
Set-DefaulAwsRegion -Region 'eu-west-1'

########################
###  Configuration   ###
########################

#See our newly put mofs.zip file
Get-S3Object -BucketName powershell-dsc-mofs


###################################
###  Infrastructure Deployment  ###
###################################

#Create new cloudformation stack
New-CFNStack -StackName Demo -TemplateURL "https://s3-eu-west-1.amazonaws.com/cf-templates-qaogskw029mf-eu-west-1/demo.yaml" -Region 'eu-west-1'
Get-CFNStack -StackName Demo

# 5 minutes

#Collect the DSC Output from S3 if debugging required
$DSCOutput = Get-S3Object -BucketName powershell-dsc-mofs
$DSCOutput.Where{$Psitem.Key -match 'txt'} | Foreach-Object { Copy-S3Object -BucketName powershell-dsc-mofs -Key $Psitem.Key -LocalFile "/Users/bundyfx/git/psconf-eu2017/$($psitem.Key)" }

Get-Childitem *.txt | Get-Content

########################
###  App Deployment  ###
########################

$Deploy = New-CDDeployment -ApplicationName beertime -GitHubLocation_Repository 'bundyfx/psconf-eu2017-beertime' -GitHubLocation_CommitId '04b43b136bfa4ff1e349f8b0ada6f29949613159' -DeploymentGroupName 'Production' -Revision_RevisionType Github
Get-CdDeployment $Deploy

#beertime dns name from load balancer
(Get-ELB2LoadBalancer).Dnsname | pbcopy

#Cleanup
Remove-CFNstack -StackName Demo -Region 'eu-west-1' -force
