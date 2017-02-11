$Timestamp = Get-date -f yyyy_MM_dd-hh-mm-ss
Start-Transcript -Path C:\Userdata_$Timestamp.txt

#Move required modules into PSModulePath
Move-Item C:\windows\temp\cChoco\, C:\windows\temp\xPSDesiredStateConfiguration\ -Destination 'C:\Program Files\WindowsPowerShell\Modules\'

#Install CodeDeploy Agent
Read-S3Object -BucketName aws-codedeploy-eu-west-1 -Key latest/codedeploy-agent.msi -File c:\windows\temp\codedeploy-agent.msi

#Installs CodeDeploy
Start-Process "c:\temp\codedeploy-agent.msi" -ArgumentList '/quiet' -NoNewWindow -Wait

#Temp <== remove this line later and change it with getting own tag etc
Rename-Item C:\windows\temp\beertime.mof -NewName localhost.mof

# Open up any required Ports
New-NetFirewallRule -DisplayName 'Application port' -Direction Inbound -LocalPort 5000 -Protocol TCP -Action Allow -Verbose

#Apply DSC Configuration
Start-DscConfiguration -path C:\windows\temp\ -Verbose -wait -force -ComputerName localhost

#Stop all transcription
Stop-Transcript

#Write transcription to S3
Write-S3Object -BucketName powershell-dsc-mofs -File C:\Userdata_$Timestamp.txt

