$username = "user"
$password = "pass"
$machine = "machine_name"
$LiveViewAgentLocation = "D:\LiveView\LiveView.Agent\bin\Release\net462"
$psexecPath = "C:\PsExec\psexec.exe"
$processName = "LiveView.Agent.exe"

$processCheck = & $psexecPath -accepteula \\$machine -u $username -p $password tasklist | Select-String $processName
if ($processCheck) {
    & $psexecPath -accepteula \\$machine -u $username -p $password taskkill /IM $processName /F
}
& $psexecPath \\$machine -u $username -p $password "$LiveViewAgentLocation\$processName"