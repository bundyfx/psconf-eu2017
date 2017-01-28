$Timestamp = Get-date -f yyyy_MM_dd-hh-mm-ss
Start-Transcript -Path C:\Userdata_$Timestamp.txt

#Move required modules into PSModulePath
Move-Item C:\windows\temp\cChoco\, C:\windows\temp\xPSDesiredStateConfiguration\ -Destination 'C:\Program Files\WindowsPowerShell\Modules\'

#Temp <== remove this line later and change it with getting own tag etc
Rename-Item C:\windows\temp\beertime.mof -NewName localhost.mof

# Open up any required Ports
netsh advfirewall firewall add rule name="Open Port 5000" dir=in action=allow protocol=TCP localport=5000

#Apply DSC Configuration
Start-DscConfiguration -path C:\windows\temp\ -Verbose -wait -force -ComputerName localhost

Set-Alias -name git -value 'C:\Program Files\Git\bin\git.exe'
Set-Alias -name npm -value 'C:\Program Files\nodejs\npm.cmd'

#Datadog install
& msiexec /qn /i C:\Windows\Temp\ddagent-cli.msi APIKEY="$Env:datadogAPIkey" HOSTNAME="$Env:ComputerName" TAGS="mytag1,mytag2"

#Clone repo and install node modules
& git clone https://github.com/bundyfx/psconf-eu2017-beertime.git C:\App
Set-Location C:\App
& npm install

#Stop all transcription
Stop-Transcript

#Write transcription to S3
Write-S3Object -BucketName powershell-dsc-mofs -File C:\Userdata_$Timestamp.txt

start npm start

exit 0
