$username = "user"
$password = "pass"
$machine = "machine_name"
$shareName = "Agent - LiveView"
$processName = "LiveView.Agent.exe"
$processDirectory = "LiveView.Agent\bin\Release\net462"
$sourceDirectory = "C:\Work\Sziltech\LiveView\$processDirectory"
$sourceConfigFile = "\\$machine\$shareName\$processName.config"
$destinationDirectory = "\\$machine\$shareName\$processDirectory"

$securePassword = ConvertTo-SecureString $password -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($username, $securePassword)

$processCheck = & $psexecPath -accepteula \\$machine -u $username -p $password tasklist | Select-String $processName
if ($processCheck) {
    & $psexecPath -accepteula \\$machine -u $username -p $password taskkill /IM $processName /F
}

Remove-Item -Path "$destinationDirectory\*" -Recurse -Force
Copy-Item -Path "$sourceDirectory\*" -Destination $destinationDirectory -Recurse -Force -Verbose
Copy-Item -Path $sourceConfigFile -Destination "$destinationDirectory\$processName.config" -Force -Verbose