powershell
break
# AWS Console
# Appveyor Console
# Github

## Run new build of our Application in Appveyor
# 3 mins

Import-Module AWSPowerShell.NetCore
Set-DefaultAwsRegion -Region 'eu-west-1'

########################
###  Configuration   ###
########################

#See our newly put mofs.zip file
Get-S3Object -BucketName powershell-dsc-mofs


###################################
###  Infrastructure Deployment  ###
###################################

#Create new cloudformation stack
New-CFNStack -StackName Demo -TemplateURL "https://s3-eu-west-1.amazonaws.com/cf-templates-qaogskw029mf-eu-west-1/Demo.yaml" -Region 'eu-west-1'
Get-CFNStack -StackName Demo

# 5 minutes

#Collect the DSC Output from S3 if debugging required
$DSCOutput = Get-S3Object -BucketName powershell-dsc-mofs
$DSCOutput.Where{$Psitem.Key -match 'txt'} | Foreach-Object { Copy-S3Object -BucketName powershell-dsc-mofs -Key $Psitem.Key -LocalFile "/Users/bundyfx/git/psconf-eu2017/$($psitem.Key)" }

Get-Childitem *.txt | Get-Content

########################
###  App Deployment  ###
########################

$Deploy = New-CDDeployment -ApplicationName beertime -GitHubLocation_Repository 'bundyfx/psconf-eu2017-beertime' -GitHubLocation_CommitId '22b0869cc5d2ee0f33c188b573b54ee6ffbc325c' -DeploymentGroupName 'Production' -Revision_RevisionType Github
Get-CdDeployment $Deploy

#beertime dns name from load balancer
(Get-ELB2LoadBalancer).Dnsname | pbcopy

#Cleanup
Remove-CFNstack -StackName Demo -Region 'eu-west-1' -force
